// To parse this JSON data, do
//
//     final dataHemat = dataHematFromJson(jsonString);

import 'dart:convert';

DataHemat dataHematFromJson(String str) => DataHemat.fromJson(json.decode(str));

String dataHematToJson(DataHemat data) => json.encode(data.toJson());

class DataHemat {
  final String? wbc;
  final String? lyMn;
  final String? miDn;
  final String? grAn;
  final String? lyMp;
  final String? miDp;
  final String? grAp;
  final String? rbc;
  final String? hgb;
  final String? mchc;
  final String? mch;
  final String? mcv;
  final String? rdwcv;
  final String? rdwsd;
  final String? hct;
  final String? plt;
  final String? mpv;
  final String? pdw;
  final String? pct;
  final String? plcr;

  DataHemat({
    this.wbc,
    this.lyMn,
    this.miDn,
    this.grAn,
    this.lyMp,
    this.miDp,
    this.grAp,
    this.rbc,
    this.hgb,
    this.mchc,
    this.mch,
    this.mcv,
    this.rdwcv,
    this.rdwsd,
    this.hct,
    this.plt,
    this.mpv,
    this.pdw,
    this.pct,
    this.plcr,
  });

  factory DataHemat.fromJson(Map<String, dynamic> json) => DataHemat(
        wbc: json["WBC"],
        lyMn: json["LYMn"],
        miDn: json["MIDn"],
        grAn: json["GRAn"],
        lyMp: json["LYMp"],
        miDp: json["MIDp"],
        grAp: json["GRAp"],
        rbc: json["RBC"],
        hgb: json["HGB"],
        mchc: json["MCHC"],
        mch: json["MCH"],
        mcv: json["MCV"],
        rdwcv: json["RDWCV"],
        rdwsd: json["RDWSD"],
        hct: json["HCT"],
        plt: json["PLT"],
        mpv: json["MPV"],
        pdw: json["PDW"],
        pct: json["PCT"],
        plcr: json["PLCR"],
      );

  Map<String, dynamic> toJson() => {
        "WBC": wbc,
        "LYMn": lyMn,
        "MIDn": miDn,
        "GRAn": grAn,
        "LYMp": lyMp,
        "MIDp": miDp,
        "GRAp": grAp,
        "RBC": rbc,
        "HGB": hgb,
        "MCHC": mchc,
        "MCH": mch,
        "MCV": mcv,
        "RDWCV": rdwcv,
        "RDWSD": rdwsd,
        "HCT": hct,
        "PLT": plt,
        "MPV": mpv,
        "PDW": pdw,
        "PCT": pct,
        "PLCR": plcr,
      };
}
