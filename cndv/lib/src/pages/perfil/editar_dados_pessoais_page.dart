import 'package:cndv/src/helpers/show_validations_alert_msg.dart';
import 'package:cndv/src/models/cidadao_dados_pessoais_models.dart';
import 'package:cndv/src/services/graphql/mutations/edit_dados_pessoais.dart';
import 'package:cndv/src/services/graphql/queries/dados_pessoais.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class EditarDadosPessoais extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditarDadosPessoais();
}

class _EditarDadosPessoais extends State<EditarDadosPessoais> {
  final formKey = GlobalKey<FormState>();
  ObtenerDadosPessoais cidadao;
  VoidCallback refetchQuery;

  String _selectedTipoSanguineo = 'A+';
  List<DropdownMenuItem<String>> tipoSanguineoList = [];

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
                              _inputBairro(),
                              _inputCidade(),
                              _inputUF(),
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

  Widget _inputDataNascimento() {
    return TextFormField(
      initialValue: cidadao.dtNascimento.toString(),
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) => cidadao.dtNascimento = DateTime.parse(value),
      decoration: InputDecoration(labelText: 'Data Nascimento'),
    );
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
      hint: new Text('Selecione'),
      items: tipoSanguineoList,
      value: cidadao.idTipoSanguineo,
      onChanged: (value) {
        setState(() {
            cidadao.idTipoSanguineo = value;
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

  Widget _inputCidade() {
    return TextFormField(
      initialValue: cidadao.cidade,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) => cidadao.cidade = value,
      decoration: InputDecoration(labelText: 'Cidade'),
    );
  }

  Widget _inputUF() {
    return TextFormField(
      initialValue: cidadao.uf,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) => cidadao.uf = value,
      decoration: InputDecoration(labelText: 'Cidade'),
    );
  }

  Widget _inputPais() {
    return TextFormField(
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
          return RaisedButton.icon(
              label: Text('Modificar'),
              icon: Icon(Icons.save),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                formKey.currentState.save();

                runMutation({
                  "cpf": cidadao.cpf,
                  "input": {
                    "rg": cidadao.rg,
                    "nome": cidadao.nome,
                    "dt_nascimento": "2018-01-01",
                    "email": cidadao.email,
                    "contato": cidadao.contato,
                    "id_tipo_sanguineo": cidadao.idTipoSanguineo,
                    "doador": cidadao.doador,
                    "numero": cidadao.numero,
                    "complemento": cidadao.complemento,
                    "bairro": cidadao.bairro,
                    "cidade": cidadao.cidade,
                    "uf": cidadao.uf,
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
