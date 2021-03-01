import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


class CustomInput extends StatelessWidget {

  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final MaskTextInputFormatter textInputFormatter;
  final TextInputType keyboardType;
  final bool isPassword;
  final int textLength;

  const CustomInput({
      Key key,
      @required this.icon,
      @required this.placeholder,
      @required this.textController,
      this.textInputFormatter,
      this.textLength = 100,
      this.keyboardType = TextInputType.text,
      this.isPassword = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            blurRadius: 5
          )
        ]
      ),
      child: TextField(
        controller: this.textController,
        autocorrect: false,
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(this.textLength),
          this.textInputFormatter,
        ],
        keyboardType: this.keyboardType,
        obscureText: this.isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(this.icon),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: this.placeholder
        ),
      ),
    );
  }
}
