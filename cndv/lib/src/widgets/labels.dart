import 'package:flutter/material.dart';

class Labels extends StatelessWidget {

  final String message;
  final String callToActionText;
  final String route;

  const Labels({
    Key key,
    @required this.message,
    @required this.callToActionText,
    @required this.route
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          children: <Widget>[
            SizedBox( height: 20 ),
            Text(this.message, style: TextStyle(fontWeight: FontWeight.w200 )),
            SizedBox( height: 10 ),
            Text('Ainda não está cadastrado?', style: TextStyle( color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300 ), ),
            SizedBox( height: 5 ),
            GestureDetector(
              child: Text( 'Fazer cadastro', style: TextStyle(color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold )),
              onTap: () {
                Navigator.pushReplacementNamed(context, this.route);
              }
            )

          ]
      ),
    );
  }
}
