import 'dart:convert';
import 'dart:core';

Paciente pacienteFromJson(String str) => Paciente.fromJson(json.decode(str));

String pacienteToJson(Paciente data) => json.encode(data.toJson());

String calcularEdad(String fechaNacimientoString) {
  // Convertir la fecha de nacimiento a un objeto 'DateTime'
  DateTime fechaNacimiento = DateTime.parse(fechaNacimientoString);

  // Obtener la fecha actual
  DateTime fechaActual = DateTime.now();

  // Calcular la diferencia de años
  int diferenciaAnios = fechaActual.year - fechaNacimiento.year;

  // Calcular la diferencia de meses (opcional)
  int diferenciaMeses = fechaActual.month - fechaNacimiento.month;

  // Si la diferencia de meses es negativa, hay que ajustar la diferencia de años
  if (diferenciaMeses < 0) {
    diferenciaAnios--;
    diferenciaMeses += 12;
  }

  // Calcular la diferencia de días (opcional)
  int diferenciaDias = fechaActual.day - fechaNacimiento.day;

  // Si la diferencia de días es negativa, hay que ajustar la diferencia de meses
  if (diferenciaDias < 0) {
    diferenciaMeses--;
    if (diferenciaMeses < 0) {
      diferenciaMeses += 12;
      diferenciaAnios--;
    }
    fechaNacimiento = fechaNacimiento.add(const Duration(days: 30));
    diferenciaDias += fechaActual.day - fechaNacimiento.day;
  }

  // Formatear la edad como cadena
  // ignore: unnecessary_null_comparison
  String edad =
      // ignore: unnecessary_null_comparison
      '$diferenciaAnios años ${diferenciaMeses != null ? '$diferenciaMeses meses' : ''} ${diferenciaDias != null ? '$diferenciaDias días' : ''}';

  return edad;
}

String calcularEdadY(String fechaNacimientoString) {
  // Convertir la fecha de nacimiento a un objeto 'DateTime'
  DateTime fechaNacimiento = DateTime.parse(fechaNacimientoString);

  // Obtener la fecha actual
  DateTime fechaActual = DateTime.now();

  // Calcular la diferencia de años
  int diferenciaAnios = fechaActual.year - fechaNacimiento.year;

  // Calcular la diferencia de meses (opcional)
  int diferenciaMeses = fechaActual.month - fechaNacimiento.month;

  // Si la diferencia de meses es negativa, hay que ajustar la diferencia de años
  if (diferenciaMeses < 0) {
    diferenciaAnios--;
    diferenciaMeses += 12;
  }

  // Calcular la diferencia de días (opcional)
  int diferenciaDias = fechaActual.day - fechaNacimiento.day;

  // Si la diferencia de días es negativa, hay que ajustar la diferencia de meses
  if (diferenciaDias < 0) {
    diferenciaMeses--;
    if (diferenciaMeses < 0) {
      diferenciaMeses += 12;
      diferenciaAnios--;
    }
    fechaNacimiento = fechaNacimiento.add(const Duration(days: 30));
    diferenciaDias += fechaActual.day - fechaNacimiento.day;
  }

  // Formatear la edad como cadena
  // ignore: unnecessary_null_comparison
  String edad =
      // ignore: unnecessary_null_comparison
      '$diferenciaAnios años ';

  return edad;
}

class Paciente {
  final String? id;
  final String? identificacion;
  final String? nombres;
  final String? apellidos;
  final String? fecnac;
  final String? telefono;
  final String? correo;
  final String? genero;
  final String? entidad;

  Paciente({
    this.id,
    this.identificacion,
    this.nombres,
    this.apellidos,
    this.fecnac,
    this.telefono,
    this.correo,
    this.genero,
    this.entidad,
  });

  factory Paciente.fromJson(Map<String, dynamic> json) => Paciente(
        id: json["id"].toString(),
        identificacion: json["identificacion"].toString(),
        nombres: json["nombres"].toString(),
        apellidos: json["apellidos"].toString(),
        fecnac: json["fecnac"].toString(),
        telefono: json["telefono"].toString(),
        correo: json["correo"].toString(),
        genero: json["genero"].toString(),
        entidad: json["entidad"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "identificacion": identificacion,
        "nombres": nombres,
        "apellidos": apellidos,
        "fecnac": fecnac,
        "telefono": telefono,
        "correo": correo,
        "genero": genero,
        "entidad": entidad,
      };

  String get nombreCompleto => '${nombres ?? ''} ${apellidos ?? ''}';
  String get edad => calcularEdad(fecnac!);
  String get edadY => calcularEdadY(fecnac!);
}
