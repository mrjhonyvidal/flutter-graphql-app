import 'package:cndv/src/helpers/show_validations_alert_msg.dart';
import 'package:cndv/src/providers/push_notifications_provider.dart';
import 'package:cndv/src/services/graphql/mutations/device_push_notification.dart';
import 'package:cndv/src/shared_preferences/preferencias_usuario.dart';
import 'package:cndv/src/storage/cndv_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class TabPermissoes extends StatefulWidget {
  TabPermissoes({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TabPermissoes();
}

class _TabPermissoes extends State<TabPermissoes> {

  bool _receivePushNotification;
  bool _receiveEmailWhenNewCampaign;
  bool _allowShareMedicalHistory;
  bool _shareMyDataToHelpVacineControl;

  final prefs = new PreferenciaUsuario();

  @override
  void initState() {
    super.initState();
    _receivePushNotification = prefs.receivePushNotification;
    _receiveEmailWhenNewCampaign = prefs.receiveEmailWhenNewCampaign;
    _allowShareMedicalHistory = prefs.allowShareMedicalHistory;
    _shareMyDataToHelpVacineControl = prefs.shareMyDataToHelpVacineControl;
  }

  @override
  Widget build(BuildContext context) {

    final pushNotificationProvider = new PushNotificationsProvider();
    final cndvAuthSecureProvider = Provider.of<CNDVAuthSecureStorage>(context, listen: false);

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
                        showValidationsAlertMsg(
                            context,
                            'Você receberá uma notificação cada vez que uma nova campanha seja criada para sua idade e na sua cidade.',
                            '');
                      } else {
                        print('Erro ao cadastrar o push notification');
                      }
                  },
                onError: (err){
                  print(err);
                }),
                  builder: (RunMutation runMutation, QueryResult result) {
                  return SwitchListTile(
                    value: _receivePushNotification,
                    title: Text('Receber Push Notification'),
                    onChanged: ( value ) {

                      pushNotificationProvider.getDeviceToken().then((value){
                          runMutation({
                          'input': {
                            'cpf': cndvAuthSecureProvider.usuarioAcesso.cpf,
                            'token': value,
                            'tipo': 'CELULAR_ANDROID'
                            }
                          });
                        });
                      setState(() {
                        _receivePushNotification = value;
                        prefs.receivePushNotification = value;
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
                      prefs.receiveEmailWhenNewCampaign = value;
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
                      prefs.allowShareMedicalHistory = value;
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
                      prefs.shareMyDataToHelpVacineControl = value;
                    });
                  }
              ),

            ],
          ),
        )
    );
  }
}