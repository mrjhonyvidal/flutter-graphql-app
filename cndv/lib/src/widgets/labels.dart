import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String message;
  final String callToActionText;
  final String route;

  const Labels(
      {Key key,
      @required this.message,
      @required this.callToActionText,
      @required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        SizedBox(height: 40),
        Text(
          this.message,
          style: TextStyle(
              color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 15),
        GestureDetector(
            child: Text(this.callToActionText,
                style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pushReplacementNamed(context, this.route);
            })
      ]),
    );
  }
}
