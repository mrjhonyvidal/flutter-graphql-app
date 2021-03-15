import 'package:cndv/src/config/graphql_url_client.dart';
import 'package:cndv/src/providers/push_notifications_provider.dart';
import 'package:cndv/src/routes/routes.dart';
import 'package:cndv/src/services/graphql/carteira_cidadao_service.dart';
import 'package:cndv/src/services/rest/noticias_service.dart';
import 'package:cndv/src/storage/cndv_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import 'src/services/graphql/carteira_cidadao_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    final pushNotificationProvider = new PushNotificationsProvider();
    pushNotificationProvider.initNotifications();

    pushNotificationProvider.messagesStream.listen( ( data ) {
        navigatorKey.currentState.pushNamed('mensagem_notificacoes', arguments: data);
      });
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GraphQLCNDVClient.inititializeClient(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => new CarteiraCidadaoService()),
          ChangeNotifierProvider(create: (_) => new CNDVAuthSecureStorage()),
          ChangeNotifierProvider(create: (_) => new NoticiasService()),
        ],
        child: OverlaySupport(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            title: 'CNDV App',
            initialRoute: 'loading',
            routes: appRoutes,
          ),
        ),
      ),
    );
  }
}
