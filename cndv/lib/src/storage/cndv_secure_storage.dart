import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CNDVSecureStorage with ChangeNotifier{

  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
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