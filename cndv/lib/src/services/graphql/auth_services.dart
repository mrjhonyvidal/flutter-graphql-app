import 'package:cndv/src/models/response_authenticate_user.dart';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {

  GetToken(String cpf, String password){
    return 'ok';
    //_authenticateUser();
  }

  RegisterNewUser(){
    return 'ok';
    //_registerUser();
  }

  LogoutUser(){
    return 'ok';
    /// TODO static Future<void> deleteToken() async {}
    /// final _storage = new FlutterSecureStorage();
    /// final _storage.delete(key: 'token');
    //_logout();
  }

  _authenticateUser() async {
    // TODO actual GraphQL query, needs to receive the client
    // Usuario usuario = ??? What returns when we log-in
    /**
     * final resp = await http.post('${ Environment.apiUrl}/login
     * body: jsonEncode(data),
     * headers: {
     *  'Content-Type':'application/json'
     * }
     * print(resp.body);
     *
     * final loginResponse = responseAuthenticateUserFromJson(resp.body)
     * this.usuario = loginResponse.usuario;
     */

    // Map response from server into our Usuario Model in Flutter
    throw new UnimplementedError();
  }

  _registerUser() async {
    // TODO actual GraphQL mutation, needs to receive the client
    throw new UnimplementedError();
  }
}