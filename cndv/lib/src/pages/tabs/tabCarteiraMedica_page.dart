import 'package:cndv/src/data/tipo_vacina_fetch.dart';
import 'package:cndv/src/pages/mensagens/mensagem_notificacoes_page.dart';
import 'package:cndv/src/pages/perfil/editar_dados_pessoais_page.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:cndv/src/widgets/header.dart';
import 'package:cndv/src/services/rest/noticias_service.dart';
import 'package:cndv/src/widgets/lista_noticias_vacinas.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabCarteiraMedica extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // TODO obter dados da API de Dados Pessoais e Histórico de Vacinação do cidadão
    // A modo de exemplo, estamos consumindo a API de Noticias
    //final noticiasServiceHeadlines = Provider.of<NoticiasService>(context).headlines;
    //child: ListaNoticiasVacinas(noticiasServiceHeadlines),

    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _Header(),
            Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 300.0,
                        padding: EdgeInsets.symmetric(vertical: 30.0),
                        margin: EdgeInsets.only(bottom: 10),
                        alignment: Alignment.center,
                        child: Query(
                          options: QueryOptions(
                            document: gql(TipoVacinaFetch.fetchAll),
                          ),
                          builder: (QueryResult result, { VoidCallback refetch, FetchMore fetchMore}) {
                            if (result.hasException) {
                              return Text(result.exception.toString());
                            }

                            if (result.isLoading) {
                              return Text('Loading...');
                            }

                            final List<Object> tmpDataStructure = result.data['getCarteiraTipoVacinas'] as List<Object>;

                            return ListView.builder(
                                itemCount: tmpDataStructure.length,
                                itemBuilder: (context, index) {
                                  dynamic uniqueTmpDataStructure = tmpDataStructure[index];
                                  return Text(uniqueTmpDataStructure['descricao']);
                                });
                          },
                        )
                      ),
                    ],
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

/// TODO extract this to common place as part of Header Layout
/// as it's shared between vacinas and campanhas tabCampanhaVacinas
class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Header(
          titulo: 'Bem-vindo,',
          subtitulo: 'Carteira Nacional Digital de Vacinação',
          username: 'JVO',
          iconHeader: FontAwesomeIcons.plus,
          color1: Color(0xff526BF6),
          color2:  Color(0xff67ACF2),
          hasLink: true,
          urlRoute: EditarDadosPessoais(),
          iconCenter: Icons.account_box
        ),
        Positioned(
            right: 0,
            top:15,
            child: RawMaterialButton(
                shape: CircleBorder(),
                padding: EdgeInsets.all(10.0),
                child: FaIcon(Icons.message, color: Colors.white, size: 30),
                 onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context) => MensagensNotificacoes()));
                 }
            )
        )
      ],
    );
  }
}

