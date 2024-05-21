// To parse this JSON data, do
//
//      coprologico = coprologicoFromJson(jsonString);

import 'dart:convert';

Coprologico coprologicoFromJson(String str) =>
    Coprologico.fromJson(json.decode(str));

String coprologicoToJson(Coprologico data) => json.encode(data.toJson());

class Coprologico {
  String? id;
  String? identificacion;
  String? fecha;
  String? consistencia;
  String? color;
  String? sangre;
  String? moco;
  String? otrosMacroscopicos;
  String? ph;
  String? endamoebaHistoliticaQuistes;
  String? endamoebaColiQuistes;
  String? endolimaxQuistes;
  String? iodamoebaQuistes;
  String? giardaLambliaQuistes;
  String? chilomastixMesniliQuistes;
  String? trichomonaHominisQuistes;
  String? balantidiumColiQuistes;
  String? endamoebaHistoliticaTrofozoitos;
  String? endamoebaColiTrofozoitos;
  String? endolimaxTrofozoitos;
  String? iodamoebaTrofozoitos;
  String? giardaLambliaTrofozoitos;
  String? chilomastixMesniliTrofozoitos;
  String? trichomonaHominisTrofozoitos;
  String? balantidiumColiTrofozoitos;
  String? blastocystisHominisQuistes;
  String? blastocystisHominisTrofozoitos;
  String? ascaris;
  String? tricocefalos;
  String? uncinaria;
  String? teniaSaginata;
  String? teniaSolium;
  String? himenolepsis;
  String? strongiloidesLarva;
  String? oxiurosHuevos;
  String? sangreOculta;
  String? lecucocitos;
  String? observaciones;
  String? bacteriologo;
  String? fechahora;

  Coprologico({
    this.id,
    this.identificacion,
    this.fecha,
    this.consistencia,
    this.color,
    this.sangre,
    this.moco,
    this.otrosMacroscopicos,
    this.ph,
    this.endamoebaHistoliticaQuistes,
    this.endamoebaColiQuistes,
    this.endolimaxQuistes,
    this.iodamoebaQuistes,
    this.giardaLambliaQuistes,
    this.chilomastixMesniliQuistes,
    this.trichomonaHominisQuistes,
    this.balantidiumColiQuistes,
    this.endamoebaHistoliticaTrofozoitos,
    this.endamoebaColiTrofozoitos,
    this.endolimaxTrofozoitos,
    this.iodamoebaTrofozoitos,
    this.giardaLambliaTrofozoitos,
    this.chilomastixMesniliTrofozoitos,
    this.trichomonaHominisTrofozoitos,
    this.balantidiumColiTrofozoitos,
    this.blastocystisHominisQuistes,
    this.blastocystisHominisTrofozoitos,
    this.ascaris,
    this.tricocefalos,
    this.uncinaria,
    this.teniaSaginata,
    this.teniaSolium,
    this.himenolepsis,
    this.strongiloidesLarva,
    this.oxiurosHuevos,
    this.sangreOculta,
    this.lecucocitos,
    this.observaciones,
    this.bacteriologo,
    this.fechahora,
  });

