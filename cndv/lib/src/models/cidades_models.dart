// To parse this JSON data, do
//
//     final cidadesModel = cidadesModelFromJson(jsonString);

import 'dart:convert';

CidadesModel cidadesModelFromJson(String str) => CidadesModel.fromJson(json.decode(str));

String cidadesModelToJson(CidadesModel data) => json.encode(data.toJson());

class CidadesModel {
  CidadesModel({
    this.data,
  });

  Data data;

  factory CidadesModel.fromJson(Map<String, dynamic> json) => CidadesModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.obtenerCidades,
  });

  List<ObtenerCidade> obtenerCidades;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    obtenerCidades: List<ObtenerCidade>.from(json["obtenerCidades"].map((x) => ObtenerCidade.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "obtenerCidades": List<dynamic>.from(obtenerCidades.map((x) => x.toJson())),
  };
}

class ObtenerCidade {
  ObtenerCidade({
    this.cidade,
    this.uf,
  });

  String cidade;
  Uf uf;

  factory ObtenerCidade.fromJson(Map<String, dynamic> json) => ObtenerCidade(
    cidade: json["cidade"],
    uf: ufValues.map[json["uf"]],
  );

  Map<String, dynamic> toJson() => {
    "cidade": cidade,
    "uf": ufValues.reverse[uf],
  };
}

enum Uf { AC, AL, AM, AP, BA, CE, DF, ES, GO, MA, MG, MS, MT, PA, PB, PE, PI, PR, RJ, RN, RO, RR, RS, SC, SE, SP, TO }

final ufValues = EnumValues({
  "AC": Uf.AC,
  "AL": Uf.AL,
  "AM": Uf.AM,
  "AP": Uf.AP,
  "BA": Uf.BA,
  "CE": Uf.CE,
  "DF": Uf.DF,
  "ES": Uf.ES,
  "GO": Uf.GO,
  "MA": Uf.MA,
  "MG": Uf.MG,
  "MS": Uf.MS,
  "MT": Uf.MT,
  "PA": Uf.PA,
  "PB": Uf.PB,
  "PE": Uf.PE,
  "PI": Uf.PI,
  "PR": Uf.PR,
  "RJ": Uf.RJ,
  "RN": Uf.RN,
  "RO": Uf.RO,
  "RR": Uf.RR,
  "RS": Uf.RS,
  "SC": Uf.SC,
  "SE": Uf.SE,
  "SP": Uf.SP,
  "TO": Uf.TO
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
