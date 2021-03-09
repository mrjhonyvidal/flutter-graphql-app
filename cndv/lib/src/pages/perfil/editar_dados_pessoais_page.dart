import 'package:flutter/material.dart';
import 'package:cndv/src/models/cidadao_dados_pessoais_models.dart';


class EditarDadosPessoais extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditarDadosPessoais();
}

class _EditarDadosPessoais extends State<EditarDadosPessoais> {

  final formKey = GlobalKey<FormState>();
  ObtenerDadosPessoais cidadao = new ObtenerDadosPessoais();

  @override
  Widget build(BuildContext context) {

    final CidadaoDadosPessoaisModel cidadaoModel = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff526BF6),
          title: Text('Dados Pessoais'),
          actions: <Widget>[
            IconButton(
              icon: Icon( Icons.photo_size_select_actual ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon( Icons.camera_alt ),
              onPressed: () {},
            )
          ]
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            child: Column(
              children: <Widget>[
                _inputNome(),
         /*       _inputRG(),
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
                _inputPais(),*/
                _submitButton(),
              ],
            )
          )
        )
      ),
    );
  }



  Widget _inputNome(){
    return TextFormField(
      initialValue: cidadao.nome,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Nome'
      ),
      onSaved: (value) => cidadao.nome = value,
      validator: (value) {
        if ( value.length < 3 ) {
          return 'Coloque o nome';
        } else {
          return null;
        }
      },
    );
  }

  Widget _inputRG(){
    return TextFormField(
      initialValue: cidadao.rg,
      keyboardType: TextInputType.number,
      onSaved: (value) => cidadao.rg = value,
      decoration: InputDecoration(
          labelText: 'RG'
      ),
    );
  }

  Widget _inputDataNascimento(){
    return TextFormField(
      initialValue: cidadao.dtNascimento.toString(),
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) => cidadao.dtNascimento = DateTime.parse(value),
      decoration: InputDecoration(
          labelText: 'Data Nascimento'
      ),
    );
  }

  Widget _inputEmail(){
    return TextFormField(
      initialValue: cidadao.email,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) => cidadao.email = value,
      decoration: InputDecoration(
          labelText: 'Email'
      ),
    );
  }

  Widget _inputTelefoneContato(){
    return TextFormField(
      initialValue: cidadao.contato,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) => cidadao.contato = value,
      decoration: InputDecoration(
          labelText: 'Telefone de contato'
      ),
    );
  }

  Widget _inputTipoSanguineo(){
    return TextFormField(
      initialValue: cidadao.idTipoSanguineo,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) => cidadao.idTipoSanguineo = value,
      decoration: InputDecoration(
          labelText: 'Tipo Sanguineo'
      ),
    );
  }

  Widget _inputDoador(){
    return TextFormField(
      initialValue: cidadao.doador,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) => cidadao.doador = value,
      decoration: InputDecoration(
          labelText: 'Doador'
      ),
    );
  }

  Widget _inputCep(){
    return TextFormField(
      initialValue: cidadao.cep,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) => cidadao.cep = value,
      decoration: InputDecoration(
          labelText: 'CEP'
      ),
    );
  }

  Widget _inputEndereco(){
    return TextFormField(
      initialValue: cidadao.endereco,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) => cidadao.endereco = value,
      decoration: InputDecoration(
          labelText: 'Endereço'
      ),
    );
  }

  Widget _inputNumero(){
    return TextFormField(
      initialValue: cidadao.numero,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) => cidadao.numero = value,
      decoration: InputDecoration(
          labelText: 'Complemento'
      ),
    );
  }

  Widget _inputBairro(){
    return TextFormField(
      initialValue: cidadao.bairro,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) => cidadao.bairro = value,
      decoration: InputDecoration(
          labelText: 'Bairro'
      ),
    );
  }

  Widget _inputCidade(){
    return TextFormField(
      initialValue: cidadao.cidade,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) => cidadao.cidade = value,
      decoration: InputDecoration(
          labelText: 'Cidade'
      ),
    );
  }

  Widget _inputUF(){
    return TextFormField(
      initialValue: cidadao.uf,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) => cidadao.uf = value,
      decoration: InputDecoration(
          labelText: 'Cidade'
      ),
    );
  }

  Widget _inputPais(){
    return TextFormField(
      initialValue: cidadao.pais,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) => cidadao.pais = value,
      decoration: InputDecoration(
          labelText: 'País'
      ),
    );
  }

  Widget _submitButton(){
    return RaisedButton.icon(
      label: Text('Modificar'),
      icon: Icon( Icons.save),
      color: Colors.blue,
      textColor: Colors.white,
      onPressed: _submit,
    );
  }

  void _submit() {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    print(cidadao.nome);
  }


}
