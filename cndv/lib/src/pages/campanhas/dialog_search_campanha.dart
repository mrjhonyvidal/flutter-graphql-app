import 'package:cndv/src/services/graphql/queries/municipios_cidades.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class DialogSearchCampanha extends StatefulWidget {
  @override
  _DialogSearchCampanhaState createState() => new _DialogSearchCampanhaState();
}

class _DialogSearchCampanhaState extends State<DialogSearchCampanha> {

  final _formKey = GlobalKey<FormState>();
  int _selectedVacina = 1;

  List stateList = ["Selecione","AC","AL","AM","AP","BA","CE","DF","ES","GO","MA","MG","MS","MT","PA","PB","PE","PI","PR","RJ","RN","RO","RR","RS","SC","SE","SP","TO"];
  var _myState = 'Selecione';
  var _municipioSelected = 'Selecione';
  List<DropdownMenuItem<int>> tiposVacinas = [];
  VoidCallback refetchQuery;

  List<DropdownMenuItem<String>> getMunicipiosDropdown(List municipios) {
    List<DropdownMenuItem<String>> listOfMunicipios = new List();
    municipios?.forEach((municipio){
      listOfMunicipios.add(DropdownMenuItem(
        child: Text(municipio['cidade']),
        value: municipio['cidade'],
      ));
    });

    /// In order to control dynamically and have always an option inside the list
    listOfMunicipios.add(DropdownMenuItem(
      child: Text('Selecione'),
      value: 'Selecione',
    ));
    return listOfMunicipios;
  }

  List<DropdownMenuItem>getStateDropdown(List states){
    List<DropdownMenuItem<String>> listOfStates = new List();
    states.forEach((state) {
      listOfStates.add(DropdownMenuItem(
          child: Text(state),
          value: state
      ));
    });
    return listOfStates;
  }

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
    tiposVacinas.add(new DropdownMenuItem(
      child: new Text('Pneumocócica conjugada'),
      value: 7,
    ));
    tiposVacinas.add(new DropdownMenuItem(
      child: new Text('Meningocócica conjugada  C ou  ACWY'),
      value: 8,
    ));
    tiposVacinas.add(new DropdownMenuItem(
      child: new Text('Meningocócica B'),
      value: 9,
    ));
    tiposVacinas.add(new DropdownMenuItem(
      child: new Text('Poliomelite oral (vírus vivos atenuados)'),
      value: 10,
    ));
    tiposVacinas.add(new DropdownMenuItem(
      child: new Text('Influenza (gripe)'),
      value: 11,
    ));
    tiposVacinas.add(new DropdownMenuItem(
      child: new Text('Febre amarela'),
      value: 12,
    ));
    tiposVacinas.add(new DropdownMenuItem(
      child: new Text('Tríplice viral (sarampo, caxumba e rubéola)'),
      value: 13,
    ));
    tiposVacinas.add(new DropdownMenuItem(
      child: new Text('Varicela (catapora)'),
      value: 14,
    ));
    tiposVacinas.add(new DropdownMenuItem(
      child: new Text('Hepatite A'),
      value: 15,
    ));
    tiposVacinas.add(new DropdownMenuItem(
      child: new Text('HPV'),
      value: 16,
    ));
    tiposVacinas.add(new DropdownMenuItem(
      child: new Text('Pneumocócica 23 valente'),
      value: 17,
    ));
    tiposVacinas.add(new DropdownMenuItem(
      child: new Text('Herpes zóster'),
      value: 18,
    ));
    tiposVacinas.add(new DropdownMenuItem(
      child: new Text('Dengue'),
      value: 19,
    ));
  }

  bool _canSave = false;
  SearchCampanhasParameters _data = new SearchCampanhasParameters.empty();

  void _setCanSave(bool save) {
    if (save != _canSave)
      setState(() => _canSave = save);
  }

  @override
  Widget build(BuildContext context) {

    /// Initialize dropdown information
    loadTipoVacinas();

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
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            new TextField(
              decoration: const InputDecoration(
                labelText: "Idade Final",
              ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
            ),
            _inputUF(),
            _inputCidade()
          ].toList(),
        ),
      ),
    );
  }

  Widget _inputUF() {
    return Row(
        children: <Widget>[
          Text(
            'UF: ',
            style: TextStyle(),
          ),
          Expanded(
            child: DropdownButton(
              value: _myState,
              items: getStateDropdown(stateList),
              hint: Text('Selecione o estado (UF)'),
              onChanged: (opt) {
                setState((){
                  /// We set to null in order to avoid duplicated values
                  /// Avoid: There should be exactly one item with [DropdownButton]'
                  _municipioSelected = 'Selecione';
                  _myState = opt;
                });
              },
              isExpanded: true,
            ),
          ),
        ]);
  }

  Widget _inputCidade() {
    if(_myState != null ) {
      return Row(
        children: <Widget>[
          Text(
            'Município: ',
            style: TextStyle(),
          ),
          Expanded(
              child: Query(
                options: QueryOptions(
                    document: gql(MunicipiosCidades.getMunicipiosCidades),
                    variables: {'uf': _myState}),
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

                  if (result.data != null) {
                    List<dynamic> municipios = result.data['obtenerCidadesFilteredByUF'];


                    return DropdownButton(
                      value: _municipioSelected,
                      items: getMunicipiosDropdown(municipios),
                      hint: Text('Selecione o município'),
                      onChanged: (opt) {
                        setState(() {
                          _municipioSelected = opt;
                        });
                      },
                      isExpanded: true,
                    );
                  } else {
                    return DropdownButton(
                      items: [],
                      onChanged: (opt) {},
                      isExpanded: true,
                    );
                  }
                },
              ))
        ],
      );
    }else{
      return Row(
          children: <Widget>[
            Expanded(
                child: DropdownButton(
                  items: [],
                  hint: Text('Município - Selecione o estado(UF) antes'),
                  onChanged: (opt) {},
                ))
          ]);
    }
  }
}

class SearchCampanhasParameters {
  String tipo;
  int idade_inicio;
  int idade_final;
  String cidade;
  String uf;

  SearchCampanhasParameters(
      this.tipo,
      this.idade_inicio,
      this.idade_final,
      this.cidade,
      this.uf);

  SearchCampanhasParameters.empty() {
    tipo = "";
    idade_inicio = 0;
    idade_final= 199;
    cidade = "";
    uf = "";
  }
}