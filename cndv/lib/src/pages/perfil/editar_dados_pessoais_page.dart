import 'package:cndv/src/models/cidadao_dados_pessoais_models.dart';
import 'package:cndv/src/services/graphql/mutations/edit_dados_pessoais.dart';
import 'package:cndv/src/services/graphql/queries/dados_pessoais.dart';
import 'package:cndv/src/services/graphql/queries/municipios_cidades.dart';
import 'package:cndv/src/widgets/blue_button.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

class EditarDadosPessoais extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditarDadosPessoais();
}

class _EditarDadosPessoais extends State<EditarDadosPessoais> {

  final formKey = GlobalKey<FormState>();
  ObtenerDadosPessoais cidadao;
  DateTime selectedNascimentoDate;
  ValueChanged<DateTime> selectDate;
  VoidCallback refetchQuery;
  String _selectedTipoSanguineo = 'A+';
  List<DropdownMenuItem<String>> tipoSanguineoList = [];

  List stateList = ["AC","AL","AM","AP","BA","CE","DF","ES","GO","MA","MG","MS","MT","PA","PB","PE","PI","PR","RJ","RN","RO","RR","RS","SC","SE","SP","TO"];
  String _myState;
  var _municipioSelected;

  @override
  void initState() {
    super.initState();
  }

