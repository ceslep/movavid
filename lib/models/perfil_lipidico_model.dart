// To parse this JSON data, do
//
//     final perfilLipidico = perfilLipidicoFromJson(jsonString?);

import 'dart:convert';

PerfilLipidico perfilLipidicoFromJson(String str) =>
    PerfilLipidico.fromJson(json.decode(str));

String? perfilLipidicoToJson(PerfilLipidico data) => json.encode(data.toJson());

class PerfilLipidico {
  String? id;
  String? identificacion;
  String? fecha;
  String? colesterolTotal;
  String? colesterolHdl;
  String? colesterolVldl;
  String? colesterolLdl;
  String? trigliceridos;
  String? indiceArterial;
  String? bacteriologo;
  String? observaciones;

  PerfilLipidico({
    this.id,
    this.identificacion,
    this.fecha,
    this.colesterolTotal,
    this.colesterolHdl,
    this.colesterolVldl,
    this.colesterolLdl,
    this.trigliceridos,
    this.indiceArterial,
    this.bacteriologo,
    this.observaciones,
  });

  factory PerfilLipidico.fromJson(Map<String?, dynamic> json) => PerfilLipidico(
        id: json["id"],
        identificacion: json["identificacion"],
        fecha: json["fecha"],
        colesterolTotal: json["colesterol_total"],
        colesterolHdl: json["colesterol_hdl"],
        colesterolVldl: json["colesterol_vldl"],
        colesterolLdl: json["colesterol_ldl"],
        trigliceridos: json["trigliceridos"],
        indiceArterial: json["indice_arterial"],
        bacteriologo: json["bacteriologo"],
        observaciones: json["observaciones"],
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "identificacion": identificacion,
        "fecha": fecha,
        "colesterol_total": colesterolTotal,
        "colesterol_hdl": colesterolHdl,
        "colesterol_vldl": colesterolVldl,
        "colesterol_ldl": colesterolLdl,
        "trigliceridos": trigliceridos,
        "indice_arterial": indiceArterial,
        "bacteriologo": bacteriologo,
        "observaciones": observaciones,
      };
}
