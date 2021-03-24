import 'package:cndv/src/models/campanhas_models.dart';
import 'package:cndv/src/pages/campanhas/campanha_detalhe_page.dart';
import 'package:flutter/material.dart';
import 'package:cndv/src/services/graphql/queries/campanhas.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


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
  List campanhas;

  @override
  void initState() {
    //lessons = getLessons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    ListTile makeListTile(ObtenerCampanha campanha) => ListTile(
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

    Card makeCard(ObtenerCampanha campanha) => Card(
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
        document: gql(Campanhas.getAllCampanhas),
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

                final List<dynamic> completeCampanhas = result.data['obtenerCampanhas'] as List<dynamic>;

                if (completeCampanhas != null &&  completeCampanhas.length > 0) {
                  List campanhasList = completeCampanhas.map((campanha) => new ObtenerCampanha(
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
    SearchCampaingsParameters paramenters = await Navigator.of(context).push(
        new MaterialPageRoute<SearchCampaingsParameters>(builder: (BuildContext context) {
          return new DialogSearchCampaign();
        }, fullscreenDialog: true));

    /*setState((){
      /// TODO _items.add(data);
    });*/
  }
}

class DialogSearchCampaign extends StatefulWidget {
  @override
  _DialogSearchCampaignState createState() => new _DialogSearchCampaignState();
}

class _DialogSearchCampaignState extends State<DialogSearchCampaign> {

  final _formKey = GlobalKey<FormState>();
  int _selectedVacina = 1;
  String _selectedCidade = "BARUERI";
  String _selectedUF = 'SP';

  List<DropdownMenuItem<int>> tiposVacinas = [];
  List<DropdownMenuItem<String>> cidades = []; /// Get from DB via Apollo query
  List<DropdownMenuItem<String>> ufs = [];

  void loadTipoVacinas() {
    tiposVacinas = [];
    tiposVacinas.add(new DropdownMenuItem(
      child: new Text('BCG ID'),
      value: 1,
    ));
    tiposVacinas.add(new DropdownMenuItem(
      child: new Text('Hepatite B'),
      value: 2,
    ));
    tiposVacinas.add(new DropdownMenuItem(
      child: new Text('Rotavírus'),
      value: 3,
    ));
    tiposVacinas.add(new DropdownMenuItem(
      child: new Text('Tríplice Bacteriana  (DTPw, DTPa ou dTPa)'),
      value: 4,
    ));
    tiposVacinas.add(new DropdownMenuItem(
      child: new Text('Haemoplilus influenze tipo B'),
      value: 5,
    ));
    tiposVacinas.add(new DropdownMenuItem(
      child: new Text('Poliomielite (vírus inativos)'),
      value: 6,
    ));
  }

  void loadCidades() {
    cidades = [];
    cidades.add(new DropdownMenuItem(
      child: new Text('ACRELÂNDIA'),
      value: "ACRELÂNDIA",
    ));
    cidades.add(new DropdownMenuItem(
      child: new Text('ASSIS BRASIL'),
      value: "ASSIS BRASIL",
    ));
    cidades.add(new DropdownMenuItem(
      child: new Text('PARAMIRIM'),
      value: "PARAMIRIM",
    ));
    cidades.add(new DropdownMenuItem(
      child: new Text('PAULICÉIA'),
      value: "PAULICÉIA",
    ));
    cidades.add(new DropdownMenuItem(
      child: new Text('BARUERI'),
      value: "BARUERI",
    ));
    cidades.add(new DropdownMenuItem(
      child: new Text('BRODOWSKI'),
      value: "BRODOWSKI",
    ));
  }

  void loadUF() {
    ufs = [];
    ufs.add(new DropdownMenuItem(
      child: new Text('AMAPÁ'),
      value: "AP",
    ));
    ufs.add(new DropdownMenuItem(
      child: new Text('DISTRITO FEDERAL'),
      value: "DF",
    ));
    ufs.add(new DropdownMenuItem(
      child: new Text('MATO GROSSO'),
      value: 'MT',
    ));
    ufs.add(new DropdownMenuItem(
      child: new Text('SANTA CATARINA'),
      value: 'SC',
    ));
    ufs.add(new DropdownMenuItem(
      child: new Text('SÃO PAULO'),
      value: 'SP',
    ));
  }


  bool _canSave = false;
  SearchCampaingsParameters _data = new SearchCampaingsParameters.empty();

  void _setCanSave(bool save) {
    if (save != _canSave)
      setState(() => _canSave = save);
  }

  @override
  Widget build(BuildContext context) {

    /// Initialize dropdown information
    loadTipoVacinas();
    loadCidades();
    loadUF();


    final ThemeData theme = Theme.of(context);

    return new Scaffold(
      appBar: new AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Filtrar Campanhas'),
          actions: <Widget> [
            new FlatButton(
                child: new Text('Buscar', style: theme.textTheme.body1.copyWith(color: _canSave ? Colors.white : new Color.fromRGBO(255, 255, 255, 0.5))),
                onPressed: _canSave ? () { Navigator.of(context).pop(_data); } : null
            )
          ]
      ),
      body: new Form(
        key: _formKey,
        child: new ListView(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          children: <Widget>[
            new DropdownButton(
              hint: Text('Selecione tipo de vacina'),
              items: tiposVacinas,
              value: _selectedVacina,
              onChanged: (value) {
                setState(() {
                  _selectedVacina = value;
                });
              }, isExpanded: true,
            ),
            new TextField(
              decoration: const InputDecoration(
                labelText: "Idade Inicio",
              ),
              keyboardType: TextInputType.number,
              onChanged: (String value) {
                _data.tipo = value;
                _setCanSave(value.isNotEmpty);
              },
            ),
            new TextField(
              decoration: const InputDecoration(
                labelText: "Idade Final",
              ),
              keyboardType: TextInputType.number,
              onChanged: (String value) {
                _data.tipo = value;
                _setCanSave(value.isNotEmpty);
              },
            ),
            new DropdownButton(
              hint: Text('Selecione a cidade'),
              items: cidades,
              value: _selectedCidade,
              onChanged: (value) {
                setState(() {
                  _data.cidade = value;
                });
              }, isExpanded: true,
            ),
            new DropdownButton(
              hint: Text('Selecione o estado'),
              items: ufs,
              value: _selectedUF,
              onChanged: (value) {
                setState(() {
                  _data.uf = value;
                });
              }, isExpanded: true,
            ),
          ].toList(),
        ),
      ),
    );
  }
}

class SearchCampaingsParameters {
  String tipo;
  int idade_inicio;
  int idade_final;
  String cidade;
  String uf;

  SearchCampaingsParameters(
      this.tipo,
      this.idade_inicio,
      this.idade_final,
      this.cidade,
      this.uf);

  SearchCampaingsParameters.empty() {
    tipo = "";
    idade_inicio = 0;
    idade_final= 199;
    cidade = "";
    uf = "";
  }
}