  List<DropdownMenuItem<String>> getMunicipiosDropdown(List municipios) {
    List<DropdownMenuItem<String>> listOfMunicipios = new List();
      municipios?.forEach((municipio){
      listOfMunicipios.add(DropdownMenuItem(
        child: Text(municipio['cidade']),
        value: municipio['cidade'],
      ));
    });
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

  TextEditingController dtNascimentoEditingController = new TextEditingController();

  void loadTipoSanguineoList() {
    tipoSanguineoList = [];
    tipoSanguineoList.add(new DropdownMenuItem(
      child: new Text('A-'),
      value: 'A-',
    ));
    tipoSanguineoList.add(new DropdownMenuItem(
      child: new Text('A+'),
      value: 'A+',
    ));
    tipoSanguineoList.add(new DropdownMenuItem(
      child: new Text('AB+'),
      value: 'AB-',
    ));
    tipoSanguineoList.add(new DropdownMenuItem(
      child: new Text('B+'),
      value: 'B-',
    ));
    tipoSanguineoList.add(new DropdownMenuItem(
      child: new Text('O+'),
      value: 'O-',
    ));
  }

  @override
  Widget build(BuildContext context) {
    final Map cidadaoCPF = ModalRoute.of(context).settings.arguments;
    loadTipoSanguineoList();

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff526BF6),
          title: Text('Dados Pessoais'),
          actions: <Widget>[]),
      body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(15.0),
              child: Query(
                  options: QueryOptions(
                      document: gql(DadosPessoais.getDadosPessoaisByCPF),
                      variables: {'cpf': cidadaoCPF['cpf']}),
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
                      cidadao = ObtenerDadosPessoais.fromJson(
                          result.data['obtenerDadosPessoais']);

                      /// Initialize default values for Date and Location
                      dtNascimentoEditingController.text = DateFormat('dd/MM/yyyy').format(selectedNascimentoDate ?? cidadao.dtNascimento);
                      _myState = _myState ?? cidadao.uf;

                      return Form(
                          key: formKey,
                          child: Column(
                            children: <Widget>[
                              _inputNome(),
                              _inputRG(),
                              _inputDataNascimento(),
                              _inputEmail(),
                              _inputTelefoneContato(),
                              _inputTipoSanguineo(),
                              _inputDoador(),
                              _inputCep(),
                              _inputEndereco(),
                              _inputNumero(),
                              _inputComplemento(),
                              _inputBairro(),
                              _inputUF(),
                              _inputCidade(),
                              _inputPais(),
                              _submitButton(),
                            ],
                          ));
                    } else {
                      return null;
                    }
                  }))),
    );
  }

  Widget _inputNome() {
    return TextFormField(
      initialValue: cidadao.nome,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Nome'),
      onSaved: (value) => cidadao.nome = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Coloque o nome';
        } else {
          return null;
        }
      },
    );
  }

  Widget _inputRG() {
    return TextFormField(
      initialValue: cidadao.rg,
      keyboardType: TextInputType.number,
      onSaved: (value) => cidadao.rg = value,
      decoration: InputDecoration(labelText: 'RG'),
    );
  }

  Widget _inputDataNascimento(){
    return TextFormField(
      controller: dtNascimentoEditingController,
      onTap: () async {
        FocusScope.of(context).requestFocus(new FocusNode());
        // Show Date Picker here
        await _selectDate(context);
        dtNascimentoEditingController.text = DateFormat('dd/MM/yyyy').format(selectedNascimentoDate);
      },
      readOnly: true,
      decoration: InputDecoration(labelText: 'Data Nascimento'),
    );
  }

   Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedNascimentoDate ?? DateTime.now(),
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2101));
    if (pickedDate != null && pickedDate != selectedNascimentoDate)
      setState(() {
        selectedNascimentoDate = pickedDate;
      });
  }

  Widget _inputEmail() {
    return TextFormField(
      initialValue: cidadao.email,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) => cidadao.email = value,
      decoration: InputDecoration(labelText: 'Email'),
    );
  }

  Widget _inputTelefoneContato() {
    return TextFormField(
      initialValue: cidadao.contato,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) => cidadao.contato = value,
      decoration: InputDecoration(labelText: 'Telefone de contato'),
    );
  }

  Widget _inputTipoSanguineo(){
    return DropdownButton(
      hint: new Text('Selecione o tipo sanguineo'),
      items: tipoSanguineoList,
      value: _selectedTipoSanguineo,
      onChanged: (value) {
        setState(() {
          _selectedTipoSanguineo = value;
        });
      },
      isExpanded: true,
    );
  }

  Widget _inputDoador() {
    return TextFormField(
      initialValue: cidadao.doador,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) => cidadao.doador = value,
      decoration: InputDecoration(labelText: 'Doador'),
    );
  }

  Widget _inputCep() {
    return TextFormField(
      initialValue: cidadao.cep,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) => cidadao.cep = value,
      decoration: InputDecoration(labelText: 'CEP'),
    );
  }

  Widget _inputEndereco() {
    return TextFormField(
      initialValue: cidadao.endereco,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) => cidadao.endereco = value,
      decoration: InputDecoration(labelText: 'Endereço'),
    );
  }

  Widget _inputNumero() {
    return TextFormField(
      initialValue: cidadao.numero,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) => cidadao.numero = value,
      decoration: InputDecoration(labelText: 'Número'),
    );
  }

  Widget _inputComplemento() {
    return TextFormField(
      initialValue: cidadao.complemento,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) => cidadao.complemento = value,
      decoration: InputDecoration(labelText: 'Complemento'),
    );
  }

  Widget _inputBairro() {
    return TextFormField(
      initialValue: cidadao.bairro,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) => cidadao.bairro = value,
      decoration: InputDecoration(labelText: 'Bairro'),
    );
  }

  Widget _inputUF() {
    return Row(
      children: <Widget>[
        Expanded(
         child: DropdownButton(
            value: _myState,
            items: getStateDropdown(stateList),
            hint: Text('Selecione o estado (UF)'),
            onChanged: (opt) {
              setState((){
                /// We set to null in order to avoid duplicated values
                /// Avoid: There should be exactly one item with [DropdownButton]'
                _municipioSelected = null;
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

  Widget _inputPais() {
    return TextFormField(
      enabled: false,
      style: TextStyle(color: Colors.grey),
      initialValue: cidadao.pais,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) => cidadao.pais = value,
      decoration: InputDecoration(labelText: 'País'),
    );
  }

  Widget _submitButton() {
    return Mutation(
        options: MutationOptions(
            document: gql(DadosPessoaisMutations.editarDadosPessoaisByCPF),
            fetchPolicy: FetchPolicy.noCache,
            onCompleted: (dynamic resultData) {
              ///if (resultData != null) {
              refetchQuery();
              /*   Navigator.pushReplacementNamed(context, 'tabs');
              } else {
                showValidationsAlertMsg(context, 'Dados incorretos!',
                    'Revise por favor que todos os campos sejam completados.');
              }*/
            }),
        builder: (RunMutation runMutation, QueryResult result) {
          return BlueButton(
              text: 'Modificar',
              onPressed: () {
                formKey.currentState.save();
                runMutation({
                    "cpf": cidadao.cpf,
                    "input": {
                      "rg": cidadao.rg,
                      "nome": cidadao.nome,
                      "dt_nascimento": DateFormat('yyyy-MM-dd').format(selectedNascimentoDate) ?? DateFormat('yyyy-MM-dd').format(DateTime.now()),
                      "email": cidadao.email,
                      "contato": cidadao.contato,
                      "id_tipo_sanguineo": _selectedTipoSanguineo,
                      "doador": cidadao.doador,
                      "endereco": cidadao.endereco,
                      "numero": cidadao.numero,
                      "complemento": cidadao.complemento,
                      "bairro": cidadao.bairro,
                      "cidade": _municipioSelected,
                      "uf": _myState,
                      "pais": cidadao.pais,
                      "cep": cidadao.cep
                    }
                  },
                );
              });
        }
    );
  }
}
