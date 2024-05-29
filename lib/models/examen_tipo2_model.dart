// To parse this JSON data, do
//
//     final examenTipo2 = examenTipo2FromJson(jsonString?);

import 'dart:convert';

ExamenTipo2 examenTipo2FromJson(String? str) =>
    ExamenTipo2.fromJson(json.decode(str!));

String? examenTipo2ToJson(ExamenTipo2 data) => json.encode(data.toJson());

class ExamenTipo2 {
  String? ind;
  String? identificacion;
  String? examen;
  String? valoracion;
  String? fecha;
  String? bacteriologo;
  String? examenind;
  String? citasind;
  String? indice;
  String? entidad;
  String? departamento;
  String? hora;
  String? observaciones;
  String? pyp;
  String? nombreExamen;
  String? constant;
  String? unidades;

  ExamenTipo2({
    this.ind,
    this.identificacion,
    this.examen,
    this.valoracion,
    this.fecha,
    this.bacteriologo,
    this.examenind,
    this.citasind,
    this.indice,
    this.entidad,
    this.departamento,
    this.hora,
    this.observaciones,
    this.pyp,
    this.nombreExamen,
    this.constant,
    this.unidades,
  });

  factory ExamenTipo2.fromJson(Map<String?, dynamic> json) => ExamenTipo2(
        ind: json["ind"].toString(),
        identificacion: json["identificacion"].toString(),
        examen: json["examen"].toString(),
        valoracion: json["valoracion"].toString(),
        fecha: json["fecha"].toString(),
        bacteriologo: json["bacteriologo"].toString(),
        examenind: json["examenind"].toString(),
        citasind: json["citasind"].toString(),
        indice: json["indice"].toString(),
        entidad: json["entidad"].toString(),
        departamento: json["departamento"].toString(),
        hora: json["hora"].toString(),
        observaciones: json["observaciones"].toString(),
        pyp: json["pyp"].toString(),
        nombreExamen: json["nombreExamen"].toString(),
        constant: json["constant"].toString(),
        unidades: json["unidades"].toString(),
      );

  Map<String?, dynamic> toJson() => {
        "ind": ind,
        "identificacion": identificacion,
        "examen": examen,
        "valoracion": valoracion,
        "fecha": fecha,
        "bacteriologo": bacteriologo,
        "examenind": examenind,
        "citasind": citasind,
        "indice": indice,
        "entidad": entidad,
        "departamento": departamento,
        "hora": hora,
        "observaciones": observaciones,
        "pyp": pyp,
        "nombreExamen": nombreExamen,
        "constant": constant,
        "unidades": unidades,
      };
}
