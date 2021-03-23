import 'package:flutter/material.dart';

class TabPermissoes extends StatefulWidget {
  TabPermissoes({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TabPermissoes();
}

class _TabPermissoes extends State<TabPermissoes> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color(0xffFFFFFF),
        body: SafeArea(
          child: Center(
            child: Text('Permissões'))
        )
    );
  }
}