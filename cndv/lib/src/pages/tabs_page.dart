import 'package:flutter/material.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _Pages(),
      bottomNavigationBar: _Navigation(),
    );
  }
}

class _Navigation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
        items: [
          BottomNavigationBarItem( icon: Icon( Icons.fingerprint), title: Text('Carteira Médica')),
          BottomNavigationBarItem( icon: Icon( Icons.medical_services), title: Text('Campanhas'))
        ]
    );
  }
}

class _Pages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return PageView(
      //physics: BouncingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Container(
          color: Colors.lightBlueAccent,
        ),
        Container(
          color: Colors.greenAccent,
        ),
      ],
    );
  }
}
