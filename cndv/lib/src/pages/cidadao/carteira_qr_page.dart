import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CarteiraQR extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff526BF6),
        title: Text('CNDV QR'),
      ),
      body: Center(
          child: Column(children: <Widget>[
            SizedBox( height: 10),
            Padding(
              padding: EdgeInsets.all(50.0),
              child: Text('Escanei o código abaixo para mostrar seus dados pessoais e seu controle de vacinação.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            ),
            QrImage(
              data: "Sts",
              size: 250,
            ),
          ])),
    );
  }
}
