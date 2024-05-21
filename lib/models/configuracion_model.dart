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
        id: json["id"].toString(),
        nit: json["nit"].toString(),
        nombreLaboratorio: json["nombreLaboratorio"].toString(),
        direccionLaboratorio: json["direccionLaboratorio"].toString(),
        telefonosLaboratorio: json["telefonosLaboratorio"].toString(),
        correoLaboratorio: json["correoLaboratorio"].toString(),
        webLaboratorio: json["webLaboratorio"].toString(),
        bacteriologoLaboratorio: json["bacteriologoLaboratorio"].toString(),
        tarjetaPLaboratorio: json["tarjetaPLaboratorio"].toString(),
        urlFirmaLaboratorio: json["urFirmaLaboratorio"].toString(),
        urlLogoLaboratorio: json["urlLogoLaboratorio"].toString(),
      );

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
