import 'package:cndv/src/models/campanhas_models.dart';
import 'package:cndv/src/models/cidadao_dados_pessoais_models.dart';
import 'package:cndv/src/pages/campanhas/campanha_detalhe_page.dart';
import 'package:cndv/src/pages/campanhas/dialog_search_campanha.dart';
import 'package:cndv/src/providers/CidadaoProvider.dart';
import 'package:cndv/src/storage/cndv_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:cndv/src/services/graphql/queries/campanhas.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


void main() => runApp(new TabCampanhas());

class TabCampanhas extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'CNDV',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
          primaryColor: Color.fromRGBO(58, 66, 86, 1.0), fontFamily: 'Raleway'),
      home: new ListPage(title: 'Campanhas'),
      // home: DetailPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  ListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  VoidCallback refetchQuery;
  Future<dynamic> _privateFutureInstance;
  List campanhas;
  int idade_inicio;
  int idade_final;
  String tipo;
  String uf;
  String cidade;
  int cidadaosAge;
  String cidadaoUF;
  String cidadaoCidade;

  @override
  void initState() {
    //lessons = getLessons();
    super.initState();
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int monthCurrentDate = currentDate.month;
    int monthBirthDate = birthDate.month;
    if(monthBirthDate > monthCurrentDate){
      age--;
    }else if(monthCurrentDate == monthBirthDate){
      int dayCurrentDate = currentDate.day;
      int dayBirthDate = birthDate.day;
      if (dayBirthDate > dayCurrentDate) {
        age--;
      }
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {

    final cndvAuthSecureProvider =
    Provider.of<CNDVAuthSecureStorage>(context, listen: true);

    //// TODO FIX why is being called so many times, alternatives
    CidadaoProvider cidadaoProvider = CidadaoProvider(cndvAuthSecureProvider.usuarioAcesso.cpf);

    cidadaoProvider.getDadosPessoais().then((result) {
      setState(() {
        cidadaosAge = calculateAge(DateTime.parse(result['obtenerDadosPessoais']['dt_nascimento']));
        cidadaoUF = result['obtenerDadosPessoais']['cidade'];
        cidadaoCidade = result['obtenerDadosPessoais']['uf'];
      });
    });

    ListTile makeListTile(SearchCampanhas campanha) => ListTile(
      contentPadding:
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24))),
        child: Icon(Icons.campaign, color: Colors.white),
      ),
      title: Text(
        campanha.nome,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

      subtitle: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                // tag: 'hero',
                child: LinearProgressIndicator(
                    backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                    value: 0.5,
                    valueColor: AlwaysStoppedAnimation(Colors.green)),
              )),
          Expanded(
            flex: 4,
            child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(campanha.uf,
                    style: TextStyle(color: Colors.white))),
          )
        ],
      ),
      trailing:
      Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CampanhaDetalhe(campanha: campanha)));
      },
    );

    Card makeCard(SearchCampanhas campanha) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.blueAccent ),
        child: makeListTile(campanha),
      ),
    );

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: Query(
        options: QueryOptions(
            document: gql(Campanhas.getSearchCampanhas),
            variables: { 'input': {
             "idade_inicio": (idade_inicio != null) ? idade_inicio : cidadaosAge,
              "uf": (uf != null) ? uf : cidadaoUF,
             "cidade": (cidade != null) ? cidade : cidadaoCidade
              /*"idade_inicio": 30,
              "uf": 'SP',
              "cidade": "BARUERI"*/
            }}
          ),
          builder: (QueryResult result,
              {VoidCallback refetch, FetchMore fetchMore}) {
                refetchQuery = refetch;

                if (result.hasException) {
                  return Text(
                    result.exception.toString(),
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.w600),
                  );
                }

                if (result.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                final List<dynamic> completeCampanhas = result.data['searchCampanhas'] as List<dynamic>;

                if (completeCampanhas != null && completeCampanhas.length > 0) {
                  List campanhasList = completeCampanhas.map((campanha) => new SearchCampanhas(
                    id: campanha['id'],
                    nome: campanha['nome'],
                    idadeInicio: campanha['idade_inicio'],
                    idadeFinal: campanha['idade_final'],
                    cidade: campanha['cidade'],
                    uf: campanha['uf'],
                    descricao: (campanha['descricao'] != null ) ? campanha['descricao'] : 'Nenhuma informação extra.'
                  )).toList();
                  //List campanhas = campanhasList.toJson()

                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: campanhasList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return makeCard(campanhasList[index]);
                    },
                  );
                } else {
                  return Center(
                      child: Container(
                          width: 250,
                          margin: EdgeInsets.only(top: 100),
                          child: Column(children: <Widget>[
                            Icon(Icons.calendar_today_outlined),
                            SizedBox(height: 10),
                            Text('Nenhuma campanha ativa no momento.',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black54)),
                          ])));
                }
          })
    );

    final makeBottom = Container(
      height: 55.0,
      child: BottomAppBar(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.blur_on, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.hotel, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.account_box, color: Colors.white),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Colors.white,
      title: Text(widget.title, style: TextStyle(color: Colors.black)),
      leading: new IconButton(
        icon: new Icon(Icons.person),
        color: Colors.blue,
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.filter_list),
          color: Colors.blue,
          onPressed: () => _openDialogFilterCampaign(),
        )
      ],
    );
    return Scaffold(
      appBar: topAppBar,
      body: makeBody,
    );
  }

  Future _openDialogFilterCampaign() async {
    SearchCampanhasParameters paramenters = await Navigator.of(context).push(
        new MaterialPageRoute<SearchCampanhasParameters>(builder: (BuildContext context) {
          return new DialogSearchCampanha();
        }, fullscreenDialog: true));

    // After Dialog Search Campanha results come back we update our List of Campanhas Widget
    setState((){

    });
  }
}