  factory Coprologico.fromJson(Map<String, dynamic> json) => Coprologico(
        id: json["ind"].toString(),
        identificacion: json["identificacion"].toString(),
        fecha: json["fecha"].toString(),
        consistencia: json["consistencia"].toString(),
        color: json["color"].toString(),
        sangre: json["sangre"].toString(),
        moco: json["moco"].toString(),
        otrosMacroscopicos: json["otros_macroscopicos"].toString(),
        ph: json["ph"].toString(),
        endamoebaHistoliticaQuistes:
            json["endamoeba_histolitica_quistes"].toString(),
        endamoebaColiQuistes: json["endamoeba_coli_quistes"].toString(),
        endolimaxQuistes: json["endolimax_quistes"].toString(),
        iodamoebaQuistes: json["iodamoeba_quistes"].toString(),
        giardaLambliaQuistes: json["giarda_lamblia_quistes"].toString(),
        chilomastixMesniliQuistes:
            json["chilomastix_mesnili_quistes"].toString(),
        trichomonaHominisQuistes: json["trichomona_hominis_quistes"].toString(),
        balantidiumColiQuistes: json["balantidium_coli_quistes"].toString(),
        endamoebaHistoliticaTrofozoitos:
            json["endamoeba_histolitica_trofozoitos"].toString(),
        endamoebaColiTrofozoitos: json["endamoeba_coli_trofozoitos"].toString(),
        endolimaxTrofozoitos: json["endolimax_trofozoitos"].toString(),
        iodamoebaTrofozoitos: json["iodamoeba_trofozoitos"].toString(),
        giardaLambliaTrofozoitos: json["giarda_lamblia_trofozoitos"].toString(),
        chilomastixMesniliTrofozoitos:
            json["chilomastix_mesnili_trofozoitos"].toString(),
        trichomonaHominisTrofozoitos:
            json["trichomona_hominis_trofozoitos"].toString(),
        balantidiumColiTrofozoitos:
            json["balantidium_coli_trofozoitos"].toString(),
        blastocystisHominisQuistes:
            json["Blastocystis_hominis_quistes"].toString(),
        blastocystisHominisTrofozoitos:
            json["Blastocystis_hominis_trofozoitos"].toString(),
        ascaris: json["ascaris"].toString(),
        tricocefalos: json["tricocefalos"].toString(),
        uncinaria: json["uncinaria"].toString(),
        teniaSaginata: json["tenia_saginata"].toString(),
        teniaSolium: json["tenia_solium"].toString(),
        himenolepsis: json["himenolepsis"].toString(),
        strongiloidesLarva: json["strongiloides_larva"].toString(),
        oxiurosHuevos: json["oxiuros_huevos"].toString(),
        sangreOculta: json["sangre_oculta"].toString(),
        lecucocitos: json["lecucocitos"].toString(),
        observaciones: json["observaciones"].toString(),
        bacteriologo: json["bacteriologo"].toString(),
        fechahora: json["fechahora"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "identificacion": identificacion,
        "fecha": fecha,
        "consistencia": consistencia,
        "color": color,
        "sangre": sangre,
        "moco": moco,
        "otros_macroscopicos": otrosMacroscopicos,
        "ph": ph,
        "endamoeba_histolitica_quistes": endamoebaHistoliticaQuistes,
        "endamoeba_coli_quistes": endamoebaColiQuistes,
        "endolimax_quistes": endolimaxQuistes,
        "iodamoeba_quistes": iodamoebaQuistes,
        "giarda_lamblia_quistes": giardaLambliaQuistes,
        "chilomastix_mesnili_quistes": chilomastixMesniliQuistes,
        "trichomona_hominis_quistes": trichomonaHominisQuistes,
        "balantidium_coli_quistes": balantidiumColiQuistes,
        "endamoeba_histolitica_trofozoitos": endamoebaHistoliticaTrofozoitos,
        "endamoeba_coli_trofozoitos": endamoebaColiTrofozoitos,
        "endolimax_trofozoitos": endolimaxTrofozoitos,
        "iodamoeba_trofozoitos": iodamoebaTrofozoitos,
        "giarda_lamblia_trofozoitos": giardaLambliaTrofozoitos,
        "chilomastix_mesnili_trofozoitos": chilomastixMesniliTrofozoitos,
        "trichomona_hominis_trofozoitos": trichomonaHominisTrofozoitos,
        "balantidium_coli_trofozoitos": balantidiumColiTrofozoitos,
        "Blastocystis_hominis_quistes": blastocystisHominisQuistes,
        "Blastocystis_hominis_trofozoitos": blastocystisHominisTrofozoitos,
        "ascaris": ascaris,
        "tricocefalos": tricocefalos,
        "uncinaria": uncinaria,
        "tenia_saginata": teniaSaginata,
        "tenia_solium": teniaSolium,
        "himenolepsis": himenolepsis,
        "strongiloides_larva": strongiloidesLarva,
        "oxiuros_huevos": oxiurosHuevos,
        "sangre_oculta": sangreOculta,
        "lecucocitos": lecucocitos,
        "observaciones": observaciones,
        "bacteriologo": bacteriologo,
        "fechahora": fechahora,
      };
}
