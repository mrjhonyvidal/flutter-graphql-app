import 'dart:convert';

import 'package:cndv/src/helpers/show_validations_alert_msg.dart';
import 'package:cndv/src/models/response_authenticate_user.dart';
import 'package:cndv/src/services/graphql/mutations/auth_token_registration_usuario.dart';
import 'package:cndv/src/storage/cndv_secure_storage.dart';
import 'package:cndv/src/widgets/blue_button.dart';
import 'package:cndv/src/widgets/custom_input.dart';
import 'package:cndv/src/widgets/labels.dart';
import 'package:cndv/src/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        //backgroundColor: Colors.black12,
        body: SafeArea(
            child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: <Widget>[
                Logo(),
                Form(),
                Labels(
                    message: 'Termos de uso e condições de uso.',
                    callToActionText: 'Criar minha CNDV',
                    route: 'cadastro')
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
  final cpfCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomInput(
              icon: Icons.mail_outline,
              placeholder: 'CPF',
              keyboardType: TextInputType.emailAddress,
              textController: cpfCtrl,
              textInputFormatter:
                  MaskTextInputFormatter(mask: "###.###.###-##")),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Senha',
            keyboardType: TextInputType.emailAddress,
            textController: passCtrl,
            textInputFormatter: MaskTextInputFormatter(mask: ""),
            textLength: 16,
            isPassword: true,
          ),
          Mutation(
              options: MutationOptions(
                  document: gql(authTokenRegistrationUsuario.authUser),
                  update: (GraphQLDataProxy cache, QueryResult result) {
                    return cache;
                  },
                  onCompleted: (dynamic resultData) {
                    ///print(cpfCtrl.text); .getUnmaskedText()
                    ///print(passCtrl.text); .getMaskedText()
                    if (resultData != null) {
                      ///print(resultData['autenticarUsuario']);
                      final UsuarioAcesso usuarioAcesso =
                          usuarioAcessoFromJson(jsonEncode(resultData));

                      final cndvAuthSecureProvider =
                          Provider.of<CNDVAuthSecureStorage>(context,
                              listen: false);
                      cndvAuthSecureProvider.usuario_accesso =
                          usuarioAcesso.autenticarUsuario;

                      CNDVAuthSecureStorage.saveTokenAndInfo(
                          usuarioAcesso.autenticarUsuario.cpf,
                          usuarioAcesso.autenticarUsuario.nome,
                          usuarioAcesso.autenticarUsuario.token
                      );

                      Navigator.pushReplacementNamed(context, 'tabs');
                    } else {
                      showValidationsAlertMsg(
                          context,
                          'Dados de acesso incorretos',
                          'Por favor revise se o CPF ou a senha são corretos e tente novamente.');
                    }
                  }),
              builder: (RunMutation runMutation, QueryResult result) {
                return BlueButton(
                    text: 'Entrar',
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      runMutation({
                        'cpf': cpfCtrl.text.trim(),
                        'senha': passCtrl.text.trim()
                      });
                    });
              })
        ],
      ),
    );
  }
}
