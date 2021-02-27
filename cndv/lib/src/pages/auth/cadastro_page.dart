import 'package:cndv/src/widgets/blue_button.dart';
import 'package:cndv/src/widgets/custom_input.dart';
import 'package:cndv/src/widgets/labels.dart';
import 'package:cndv/src/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                textController: cpfCtrl
            ),
            CustomInput(
                icon: Icons.person,
                placeholder: 'Nome',
                keyboardType: TextInputType.text,
                textController: nomeCtrl
            ),
            CustomInput(
                icon: Icons.mail_outline,
                placeholder: 'Email',
                keyboardType: TextInputType.emailAddress,
                textController: emailCtrl
            ),
            CustomInput(
              icon: Icons.lock_outline,
              placeholder: 'Senha',
              keyboardType: TextInputType.text,
              textController: passCtrl,
              isPassword: true,
            ),

            BlueButton(text: 'Cadastrar-se', onPressed: (){
              Navigator.pushReplacementNamed(context, 'tabs');
            },)
          ],
        ),
    );
  }
}


