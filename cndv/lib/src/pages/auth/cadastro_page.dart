import 'package:cndv/src/helpers/show_validations_alert_msg.dart';
import 'package:cndv/src/services/graphql/mutations/auth_token_registration_usuario.dart';
import 'package:cndv/src/services/graphql/queries/municipios_cidades.dart';
import 'package:cndv/src/widgets/blue_button.dart';
import 'package:cndv/src/widgets/custom_input.dart';
import 'package:cndv/src/widgets/labels.dart';
import 'package:cndv/src/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Cadastro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
            child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: ListView(
              children: <Widget>[
                Logo(),
                Form(),
                Labels(
                    message: 'Termos de uso e condições de uso.',
                    callToActionText: 'Entrar na minha CNDV',
                    route: 'login')
              ],
            ),
          ),
        )));
  }
}

class Form extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<Form> {

  final formKey = GlobalKey<FormState>();
  DateTime selectedNascimentoDate;
  ValueChanged<DateTime> selectDate;
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final cpfCtrl = TextEditingController();
  final nomeCtrl = TextEditingController();
  final dtNascimentoCtrl = TextEditingController();
  VoidCallback refetchQuery;
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: SafeArea(
        child: Container(
        margin: EdgeInsets.only(top: 40),
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CustomInput(
                icon: Icons.perm_contact_cal_outlined,
                placeholder: 'CPF',
                keyboardType: TextInputType.number,
                textController: cpfCtrl,
                textInputFormatter: MaskTextInputFormatter(mask: "###.###.###-##")),
            CustomInput(
              icon: Icons.person,
              placeholder: 'Nome',
              keyboardType: TextInputType.text,
              textController: nomeCtrl,
              textInputFormatter: MaskTextInputFormatter(mask: ""),
              textLength: 50,
            ),
            Container(
              padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: Offset(0, 5),
                        blurRadius: 5)
                  ]),
              child: TextFormField(
                controller: dtNascimentoCtrl,
                onTap: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());
                   // Show Date Picker here
                  await _selectDate(context);
                  dtNascimentoCtrl.text = DateFormat('dd/MM/yyyy').format(selectedNascimentoDate);
                },
                readOnly: true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Data Nascimento',
                    prefixIcon: Icon(Icons.calendar_today_outlined),
                    focusedBorder: InputBorder.none,
                )
              ),
            ),
             Container(
             padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
             margin: EdgeInsets.only(bottom: 20),
             decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(30),
                 boxShadow: <BoxShadow>[
                   BoxShadow(
                       color: Colors.black.withOpacity(0.05),
                       offset: Offset(0, 5),
                       blurRadius: 5)
                 ]),
             child: Row(
              children: <Widget>[
                Expanded(
                  child: DropdownButton(
                    underline: SizedBox(),
                    value: _myState,
                    items: getStateDropdown(stateList),
                    hint: Center(child: Text('Selecione o UF')),
                    onChanged: (opt) {
                      setState((){
                        _municipioSelected = null;
                        _myState = opt;
                      });
                    },
                    isExpanded: true,
                  ),
                ),
              ]),
             ),
            _inputCidade(),
            CustomInput(
              icon: Icons.mail_outline,
              placeholder: 'Email',
              keyboardType: TextInputType.emailAddress,
              textController: emailCtrl,
              textInputFormatter: MaskTextInputFormatter(mask: ""),
              textLength: 100,
            ),
            CustomInput(
              icon: Icons.lock_outline,
              placeholder: 'Senha',
              keyboardType: TextInputType.text,
              textController: passCtrl,
              textInputFormatter: MaskTextInputFormatter(mask: ""),
              textLength: 16,
              isPassword: true,
            ),
            Mutation(
                options: MutationOptions(
                    document: gql(authTokenRegistrationUsuario.registerNewUser),
                    update: (GraphQLDataProxy cache, QueryResult result) {
                      return cache;
                    },
                    onError: (err) {
                      print(err);
                    },
                    onCompleted: (dynamic resultData) {
                      if (resultData != null) {
                        showValidationsAlertMsg(
                          context,
                          'Cadastro realizado com sucesso!',
                          'Você receberá um email com mais instruções de uso.');
                        Navigator.pushReplacementNamed(context, 'login');
                      } else {
                        showValidationsAlertMsg(
                            context,
                            'Dados de cadastrao incorretos!',
                            'Por favor revise e complete todos os campos antes de tentar novamente.');
                      }
                    }),
                builder: (RunMutation runMutation, QueryResult result) {
                  return BlueButton(
                    text: 'Cadastrar-se',
                    onPressed: () => runMutation({
                      'cpf': cpfCtrl.text,
                      'nome': nomeCtrl.text,
                      'senha': passCtrl.text,
                      'email': emailCtrl.text,
                      "dt_nascimento": DateFormat('yyyy-MM-dd').format(selectedNascimentoDate),
                      "uf": _myState,
                      "cidade": _municipioSelected
                    }),
                  );
                })
          ],
        ),
      ),
     ),
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
        print(pickedDate);
        selectedNascimentoDate = pickedDate;
      });
  }

  Widget _inputCidade() {
    if(_myState != null ) {
      return Container(
        padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: Offset(0, 5),
                  blurRadius: 5)
            ]),
        child: Row(
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
                    return Text('Verifique por favor sua conexão de internet');
                  }

                  if (result.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (result.data != null) {
                    List<dynamic> municipios = result.data['obtenerCidadesFilteredByUF'];

                    return DropdownButton(
                      value: _municipioSelected,
                      underline: SizedBox(),
                      items: getMunicipiosDropdown(municipios),
                      hint: Center(child: Text('Selecione o município')),
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
       ),
      );
    }else{
      return Container(
        padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: Offset(0, 5),
                  blurRadius: 5)
            ]),
          child: Row(
          children: <Widget>[
            Expanded(
                child: DropdownButton(
                  items: [],
                  underline: SizedBox(),
                  hint: Center(child: Text('Município - Selecione o UF')),
                  onChanged: (_) {},
                  isExpanded: true,
                ))
          ]),
      );
    }

  }
}


