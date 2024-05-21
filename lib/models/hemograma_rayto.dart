// To parse this JSON data, do
//
//     final hemogramaRayto = hemogramaRaytoFromJson(jsonString);

import 'dart:convert';

HemogramaRayto hemogramaRaytoFromJson(String str) =>
    HemogramaRayto.fromJson(json.decode(str));

String hemogramaRaytoToJson(HemogramaRayto data) => json.encode(data.toJson());

class HemogramaRayto {
  final String? ind;
  final String? identificacion;
  final String? examen;
  final String? fecha;
  final String? hemoglobina;
  final String? sedimentacion;
  final String? html;
  final String? hematocrito;
  final String? sistematizado;
  final String? leucocitos;
  final String? otrosGeneral;
  final String? mielocitos;
  final String? pid;
  final String? juveniles;
  final String? enCayados;
  final String? neutrofilos;
  final String? eosinofilos;
  final String? basofilos;
  final String? linfocitos;
  final String? monocitos;
  final String? observaciones;
  final String? doctor;
  final String? exportar;
  final String? examenind;
  final String? citasind;
  final String? indice;
  final String? entidad;
  final String? departamento;
  final String? hora;
  final String? wbc;
  final String? rbc;
  final String? plt;
  final String? pyp;

  HemogramaRayto({
    this.ind,
    this.identificacion,
    this.examen,
    this.fecha,
    this.hemoglobina,
    this.sedimentacion,
    this.html,
    this.hematocrito,
    this.sistematizado,
    this.leucocitos,
    this.otrosGeneral,
    this.mielocitos,
    this.pid,
    this.juveniles,
    this.enCayados,
    this.neutrofilos,
    this.eosinofilos,
    this.basofilos,
    this.linfocitos,
    this.monocitos,
    this.observaciones,
    this.doctor,
    this.exportar,
    this.examenind,
    this.citasind,
    this.indice,
    this.entidad,
    this.departamento,
    this.hora,
    this.wbc,
    this.rbc,
    this.plt,
    this.pyp,
  });

  factory HemogramaRayto.fromJson(Map<String, dynamic> json) => HemogramaRayto(
        ind: json["ind"].toString(),
        identificacion: json["identificacion"].toString(),
        examen: json["examen"].toString(),
        fecha: json["fecha"].toString(),
        hemoglobina: json["hemoglobina"].toString(),
        sedimentacion: json["sedimentacion"].toString(),
        html: json["html"].toString(),
        hematocrito: json["hematocrito"].toString(),
        sistematizado: json["sistematizado"].toString(),
        leucocitos: json["leucocitos"].toString(),
        otrosGeneral: json["otros_general"].toString(),
        mielocitos: json["mielocitos"].toString(),
        pid: json["pid"].toString(),
        juveniles: json["juveniles"].toString(),
        enCayados: json["en_cayados"].toString(),
        neutrofilos: json["neutrofilos"].toString(),
        eosinofilos: json["eosinofilos"].toString(),
        basofilos: json["basofilos"].toString(),
        linfocitos: json["linfocitos"].toString(),
        monocitos: json["monocitos"].toString(),
        observaciones: json["observaciones"].toString(),
        doctor: json["doctor"].toString(),
        exportar: json["exportar"].toString(),
        examenind: json["examenind"].toString(),
        citasind: json["citasind"].toString(),
        indice: json["indice"].toString(),
        entidad: json["entidad"].toString(),
        departamento: json["departamento"].toString(),
        hora: json["hora"].toString(),
        wbc: json["wbc"].toString(),
        rbc: json["rbc"].toString(),
        plt: json["plt"].toString(),
        pyp: json["pyp"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "ind": ind,
        "identificacion": identificacion,
        "examen": examen,
        "fecha": fecha,
        "hemoglobina": hemoglobina,
        "sedimentacion": sedimentacion,
        "html": html,
        "hematocrito": hematocrito,
        "sistematizado": sistematizado,
        "leucocitos": leucocitos,
        "otros_general": otrosGeneral,
        "mielocitos": mielocitos,
        "pid": pid,
        "juveniles": juveniles,
        "en_cayados": enCayados,
        "neutrofilos": neutrofilos,
        "eosinofilos": eosinofilos,
        "basofilos": basofilos,
        "linfocitos": linfocitos,
        "monocitos": monocitos,
        "observaciones": observaciones,
        "doctor": doctor,
        "exportar": exportar,
        "examenind": examenind,
        "citasind": citasind,
        "indice": indice,
        "entidad": entidad,
        "departamento": departamento,
        "hora": hora,
        "wbc": wbc,
        "rbc": rbc,
        "plt": plt,
        "pyp": pyp,
      };
}
