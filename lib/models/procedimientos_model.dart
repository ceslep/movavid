// To parse this JSON data, do
//
//     final procedimientos = procedimientosFromJson(jsonString);

import 'dart:convert';

Procedimientos procedimientosFromJson(String str) =>
    Procedimientos.fromJson(json.decode(str));

String procedimientosToJson(Procedimientos data) => json.encode(data.toJson());

class Procedimientos {
  String? ind;
  String? codigo;
  String? nombre;
  String? tabla;
  String? info;
  String? color;
  String? constante;
  String? unidades;
  String? tipo;
  String? tipoprocedimiento;
  String? abreviatura;

  Procedimientos({
    this.ind,
    this.codigo,
    this.nombre,
    this.tabla,
    this.info,
    this.color,
    this.constante,
    this.unidades,
    this.tipo,
    this.tipoprocedimiento,
    this.abreviatura,
  });

  factory Procedimientos.fromJson(Map<String, dynamic> json) => Procedimientos(
        ind: json["ind"],
        codigo: json["codigo"],
        nombre: json["nombre"],
        tabla: json["tabla"],
        info: json["info"],
        color: json["color"],
        constante: json["constante"],
        unidades: json["unidades"],
        tipo: json["tipo"],
        tipoprocedimiento: json["tipoprocedimiento"],
        abreviatura: json["abreviatura"],
      );

  Map<String, dynamic> toJson() => {
        "ind": ind,
        "codigo": codigo,
        "nombre": nombre,
        "tabla": tabla,
        "info": info,
        "color": color,
        "constante": constante,
        "unidades": unidades,
        "tipo": tipo,
        "tipoprocedimiento": tipoprocedimiento,
        "abreviatura": abreviatura,
      };
}
