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
    this.searchCampanhas,
  });

  List<SearchCampanhas> searchCampanhas;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        searchCampanhas: List<SearchCampanhas>.from(
            json["searchCampanhas"].map((x) => SearchCampanhas.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "searchCampanhas":
            List<dynamic>.from(searchCampanhas.map((x) => x.toJson())),
      };
}

class SearchCampanhas {
  SearchCampanhas({
    this.id,
    this.nome,
    this.idadeInicio,
    this.idadeFinal,
    this.cidade,
    this.uf,
    this.descricao
  });

  String id;
  String nome;
  int idadeInicio;
  int idadeFinal;
  String cidade;
  String uf;
  String descricao;

  factory SearchCampanhas.fromJson(Map<String, dynamic> json) =>
      SearchCampanhas(
        id: json["id"],
        nome: json["nome"],
        idadeInicio: json["idade_inicio"],
        idadeFinal: json["idade_final"],
        cidade: json["cidade"],
        uf: json["uf"],
        descricao: json["descricao"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "idade_inicio": idadeInicio,
        "idade_final": idadeFinal,
        "cidade": cidade,
        "uf": uf,
        "descricao": descricao,
      };
}
