import 'package:cndv/src/pages/mensagens/mensagem_notificacoes_page.dart';
import 'package:cndv/src/pages/perfil/editar_dados_pessoais_page.dart';
import 'package:cndv/src/services/graphql/queries/historico_vacina.dart';
import 'package:cndv/src/storage/cndv_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:cndv/src/widgets/header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class TabCarteiraMedica extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cndvAuthSecureProvider = Provider.of<CNDVAuthSecureStorage>(context, listen: false);

    // TODO obter dados da API de Dados Pessoais e Histórico de Vacinação do cidadão
    // A modo de exemplo, estamos consumindo a API de Noticias
    //final noticiasServiceHeadlines = Provider.of<NoticiasService>(context).headlines;
    //child: ListaNoticiasVacinas(noticiasServiceHeadlines),
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _Header(
                usuarioNome: cndvAuthSecureProvider.usuarioAcesso.nome,
                parentContext: context
            ),
            Expanded(
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 0.0),
                          margin: EdgeInsets.only(bottom: 10),
                          alignment: Alignment.center,
                          child: Query(
                            options: QueryOptions(
                              document: gql(HistoricoVacina.getCidadaoHistoricoVacinacao),
                              variables: {
                                'cpf': cndvAuthSecureProvider.usuarioAcesso.cpf
                              }
                            ),
                            builder: (QueryResult result, { VoidCallback refetch, FetchMore fetchMore}) {
                              /// TODO check the use of refetch refetchQuery = refetch;
                              /*    if (result.hasException) {
                                return Text(
                                    result.exception.toString(),
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w600
                                    ),
                                );
                              }*/

                              if (result.isLoading) {
                                return new CircularProgressIndicator();
                              }

                              if (result.data != null ) {
                                final List<dynamic> completeHistoryVaccines = result.data['obtenerHistoricoVacinacao'] as List<dynamic>;

                                if (completeHistoryVaccines != null && completeHistoryVaccines.length > 0) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: completeHistoryVaccines.length,
                                      itemBuilder: (context, index) {
                                        final uniqueEntryHistory = completeHistoryVaccines[index];
                                        return _buildCard(uniqueEntryHistory);
                                      }
                                  );
                                }else{
                                  return Center(
                                    child: Container(
                                      width: 250,
                                      margin: EdgeInsets.only( top: 100),
                                      child: Column(
                                        children: <Widget>[
                                          Image( image: AssetImage('assets/img/medical-report-blue.png'), width: 80,),
                                          SizedBox(height: 10),
                                          Text('Nenhuma vacina tomada.', style: TextStyle(fontSize: 18, color: Colors.black54)),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              }

                              return Text('Histórico de vacinação vazio.');


                            },
                          )
                        ),
                      ],
                    ),
                  ),
                ),
            ),
          ],
        )
      ),
        //child: HeadersCircleBorder(),
      );
  }
}

Widget _buildCard(medicalEntry) => SizedBox(
    height: 350,
    child: Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('Tipo: ${medicalEntry['tipo_vacina_descricao']}',
                style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: Text('Código: ${medicalEntry['codigo']}'),
            leading: Icon(
              Icons.medical_services,
              color: Colors.blue[500],
            ),
          ),
          ListTile(
            title: Text('Data da aplicação: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(medicalEntry['dt_aplicacao']))}'),
            leading: Icon(
              Icons.date_range,
              color: Colors.blue[500],
            ),
          ),
          ListTile(
            title: Text('Dose: ${medicalEntry['tipo_dose_descricao']}'),
            leading: Icon(
              Icons.medical_services,
              color: Colors.blue[500],
            ),
          ),
          ListTile(
            title: Text('Aplicador: ${medicalEntry['nome_aplicador']}'),
            leading: Icon(
              Icons.contact_mail,
              color: Colors.blue[500],
            ),
          ),
          ListTile(
            title: Text('Unidade Saúde: ${medicalEntry['unidade_saude']}'),
            leading: Icon(
              Icons.place,
              color: Colors.blue[500],
            ),
          ),
        ],
      ),
    ),
);

/// TODO extract this to common place as part of Header Layout
/// as it's shared between vacinas and campanhas tabCampanhaVacinas
class _Header extends StatelessWidget {

  final String usuarioNome;
  final BuildContext parentContext;

  const _Header({Key key, this.usuarioNome, this.parentContext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Header(
          titulo: 'Bem-vindo ${this.usuarioNome},',
          subtitulo: 'Carteira Nacional Digital de Vacinação',
          username: 'JVO',
          iconHeader: FontAwesomeIcons.plus,
          color1: Colors.blue,
          color2:  Colors.blueAccent,
          hasLink: true,
          urlRoute: EditarDadosPessoais(),
          iconCenter: Icons.account_box
        ),
        Positioned(
          left: 30,
          top: 30,
          child: InkWell(
            onTap: (){
              Scaffold.of(this.parentContext).openDrawer();
            },
            child: Icon(
                FontAwesomeIcons.user,
                color: Colors.white,
                size: 20,
            ),
          ),
        ),
        Positioned(
            right: 0,
            top:15,
            child: RawMaterialButton(
                shape: CircleBorder(),
                padding: EdgeInsets.all(10.0),
                child: FaIcon(FontAwesomeIcons.bell, color: Colors.white, size: 20),
                 onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context) => MensagensNotificacoes()));
                 }
            )
        )
      ],
    );
  }
}

