// To parse this JSON data, do
//
//     final cidadaoDadosPessoaisModel = cidadaoDadosPessoaisModelFromJson(jsonString);

import 'dart:convert';

CidadaoDadosPessoaisModel cidadaoDadosPessoaisModelFromJson(String str) => CidadaoDadosPessoaisModel.fromJson(json.decode(str));

String cidadaoDadosPessoaisModelToJson(CidadaoDadosPessoaisModel data) => json.encode(data.toJson());

class CidadaoDadosPessoaisModel {
  CidadaoDadosPessoaisModel({
    this.data,
  });

  Data data;

  factory CidadaoDadosPessoaisModel.fromJson(Map<String, dynamic> json) => CidadaoDadosPessoaisModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.obtenerDadosPessoais,
  });

  ObtenerDadosPessoais obtenerDadosPessoais;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    obtenerDadosPessoais: ObtenerDadosPessoais.fromJson(json["obtenerDadosPessoais"]),
  );

  Map<String, dynamic> toJson() => {
    "obtenerDadosPessoais": obtenerDadosPessoais.toJson(),
  };
}

class ObtenerDadosPessoais {
  ObtenerDadosPessoais({
    this.cpf,
    this.rg = '',
    this.nome = '',
    this.dtNascimento,
    this.email,
    this.contato = '',
    this.idTipoSanguineo = '',
    this.doador = '',
    this.endereco = '',
    this.numero = '',
    this.complemento = '',
    this.bairro = '',
    this.cidade = '',
    this.uf = '',
    this.pais = '',
    this.cep = '',
  });

  String cpf;
  String rg;
  String nome;
  DateTime dtNascimento;
  String email;
  String contato;
  String idTipoSanguineo;
  String doador;
  String endereco;
  String numero;
  String complemento;
  String bairro;
  String cidade;
  String uf;
  String pais;
  String cep;

  factory ObtenerDadosPessoais.fromJson(Map<String, dynamic> json) => ObtenerDadosPessoais(
    cpf: json["cpf"],
    rg: json["rg"],
    nome: json["nome"],
    dtNascimento: DateTime.parse(json["dt_nascimento"]),
    email: json["email"],
    contato: json["contato"],
    idTipoSanguineo: json["id_tipo_sanguineo"],
    doador: json["doador"],
    endereco: json["endereco"],
    numero: json["numero"],
    complemento: json["complemento"],
    bairro: json["bairro"],
    cidade: json["cidade"],
    uf: json["uf"],
    pais: json["pais"],
    cep: json["cep"],
  );

  Map<String, dynamic> toJson() => {
    "cpf": cpf,
    "rg": rg,
    "nome": nome,
    "dt_nascimento": dtNascimento.toIso8601String(),
    "email": email,
    "contato": contato,
    "id_tipo_sanguineo": idTipoSanguineo,
    "doador": doador,
    "endereco": endereco,
    "numero": numero,
    "complemento": complemento,
    "bairro": bairro,
    "cidade": cidade,
    "uf": uf,
    "pais": pais,
    "cep": cep,
  };
}
