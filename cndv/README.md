# CNDV App
O código-fonte desenvolvido usando Dart/Flutter permite usar o mesmo código tanto para iOS como para Android.

```
flutter clean
flutter packages get
flutter packages upgrade
flutter pub cache repair
```

### GraphQL and Flutter
Como exemplo, é possível seguir essa guia: [https://hasura.io/learn/graphql/flutter-graphql/queries/2-create-query/](https://hasura.io/learn/graphql/flutter-graphql/queries/2-create-query/)
E olhar o plugin graphql_flutter: https://pub.dev/packages/graphql_flutter

### Push Notification
Usamos o pacote do Flutter: [firebase_messaging](https://pub.dev/packages/firebase_messaging) e usamos o sistema de mensagens do [Google Firebase Messaing](https://firebase.google.com/docs/cloud-messaging).
Para utilizar o mecanismo de Push Notification é necessário configurar o SHA-1 fingerprint of a signing ertitficate, é possível ver mais info de como gerar-lo na doc do [Google Android developer](https://developers.google.com/android/guides/client-auth).

