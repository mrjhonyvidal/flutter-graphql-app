# CNDV App
O código-fonte desenvolvido usando Dart/Flutter permite usar o mesmo código tanto para iOS como para Android.

```
flutter clean
flutter packages get
flutter packages upgrade
flutter pub cache repair
killall -9 dart
curl -v https://pub.dartlang.org Verificar o acesso ao site onde é feito o download dos plugins

ip a -- Algumas vezes não é possível baixar os plugins porque por default Flutter vai tentar usar uma conexão via IPV6 quando somente podemos por IPV4, ainda é um assunto que estou pesquisando para entender melhor.
    - https://tools.ietf.org/html/rfc6146
    - https://developers.google.com/speed/public-dns/docs/using
    - https://stackoverflow.com/questions/53803073/how-do-i-solve-running-flutter-packages-get
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
```

### GraphQL and Flutter
Como exemplo, é possível seguir essa guia: [https://hasura.io/learn/graphql/flutter-graphql/queries/2-create-query/](https://hasura.io/learn/graphql/flutter-graphql/queries/2-create-query/)
E olhar o plugin graphql_flutter: https://pub.dev/packages/graphql_flutter

### Push Notification
Usamos o pacote do Flutter: [firebase_messaging](https://pub.dev/packages/firebase_messaging) e usamos o sistema de mensagens do [Google Firebase Messaing](https://firebase.google.com/docs/cloud-messaging).
Para utilizar o mecanismo de Push Notification é necessário configurar o SHA-1 fingerprint of a signing ertitficate, é possível ver mais info de como gerar-lo na doc do [Google Android developer](https://developers.google.com/android/guides/client-auth).


### Plugins
Os plugins para Flutter utilizados podem ser encontrados no arquivo pubspec.yaml, abaixo segue a lista e uso:

- [GraphQL Flutter](https://pub.dev/packages/graphql_flutter)
- provider: ^5.0.0
- http: ^0.13.0
- font_awesome_flutter: ^8.11.0
- flutter_staggered_grid_view: ^0.3.4
- flutter_svg: ^0.19.1
- flutter_secure_storage: ^3.3.5
- mask_text_input_formatter: ^1.2.1
- intl: ^0.16.1
- overlay_support: ^1.0.5
- image_picker: ^0.7.2+1
- qr_flutter: ^3.2.0
- firebase_core: ^0.5.0+1
- firebase_messaging: ^7.0.3
- graphql_flutter: ^4.0.1


### Recursos e links

[Tutorial Push Notification](https://blog.logrocket.com/flutter-push-notifications-with-firebase-cloud-messaging/)