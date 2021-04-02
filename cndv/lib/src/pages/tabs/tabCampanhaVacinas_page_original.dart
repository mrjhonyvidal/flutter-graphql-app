import 'package:cndv/src/models/example_model.dart';
import 'package:cndv/src/pages/campanhas/campanha_detalhe_page.dart';
import 'package:cndv/src/services/graphql/queries/campanhas.dart';
import 'package:cndv/src/widgets/card_campanhas.dart';
import 'package:cndv/src/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class TabCampanhaVacinas extends StatefulWidget {
  TabCampanhaVacinas({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TabCampanhaVacinas();
}

class _TabCampanhaVacinas extends State<TabCampanhaVacinas> {
  VoidCallback refetchQuery;
  List lessons;

  @override
  void initState(){
    super.initState();
    lessons = getLessons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _Header(parentContext: context),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: Query(
                  options: QueryOptions(
                    document: gql(Campanhas.getAllCampanhas),
                  ),
                  builder: (QueryResult result,
                      {VoidCallback refetch, FetchMore fetchMore}) {
                    refetchQuery = refetch;
                    if (result.hasException) {
                      return Text('Verifique por favor sua conexão de internet');
                    }
                    if (result.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final List<dynamic> completeCampanhas = result.data['obtenerCampanhas'] as List<dynamic>;

                    if (completeCampanhas != null &&
                        completeCampanhas.length > 0) {
                      List<Widget> campanhasMap = completeCampanhas
                          .map((campanha) => CardCampanha(
                                texto: campanha['nome'],
                                onPress: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CampanhaDetalhe(), fullscreenDialog: true));
                                },
                              ))
                          .toList();

                      return Column(
                        children: <Widget>[
                          //SizedBox( height: 80,),
                          ...campanhasMap
                        ],
                      );
                    } else {
                      return Center(
                          child: Container(
                              width: 250,
                              margin: EdgeInsets.only(top: 100),
                              child: Column(children: <Widget>[
                                Image(
                                  image: AssetImage(
                                      'assets/img/medical-report-blue.png'),
                                  width: 80,
                                ),
                                SizedBox(height: 10),
                                Text('Nenhuma campanha ativa no momento.',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black54)),
                              ])));
                    }
                  }),
            ),
          ),
        ],
      )),
      //child: HeadersCircleBorder(),
    );
  }
}

List getLessons() {
  return [
    ExampleModel(
        title: "Introduction to Driving",
        level: "Beginner",
        indicatorValue: 0.33,
        price: 20,
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    ExampleModel(
        title: "Observation at Junctions",
        level: "Beginner",
        indicatorValue: 0.33,
        price: 50,
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    ExampleModel(
        title: "Reverse parallel Parking",
        level: "Intermidiate",
        indicatorValue: 0.66,
        price: 30,
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    ExampleModel(
        title: "Reversing around the corner",
        level: "Intermidiate",
        indicatorValue: 0.66,
        price: 30,
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    ExampleModel(
        title: "Incorrect Use of Signal",
        level: "Advanced",
        indicatorValue: 1.0,
        price: 50,
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    ExampleModel(
        title: "Engine Challenges",
        level: "Advanced",
        indicatorValue: 1.0,
        price: 50,
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    ExampleModel(
        title: "Self Driving Car",
        level: "Advanced",
        indicatorValue: 1.0,
        price: 50,
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed.  ")
  ];
}

/// TODO extract this to common place as part of Header Layout as it's shared
/// between vacinas and campanhas tabCarteiraMedica
class _Header extends StatelessWidget {
  final BuildContext parentContext;

  const _Header({Key key, this.parentContext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Header(
            titulo: 'Próximas campanhas',
            subtitulo: 'Campanhas',
            iconHeader: FontAwesomeIcons.plus,
            color1: Colors.blueAccent,
            color2: Colors.blue,
            hasLink: false,
            iconCenter: FontAwesomeIcons.calendarAlt),
        Positioned(
          left: 30,
          top: 30,
          child: InkWell(
            onTap: () {
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
            top: 15,
            child: RawMaterialButton(
                shape: CircleBorder(),
                padding: EdgeInsets.all(15.0),
                child: FaIcon(FontAwesomeIcons.search,
                    color: Colors.white, size: 20),
                onPressed: () => _openDialogFilterCampaign(),
                ),
        )
      ],
    );
  }

  Future _openDialogFilterCampaign() async {
    SearchCampaingsParameters paramenters = await Navigator.of(parentContext).push(
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