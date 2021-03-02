import 'package:flutter/material.dart';
import 'package:cndv/src/models/response_authenticate_user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CNDVAuthSecureStorage with ChangeNotifier{

  UsuarioAcesso usuarioAcesso;

  set usuario_accesso(UsuarioAcesso usuario) {
    this.usuarioAcesso = usuario;
  }

  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    print(token);
    return token;
  }

  static Future<bool> isUserLoggedIn() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');

    if(token != null) {
      /// TODO add endpoint to renovate Token based on current token /tokenRenew
      //saveToken(newToken);
      return true;
    }
    deleteToken();
    return false;
  }

  static Future<String> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  static Future saveToken( String token ) async {
    final _storage = new FlutterSecureStorage();
    return await _storage.write(key: 'token', value: token);
  }
}