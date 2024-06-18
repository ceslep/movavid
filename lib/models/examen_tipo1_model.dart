// To parse this JSON data, do
//
//     final examenTipo1 = examenTipo1FromJson(jsonString);

import 'dart:convert';

ExamenTipo1 examenTipo1FromJson(String str) =>
    ExamenTipo1.fromJson(json.decode(str));

String examenTipo1ToJson(ExamenTipo1 data) => json.encode(data.toJson());

class ExamenTipo1 {
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
  String? observaciones;
  String? panel2;
  String? departamento;
  String? constante;
  String? hora;
  String? pyp;
  String? nombreExamen;
  String? constant;
  String? unidades;

  ExamenTipo1({
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
    this.observaciones,
    this.panel2,
    this.departamento,
    this.constante,
    this.hora,
    this.pyp,
    this.nombreExamen,
    this.constant,
    this.unidades,
  });

  factory ExamenTipo1.fromJson(Map<String?, dynamic> json) => ExamenTipo1(
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
        observaciones: json["observaciones"].toString(),
        panel2: json["panel2"].toString(),
        departamento: json["departamento"].toString(),
        constante: json["constante"].toString(),
        hora: json["hora"].toString(),
        pyp: json["pyp"].toString(),
        nombreExamen: json["nombreExamen"].toString(),
        constant: json["constant"].toString(),
        unidades: json["unidades"].toString(),
      );

  Map<String, dynamic> toJson() => {
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
        "observaciones": observaciones,
        "panel2": panel2,
        "departamento": departamento,
        "constante": constante,
        "hora": hora,
        "pyp": pyp,
        "nombreExamen": nombreExamen,
        "constant": constant,
        "unidades": unidades,
      };
}
