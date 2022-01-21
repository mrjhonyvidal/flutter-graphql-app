# CNDV App
Vaccine control app using Flutter and GraphQL 

### GraphQL and Flutter
Resource used: [https://hasura.io/learn/graphql/flutter-graphql/queries/2-create-query/](https://hasura.io/learn/graphql/flutter-graphql/queries/2-create-query/)
Please take a look into graphql_flutter plugin: https://pub.dev/packages/graphql_flutter

### Push Notification
Flutter plugin used: [firebase_messaging](https://pub.dev/packages/firebase_messaging) connecting with [Google Firebase Messaing](https://firebase.google.com/docs/cloud-messaging).
For using Firebase Push Notification mechanism its necessary to set up SHA-1 certificate fingerprint, check more info in [Google Android developer](https://developers.google.com/android/guides/client-auth).

### Plugins
Flutter plugins used, check pubspec.yaml to check updates:

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

### Deploy to Google Play
- [Flutter doc Deploy Android](https://flutter.dev/docs/deployment/android)
- [Android Launch Melhores práticas](https://developer.android.com/distribute/best-practices/launch)
```
Change version in Android/app/build.gradle

    defaultConfig {
        applicationId "com.gpfgv.cndv"
        minSdkVersion 18
        targetSdkVersion 29
        versionCode 4 <----------- +1
        versionName "1.0.4"
        multiDexEnabled true
    }
flutter clean
flutter build apk --release
flutter build appbundle --release
```

### Troubleshooting
```
flutter clean
flutter packages get
flutter packages upgrade
flutter pub cache repair
killall -9 dart
curl -v https://pub.dartlang.org

ip a -- Sometimes its not possible download plugins due to Flutter have a IPV6 connection when we can only use IPV4
    - https://tools.ietf.org/html/rfc6146
    - https://developers.google.com/speed/public-dns/docs/using
    - https://stackoverflow.com/questions/53803073/how-do-i-solve-running-flutter-packages-get
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
```

### Resources and links

- [Push Notification Tutorial](https://blog.logrocket.com/flutter-push-notifications-with-firebase-cloud-messaging/)
- [Google Push Notification REST HTTP v1](https://firebase.google.com/docs/cloud-messaging/migrate-v1#go)
- https://github.com/FirebaseExtended/flutterfire/issues/3757
- [Firebase Android Setup](https://firebase.google.com/docs/android/setup)
- [Android Developer Notification Overview](https://developer.android.com/guide/topics/ui/notifiers/notifications?hl=pt#ManageChannels)
