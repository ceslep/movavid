// To parse this JSON data, do
//
//     final examenTipo1 = examenTipo1FromJson(jsonString);

import 'dart:convert';

CodExamen examenTipo1FromJson(String str) =>
    CodExamen.fromJson(json.decode(str));

String codExamenToJson(CodExamen data) => json.encode(data.toJson());

class CodExamen {
  String? codexamen;

  CodExamen({this.codexamen});

  factory CodExamen.fromJson(Map<String?, dynamic> json) => CodExamen(
        codexamen: json["codexamen"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "codexamen": codexamen,
      };
}
