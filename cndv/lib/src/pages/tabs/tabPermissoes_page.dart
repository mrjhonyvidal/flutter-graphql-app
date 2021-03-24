import 'package:flutter/material.dart';

class TabPermissoes extends StatefulWidget {
  TabPermissoes({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TabPermissoes();
}

class _TabPermissoes extends State<TabPermissoes> {

  bool _receivePushNotification = true;
  bool _receiveEmailWhenNewCampaign = true;
  bool _allowShareMedicalHistory = true;
  bool _shareMyDataToHelpVacineControl = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color(0xffFFFFFF),
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Colors.white,
          title: Text('Preferências', style: TextStyle(color: Colors.black)),
          leading: new IconButton(
            icon: new Icon(Icons.person),
            color: Colors.blue,
            onPressed: () => Scaffold.of(context).openDrawer(),
          ), actions: <Widget>[],
        ),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5.0),
                child: Text('Mensagens', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              ),
              Divider(),
              SwitchListTile(
                value: _receivePushNotification,
                title: Text('Receber Push Notification'),
                onChanged: ( value ) {
                  setState(() {
                    _receivePushNotification = value;
                  });
                }
              ),
              Divider(),
              SwitchListTile(
                  value: _receiveEmailWhenNewCampaign,
                  title: Text('Permitir receber email'),
                  onChanged: ( value ) {
                    setState(() {
                      _receiveEmailWhenNewCampaign = value;
                    });
                  }
              ),
              Divider(),
              SwitchListTile(
                  value: _allowShareMedicalHistory,
                  title: Text('Compartilhar meu histórico de vacinas com entidades de saúde'),
                  onChanged: ( value ) {
                    setState(() {
                      _allowShareMedicalHistory = value;
                    });
                  }
              ),
              Divider(),
              Container(
                padding: EdgeInsets.all(5.0),
                child: Text('Estatísticas', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              ),
              Divider(),
              SwitchListTile(
                  value: _shareMyDataToHelpVacineControl,
                  title: Text('Compartilhar meus dados para ajudar o controle nacional de vacinas'),
                  onChanged: ( value ) {
                    setState(() {
                      _allowShareMedicalHistory = value;
                    });
                  }
              ),

            ],
          ),
        )
    );
  }
}