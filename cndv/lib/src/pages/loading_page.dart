import 'package:cndv/src/pages/auth/login_page.dart';
import 'package:cndv/src/pages/tabs/tabs_page.dart';
import 'package:cndv/src/storage/cndv_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkingLoginState(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          return Center(
            child: new CircularProgressIndicator(),
          );
        },
      )
    );
  }

  Future checkingLoginState(BuildContext context ) async {
    final isAuthenticated = await CNDVAuthSecureStorage.isUserLoggedIn();

    final usuarioAutenticado = await CNDVAuthSecureStorage.getUsuarioFromLocalStorage();
    final cndvAuthSecureProvider = Provider.of<CNDVAuthSecureStorage>(context, listen: false);
    cndvAuthSecureProvider.usuario_accesso = usuarioAutenticado;

    if (isAuthenticated) {
      ///Navigator.pushReplacementNamed(context, 'tabs');
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => TabsPage(),
              transitionDuration: Duration(milliseconds: 0)
          )
      );
    }else {
      ///Navigator.pushReplacementNamed(context, 'login');
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => Login(),
              transitionDuration: Duration(milliseconds: 0)
          )
      );
    }
  }
}
