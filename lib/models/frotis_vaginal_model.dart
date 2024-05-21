// To parse this JSON data, do
//
//     final frotisVaginal = frotisVaginalFromJson(jsonString);

import 'dart:convert';

FrotisVaginal frotisVaginalFromJson(String str) =>
    FrotisVaginal.fromJson(json.decode(str));

String frotisVaginalToJson(FrotisVaginal data) => json.encode(data.toJson());

class FrotisVaginal {
  String? identificacion;
  String? fecha;
  String? otrosFresco;
  String? pruebaDeAminas;
  String? celulasGuia1;
  String? ph;
  String? trichonomasVaginales;
  String? pmn;
  String? celulasGuia2;
  String? blastoconidias;
  String? seudomicelios;
  String? lactobacillus;
  String? gardnerellaSp;
  String? bacteroidesSp;
  String? mobilluncusSp;
  String? pmnx;
  String? intracelulares;
  String? extracelulares;
  String? observaciones;

  FrotisVaginal({
    this.identificacion,
    this.fecha,
    this.otrosFresco,
    this.pruebaDeAminas,
    this.celulasGuia1,
    this.ph,
    this.trichonomasVaginales,
    this.pmn,
    this.celulasGuia2,
    this.blastoconidias,
    this.seudomicelios,
    this.lactobacillus,
    this.gardnerellaSp,
    this.bacteroidesSp,
    this.mobilluncusSp,
    this.pmnx,
    this.intracelulares,
    this.extracelulares,
    this.observaciones,
  });

  factory FrotisVaginal.fromJson(Map<String, dynamic> json) => FrotisVaginal(
        identificacion: json["identificacion"].toString(),
        fecha: json["fecha"].toString(),
        otrosFresco: json["otros_fresco"].toString(),
        pruebaDeAminas: json["prueba_de_aminas"].toString(),
        celulasGuia1: json["celulas_guia1"].toString(),
        ph: json["ph"].toString(),
        trichonomasVaginales: json["trichonomas_vaginales"].toString(),
        pmn: json["pmn"].toString(),
        celulasGuia2: json["celulas_guia2"].toString(),
        blastoconidias: json["blastoconidias"].toString(),
        seudomicelios: json["seudomicelios"].toString(),
        lactobacillus: json["lactobacillus"].toString(),
        gardnerellaSp: json["gardnerella_sp"].toString(),
        bacteroidesSp: json["bacteroides_sp"].toString(),
        mobilluncusSp: json["mobilluncus_sp"].toString(),
        pmnx: json["pmnx"].toString(),
        intracelulares: json["intracelulares"].toString(),
        extracelulares: json["extracelulares"].toString(),
        observaciones: json["observaciones"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "identificacion": identificacion,
        "fecha": fecha,
        "otros_fresco": otrosFresco,
        "prueba_de_aminas": pruebaDeAminas,
        "celulas_guia1": celulasGuia1,
        "ph": ph,
        "trichonomas_vaginales": trichonomasVaginales,
        "pmn": pmn,
        "celulas_guia2": celulasGuia2,
        "blastoconidias": blastoconidias,
        "seudomicelios": seudomicelios,
        "lactobacillus": lactobacillus,
        "gardnerella_sp": gardnerellaSp,
        "bacteroides_sp": bacteroidesSp,
        "mobilluncus_sp": mobilluncusSp,
        "pmnx": pmnx,
        "intracelulares": intracelulares,
        "extracelulares": extracelulares,
        "observaciones": observaciones,
      };
}
