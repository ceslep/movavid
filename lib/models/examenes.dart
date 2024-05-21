// To parse this JSON data, do
//
//     final examenes = examenesFromJson(jsonString);

import 'dart:convert';

Examenes examenesFromJson(String str) => Examenes.fromJson(json.decode(str));

String examenesToJson(Examenes data) => json.encode(data.toJson());

class Examenes {
  final String? ind;
  final String? codexamen;
  final String? identificacion;
  final String? fecha;
  final String? realizado;
  final String? entidad;
  final String? examen;
  final String? tipo;

  Examenes({
    this.ind,
    this.codexamen,
    this.identificacion,
    this.fecha,
    this.realizado,
    this.entidad,
    this.examen,
    this.tipo,
  });

  factory Examenes.fromJson(Map<String, dynamic> json) => Examenes(
        ind: json["ind"].toString(),
        codexamen: json["codexamen"].toString(),
        identificacion: json["identificacion"].toString(),
        fecha: json["fecha"].toString(),
        realizado: json["realizado"].toString(),
        entidad: json["entidad"].toString(),
        examen: json['examen'].toString(),
        tipo: json['tipo'].toString(),
      );

  Map<String, dynamic> toJson() => {
        "ind": ind,
        "codexamen": codexamen,
        "identificacion": identificacion,
        "fecha": fecha,
        "realizado": realizado,
        "entidad": entidad,
      };
}
