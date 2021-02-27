// To parse this JSON data, do
//
//     final responseAuthenticateUser = responseAuthenticateUserFromJson(jsonString);

import 'dart:convert';

ResponseAuthenticateUser responseAuthenticateUserFromJson(String str) => ResponseAuthenticateUser.fromJson(json.decode(str));

String responseAuthenticateUserToJson(ResponseAuthenticateUser data) => json.encode(data.toJson());

class ResponseAuthenticateUser {
  ResponseAuthenticateUser({
    this.data,
  });

  Data data;

  factory ResponseAuthenticateUser.fromJson(Map<String, dynamic> json) => ResponseAuthenticateUser(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.autenticarUsuario,
  });

  AutenticarUsuario autenticarUsuario;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    autenticarUsuario: AutenticarUsuario.fromJson(json["autenticarUsuario"]),
  );

  Map<String, dynamic> toJson() => {
    "autenticarUsuario": autenticarUsuario.toJson(),
  };
}

class AutenticarUsuario {
  AutenticarUsuario({
    this.token,
    this.email,
    this.cpf,
    this.nome,
  });

  String token;
  String email;
  String cpf;
  String nome;

  factory AutenticarUsuario.fromJson(Map<String, dynamic> json) => AutenticarUsuario(
    token: json["token"],
    email: json["email"],
    cpf: json["cpf"],
    nome: json["nome"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "email": email,
    "cpf": cpf,
    "nome": nome,
  };
}
