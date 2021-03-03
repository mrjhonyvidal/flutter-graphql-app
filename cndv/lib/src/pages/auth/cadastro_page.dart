import 'package:cndv/src/helpers/show_validations_alert_msg.dart';
import 'package:cndv/src/services/graphql/mutations/auth_token_registration_usuario.dart';
import 'package:cndv/src/widgets/blue_button.dart';
import 'package:cndv/src/widgets/custom_input.dart';
import 'package:cndv/src/widgets/labels.dart';
import 'package:cndv/src/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Cadastro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Color(0xffF2F2F2),
        backgroundColor: Colors.black54,
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
                        route: 'login'
                    )
                  ],
                ),
              ),
            )
        )
    );
  }
}

class Form extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<Form> {

  final emailCtrl = TextEditingController();
  final passCtrl  =  TextEditingController();
  final cpfCtrl  =  TextEditingController();
  final nomeCtrl  =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric( horizontal: 50 ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CustomInput(
                icon: Icons.perm_contact_cal_outlined,
                placeholder: 'CPF',
                keyboardType: TextInputType.number,
                textController: cpfCtrl,
                textInputFormatter: MaskTextInputFormatter(mask: "###.###.###-##")
            ),
            CustomInput(
                icon: Icons.person,
                placeholder: 'Nome',
                keyboardType: TextInputType.text,
                textController: nomeCtrl,
                textInputFormatter: MaskTextInputFormatter(mask: ""),
                textLength: 50,
            ),
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
                onCompleted: (dynamic resultData) {
                  if (resultData != null) {
                   Navigator.pushReplacementNamed(context, 'login');
                  } else {
                    showValidationsAlertMsg(context, 'Dados de cadastrao incorretos!', 'Por favor revise e complete todos os campos antes de tentar novamente.');
                  }
                }
              ),
              builder: (
                RunMutation runMutation,
                QueryResult result
              ) {
                    return BlueButton(text: 'Cadastrar-se', onPressed: () => runMutation({
                        'cpf':    cpfCtrl.text,
                        'nome':   nomeCtrl.text,
                        'senha':  passCtrl.text,
                        'email':  emailCtrl.text
                    }),
                  );
                }
            )
          ],
        ),
    );
  }
}


