import 'dart:convert';

HRayto examenesFromJson(String str) => HRayto.fromJson(json.decode(str));

String examenesToJson(HRayto data) => json.encode(data.toJson());

class HRayto {
  String? id;
  String? identificacion;
  String? fecha;
  String? wBC;
  String? lYMn;
  String? mIDn;
  String? gRAn;
  String? lYMp;
  String? mIDp;
  String? gRAp;
  String? rBC;
  String? hGB;
  String? mCHC;
  String? mCH;
  String? mCV;
  String? rDWCV;
  String? rDWSD;
  String? hCT;
  String? pLT;
  String? mPV;
  String? pDW;
  String? pCT;
  String? pLCR;
  String? observaciones;
  String? bacteriologo;
  String? fechahora;

  HRayto(
      {this.id,
      this.identificacion,
      this.fecha,
      this.wBC,
      this.lYMn,
      this.mIDn,
      this.gRAn,
      this.lYMp,
      this.mIDp,
      this.gRAp,
      this.rBC,
      this.hGB,
      this.mCHC,
      this.mCH,
      this.mCV,
      this.rDWCV,
      this.rDWSD,
      this.hCT,
      this.pLT,
      this.mPV,
      this.pDW,
      this.pCT,
      this.pLCR,
      this.observaciones,
      this.bacteriologo,
      this.fechahora});

  List<dynamic> get publicProperties => [
        id,
        identificacion,
        fecha,
        wBC,
        lYMn,
        mIDn,
        gRAn,
        lYMp,
        mIDp,
        gRAp,
        rBC,
        hGB,
        mCHC,
        mCH,
        mCV,
        rDWCV,
        rDWSD,
        hCT,
        pLT,
        mPV,
        pDW,
        pCT,
        pLCR,
        observaciones,
        bacteriologo,
        fechahora
      ];

  factory HRayto.fromJson(Map<String, dynamic> json) => HRayto(
        id: json['id'].toString(),
        identificacion: json['identificacion'].toString(),
        fecha: json['fecha'].toString(),
        wBC: json['WBC'].toString(),
        lYMn: json['LYMn'].toString(),
        mIDn: json['MIDn'].toString(),
        gRAn: json['GRAn'].toString(),
        lYMp: json['LYMp'].toString(),
        mIDp: json['MIDp'].toString(),
        gRAp: json['GRAp'].toString(),
        rBC: json['RBC'].toString(),
        hGB: json['HGB'].toString(),
        mCHC: json['MCHC'].toString(),
        mCH: json['MCH'].toString(),
        mCV: json['MCV'].toString(),
        rDWCV: json['RDWCV'].toString(),
        rDWSD: json['RDWSD'].toString(),
        hCT: json['HCT'].toString(),
        pLT: json['PLT'].toString(),
        mPV: json['MPV'].toString(),
        pDW: json['PDW'].toString(),
        pCT: json['PCT'].toString(),
        pLCR: json['PLCR'].toString(),
        observaciones: json['observaciones'].toString(),
        bacteriologo: json['bacteriologo'].toString(),
        fechahora: json['fechahora'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'identificacion': identificacion,
        'fecha': fecha,
        'WBC': wBC,
        'LYMn': lYMn,
        'MIDn': mIDn,
        'GRAn': gRAn,
        'LYMp': lYMp,
        'MIDp': mIDp,
        'GRAp': gRAp,
        'RBC': rBC,
        'HGB': hGB,
        'MCHC': mCHC,
        'MCH': mCH,
        'MCV': mCV,
        'RDWCV': rDWCV,
        'RDWSD': rDWSD,
        'HCT': hCT,
        'PLT': pLT,
        'MPV': mPV,
        'PDW': pDW,
        'PCT': pCT,
        'PLCR': pLCR,
        'observaciones': observaciones,
        'bacteriologo': bacteriologo,
        'fechahora': fechahora,
      };
}
