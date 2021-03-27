import 'package:cndv/src/providers/push_notifications_provider.dart';
import 'package:cndv/src/services/graphql/mutations/device_push_notification.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class TabPermissoes extends StatefulWidget {
  TabPermissoes({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TabPermissoes();
}

class _TabPermissoes extends State<TabPermissoes> {

  bool _receivePushNotification = false;
  bool _receiveEmailWhenNewCampaign = true;
  bool _allowShareMedicalHistory = true;
  bool _shareMyDataToHelpVacineControl = true;

  @override
  Widget build(BuildContext context) {

    final pushNotificationProvider = new PushNotificationsProvider();

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
              Mutation(
                options: MutationOptions(
                    document: gql(devicePushNotification.registerNewDevice),
                    update: (GraphQLDataProxy cache, QueryResult result) {
                    return cache;
                },
                  onCompleted: (dynamic resultData) {
                      if (resultData != null) {
                        print('ok was good');
                      } else {
                        print('implement GraphQL Node Query Side!');
                      }
                  }),
                  builder: (RunMutation runMutation, QueryResult result) {
                  return SwitchListTile(
                    value: _receivePushNotification,
                    title: Text('Receber Push Notification'),
                    onChanged: ( value ) {

                      pushNotificationProvider.getDeviceToken().then((value){
                        print(value);
                         /* runMutation({
                          'dispositivo_token': value
                          });*/
                        });
                      setState(() {
                        _receivePushNotification = value;
                      });
                    }
                  );
                }),
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
                      _shareMyDataToHelpVacineControl = value;
                    });
                  }
              ),

            ],
          ),
        )
    );
  }
}