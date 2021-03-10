import 'package:flutter/material.dart';
import 'package:cndv/src/models/response_authenticate_user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CNDVAuthSecureStorage with ChangeNotifier {
  AutenticarUsuario usuarioAcesso;

  set usuario_accesso(AutenticarUsuario usuario) {
    this.usuarioAcesso = usuario;
  }

  static Future<AutenticarUsuario> getUsuarioFromLocalStorage() async {
    final _storage = new FlutterSecureStorage();
    final cpf = await _storage.read(key: 'cpf');
    final nome = await _storage.read(key: 'nome');
    return new AutenticarUsuario(cpf: cpf, nome: nome);
  }

  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<bool> isUserLoggedIn() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');

    if (token != null) {
      /// TODO add endpoint to renovate Token based on current token /tokenRenew
      //saveToken(newToken);
      return true;
    }
    deleteToken();
    return false;
  }

  static Future<String> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'cpf');
    await _storage.delete(key: 'nome');
    await _storage.delete(key: 'token');
  }

  static Future saveTokenAndInfo(String cpf, String nome, String token) async {
    final _storage = new FlutterSecureStorage();
    await _storage.write(key: 'cpf', value: cpf);
    await _storage.write(key: 'nome', value: nome);
    return await _storage.write(key: 'token', value: token);
  }
}
