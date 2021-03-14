import 'package:cndv/src/config/graphql_url_client.dart';
import 'package:cndv/src/providers/push_notifications_provider.dart';
import 'package:cndv/src/routes/routes.dart';
import 'package:cndv/src/services/graphql/carteira_cidadao_service.dart';
import 'package:cndv/src/services/rest/noticias_service.dart';
import 'package:cndv/src/storage/cndv_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'src/services/graphql/carteira_cidadao_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    final pushNotificationProvider = new PushNotificationsProvider();
    pushNotificationProvider.initNotifications();
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
            title: 'CNDV App',
            initialRoute: 'loading',
            routes: appRoutes,
          ),
        ),
      ),
    );
  }
}
