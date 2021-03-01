// To parse this JSON data, do
//
//     final usuarioAcesso = usuarioAcessoFromJson(jsonString);

import 'dart:convert';

UsuarioAcesso usuarioAcessoFromJson(String str) => UsuarioAcesso.fromJson(json.decode(str));

String usuarioAcessoToJson(UsuarioAcesso data) => json.encode(data.toJson());

class UsuarioAcesso {
  UsuarioAcesso({
    this.autenticarUsuario,
  });

  AutenticarUsuario autenticarUsuario;

  factory UsuarioAcesso.fromJson(Map<String, dynamic> json) => UsuarioAcesso(
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
