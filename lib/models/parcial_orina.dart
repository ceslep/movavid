// To parse this JSON data, do
//
//     final parcialOrina = parcialOrinaFromJson(jsonString);

import 'dart:convert';

ParcialOrina parcialOrinaFromJson(String str) =>
    ParcialOrina.fromJson(json.decode(str));

String? parcialOrinaToJson(ParcialOrina data) => json.encode(data.toJson());

class ParcialOrina {
  String? id;
  String? identificacion;
  String? fecha;
  String? densidad;
  String? color;
  String? aspecto;
  String? ph;
  String? olor;
  String? proteinas;
  String? glucosa;
  String? cuerposCetonicos;
  String? sangreHemolizada;
  String? sangreNoHemolizada;
  String? bilirrubina;
  String? urobilinogeno;
  String? nitritos;
  String? leucocitos;
  String? leucocitosm;
  String? moco;
  String? eritrocitos;
  String? levaduras;
  String? piocitos;
  String? celulasEpiteliales;
  String? uratosAmorfos;
  String? fosfatosAmorfos;
  String? oxalatoDeCalcio;
  String? bacterias;
  String? cilindrosHialinos;
  String? cilindrosGranulosos;
  String? observaciones;
  String? bacteriologo;
  String? fechahora;

  ParcialOrina({
    this.id,
    this.identificacion,
    this.fecha,
    this.densidad,
    this.color,
    this.aspecto,
    this.ph,
    this.olor,
    this.proteinas,
    this.glucosa,
    this.cuerposCetonicos,
    this.sangreHemolizada,
    this.sangreNoHemolizada,
    this.bilirrubina,
    this.urobilinogeno,
    this.nitritos,
    this.leucocitos,
    this.leucocitosm,
    this.moco,
    this.eritrocitos,
    this.levaduras,
    this.piocitos,
    this.celulasEpiteliales,
    this.uratosAmorfos,
    this.fosfatosAmorfos,
    this.oxalatoDeCalcio,
    this.bacterias,
    this.cilindrosHialinos,
    this.cilindrosGranulosos,
    this.observaciones,
    this.bacteriologo,
    this.fechahora,
  });

  factory ParcialOrina.fromJson(Map<String, dynamic> json) => ParcialOrina(
        id: json["id"].toString(),
        identificacion: json["identificacion"].toString(),
        fecha: json["fecha"].toString(),
        densidad: json["densidad"].toString(),
        color: json["color"].toString(),
        aspecto: json["aspecto"].toString(),
        ph: json["ph"].toString(),
        olor: json["olor"].toString(),
        proteinas: json["proteinas"].toString(),
        glucosa: json["glucosa"].toString(),
        cuerposCetonicos: json["cuerpos_cetonicos"].toString(),
        sangreHemolizada: json["sangre_hemolizada"].toString(),
        sangreNoHemolizada: json["sangre_no_hemolizada"].toString(),
        bilirrubina: json["bilirrubina"].toString(),
        urobilinogeno: json["urobilinogeno"].toString(),
        nitritos: json["nitritos"].toString(),
        leucocitos: json["leucocitos"].toString(),
        leucocitosm: json["leucocitosm"].toString(),
        moco: json["moco"].toString(),
        eritrocitos: json["eritrocitos"].toString(),
        levaduras: json["levaduras"].toString(),
        piocitos: json["piocitos"].toString(),
        celulasEpiteliales: json["celulas_epiteliales"].toString(),
        uratosAmorfos: json["uratos_amorfos"].toString(),
        fosfatosAmorfos: json["fosfatos_amorfos"].toString(),
        oxalatoDeCalcio: json["oxalato_de_calcio"].toString(),
        bacterias: json["bacterias"].toString(),
        cilindrosHialinos: json["cilindros_hialinos"].toString(),
        cilindrosGranulosos: json["cilindros_granulosos"].toString(),
        observaciones: json["observaciones"].toString(),
        bacteriologo: json["doctor"].toString(),
        fechahora: json["fechahora"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "identificacion": identificacion,
        "fecha": fecha,
        "densidad": densidad,
        "color": color,
        "aspecto": aspecto,
        "ph": ph,
        "olor": olor,
        "proteinas": proteinas,
        "glucosa": glucosa,
        "cuerpos_cetonicos": cuerposCetonicos,
        "sangre_hemolizada": sangreHemolizada,
        "sangre_no_hemolizada": sangreNoHemolizada,
        "bilirrubina": bilirrubina,
        "urobilinogeno": urobilinogeno,
        "nitritos": nitritos,
        "leucocitos": leucocitos,
        "leucocitosm": leucocitosm,
        "moco": moco,
        "eritrocitos": eritrocitos,
        "levaduras": levaduras,
        "piocitos": piocitos,
        "celulas_epiteliales": celulasEpiteliales,
        "uratos_amorfos": uratosAmorfos,
        "fosfatos_amorfos": fosfatosAmorfos,
        "oxalato_de_calcio": oxalatoDeCalcio,
        "bacterias": bacterias,
        "cilindros_hialinos": cilindrosHialinos,
        "cilindros_granulosos": cilindrosGranulosos,
        "observaciones": observaciones,
        "bacteriologo": bacteriologo,
        "fechahora": fechahora
      };
}
