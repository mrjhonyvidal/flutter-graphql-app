import 'package:flutter/material.dart';

class CarteiraQR extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff526BF6),
          title: Text('QR'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_size_select_actual),
              onPressed: () {},
            )
          ]),
      body: Center(
        child: Text('Formulário para editar o perfil e upload de foto'),
      ),
    );
  }
}
