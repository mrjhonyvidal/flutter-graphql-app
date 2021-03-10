// To parse this JSON data, do
//
//     final campanhasModel = campanhasModelFromJson(jsonString);

import 'dart:convert';

CampanhasModel campanhasModelFromJson(String str) =>
    CampanhasModel.fromJson(json.decode(str));

String campanhasModelToJson(CampanhasModel data) => json.encode(data.toJson());

class CampanhasModel {
  CampanhasModel({
    this.data,
  });

  Data data;

  factory CampanhasModel.fromJson(Map<String, dynamic> json) => CampanhasModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.obtenerCampanhas,
  });

  List<ObtenerCampanha> obtenerCampanhas;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        obtenerCampanhas: List<ObtenerCampanha>.from(
            json["obtenerCampanhas"].map((x) => ObtenerCampanha.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "obtenerCampanhas":
            List<dynamic>.from(obtenerCampanhas.map((x) => x.toJson())),
      };
}

class ObtenerCampanha {
  ObtenerCampanha({
    this.id,
    this.nome,
    this.idadeInicio,
    this.idadeFinal,
    this.municipio,
    this.uf,
  });

  String id;
  String nome;
  int idadeInicio;
  int idadeFinal;
  String municipio;
  String uf;

  factory ObtenerCampanha.fromJson(Map<String, dynamic> json) =>
      ObtenerCampanha(
        id: json["id"],
        nome: json["nome"],
        idadeInicio: json["idade_inicio"],
        idadeFinal: json["idade_final"],
        municipio: json["municipio"],
        uf: json["uf"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "idade_inicio": idadeInicio,
        "idade_final": idadeFinal,
        "municipio": municipio,
        "uf": uf,
      };
}
