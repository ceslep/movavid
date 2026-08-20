// To parse this JSON data, do
//
//     final configuracion = configuracionFromJson(jsonString);

import 'dart:convert';

ConfiguracionModel configuracionFromJson(String str) =>
    ConfiguracionModel.fromJson(json.decode(str));

String configuracionToJson(ConfiguracionModel data) =>
    json.encode(data.toJson());

class ConfiguracionModel {
  String? id;
  String? nit;
  String? nombreLaboratorio;
  String? direccionLaboratorio;
  String? telefonosLaboratorio;
  String? correoLaboratorio;
  String? webLaboratorio;
  String? bacteriologoLaboratorio;
  String? tarjetaPLaboratorio;
  String? urlFirmaLaboratorio;
  String? urlLogoLaboratorio;

  ConfiguracionModel({
    this.id,
    this.nit,
    this.nombreLaboratorio,
    this.direccionLaboratorio,
    this.telefonosLaboratorio,
    this.correoLaboratorio,
    this.webLaboratorio,
    this.bacteriologoLaboratorio,
    this.tarjetaPLaboratorio,
    this.urlFirmaLaboratorio,
    this.urlLogoLaboratorio,
  });

  factory ConfiguracionModel.fromJson(Map<String, dynamic> json) =>
      ConfiguracionModel(
        id: _string(json["id"]),
        nit: _string(json["nit"]),
        nombreLaboratorio: _string(json["nombreLaboratorio"]),
        direccionLaboratorio: _string(json["direccionLaboratorio"]),
        telefonosLaboratorio: _string(json["telefonosLaboratorio"]),
        correoLaboratorio: _string(json["correoLaboratorio"]),
        webLaboratorio: _string(json["webLaboratorio"]),
        bacteriologoLaboratorio: _string(json["bacteriologoLaboratorio"]),
        tarjetaPLaboratorio: _string(json["tarjetaPLaboratorio"]),
        urlFirmaLaboratorio: _string(
            json["urlFirmaLaboratorio"] ?? json["urFirmaLaboratorio"]),
        urlLogoLaboratorio: _string(json["urlLogoLaboratorio"]),
      );

  static String? _string(dynamic value) {
    if (value == null) return null;
    final String s = value.toString();
    return s == 'null' || s.isEmpty ? null : s;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nit": nit,
        "nombreLaboratorio": nombreLaboratorio,
        "direccionLaboratorio": direccionLaboratorio,
        "telefonosLaboratorio": telefonosLaboratorio,
        "correoLaboratorio": correoLaboratorio,
        "webLaboratorio": webLaboratorio,
        "bacteriologoLaboratorio": bacteriologoLaboratorio,
        "tarjetaPLaboratorio": tarjetaPLaboratorio,
        "urFirmaLaboratorio": urlFirmaLaboratorio,
        "urlLogoLaboratorio": urlLogoLaboratorio,
      };
}
