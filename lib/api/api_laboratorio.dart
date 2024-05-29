// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movavid/functions/show_toast.dart';
import 'package:movavid/models/configuracion_model.dart';
import 'package:movavid/models/coprologico.dart';
import 'package:movavid/models/data-hemat.dart';
import 'package:movavid/models/examen_tipo1_model.dart';
import 'package:movavid/models/examen_tipo2_model.dart';
import 'package:movavid/models/examenes.dart';
import 'package:movavid/models/frotis_vaginal_model.dart';
import 'package:movavid/models/hemograma_rayto.dart';
import 'package:movavid/models/hg_rayto.dart';
import 'package:movavid/models/paciente.dart';
import 'package:movavid/models/parcial_orina.dart';
import 'package:movavid/models/perfil_lipidico_model.dart';
import 'package:movavid/models/procedimientos_model.dart';
import 'package:movavid/models/uni_constd.dart';

import 'package:movavid/providers/url_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

Future<Paciente> getInfoPaciente(
  BuildContext context, {
  String identificacion = '',
}) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  Uri url = Uri.parse('${urlProvider.url}getPaciente.php');
  final String bodyData = json.encode({
    'identificacion': identificacion,
  });
  try {
    final response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      final dynamic datosPaciente = json.decode(decodedResponse);
      if (datosPaciente['msg']) {
        return Paciente.fromJson(datosPaciente['data']);
      }
    } else {}
    return Paciente();
  } catch (e) {
    return Paciente(identificacion: 'Error');
  }
}

Future<List<Paciente>?> getPacientes(BuildContext context,
    {String criterio = ''}) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  final Uri url = Uri.parse('${urlProvider.url}getPacientes.php');
  late final http.Response response;
  final String bodyData = json.encode({"criterio": criterio});
  try {
    response = criterio == ''
        ? await http.get(url)
        : await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      List<dynamic> datosPaciente = json.decode(response.body);
      List<Paciente> result =
          datosPaciente.map((p) => Paciente.fromJson(p)).toList();
      return result;
    } else {
      throw Exception('Error en la solicitud HTTP: ${response.statusCode}');
    }
  } catch (e) {
    print('Error al obtener el listado: $e');

    return [];
  }
}

Future<List<Examenes>?> examenesPaciente(BuildContext context, FToast fToast,
    {String criterio = ''}) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  final Uri url = Uri.parse('${urlProvider.url}getExamenesPaciente.php');
  late final http.Response response;
  final String bodyData = json.encode({"criterio": criterio});
  try {
    response = criterio == ''
        ? await http.get(url)
        : await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      List<dynamic> datosPaciente = json.decode(response.body);
      List<Examenes> result =
          datosPaciente.map((p) => Examenes.fromJson(p)).toList();
      return result;
    } else {
      throw Exception('Error en la solicitud HTTP: ${response.statusCode}');
    }
  } catch (e) {
    showToastB(fToast, 'Error al Obtener el Listado de Examenes');
    print('Error al obtener el listado: $e');

    return [];
  }
}

Future<List<Examenes>?> examenesPacienteFecha(
    BuildContext context, FToast fToast,
    {String fecha = '', String identificacion = ''}) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  final Uri url = Uri.parse('${urlProvider.url}getExamenesPacienteFecha.php');
  late final http.Response response;
  final String bodyData =
      json.encode({"identificacion": identificacion, "fecha": fecha});
  try {
    response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      List<dynamic> datosPaciente = json.decode(response.body);
      List<Examenes> result =
          datosPaciente.map((p) => Examenes.fromJson(p)).toList();
      return result;
    } else {
      throw Exception('Error en la solicitud HTTP: ${response.statusCode}');
    }
  } catch (e) {
    showToastB(fToast, 'Error al Obtener el Listado de Examenes');
    print('Error al obtener el listado: $e');

    return [];
  }
}

Future<HemogramaRayto> getHemogramaRayto(BuildContext context,
    {String identificacion = '', String fecha = ''}) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  Uri url = Uri.parse('${urlProvider.url}getHemogramaRayto.php');
  final String bodyData =
      json.encode({'identificacion': identificacion, 'fecha': fecha});
  try {
    final response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      final dynamic datosHemograma = json.decode(decodedResponse);
      if (datosHemograma['msg']) {
        return HemogramaRayto.fromJson(datosHemograma['data']);
      }
    } else {
      return HemogramaRayto(identificacion: 'Error');
    }
    return HemogramaRayto(identificacion: 'Error');
  } catch (e) {
    return HemogramaRayto(identificacion: 'ErrorInternet');
  }
}

Future<HRayto> getHemogramaRaytoNew(BuildContext context,
    {String identificacion = '', String fecha = ''}) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  Uri url = Uri.parse('${urlProvider.url}getHemogramaRaytoNew.php');
  final String bodyData =
      json.encode({'identificacion': identificacion, 'fecha': fecha});
  try {
    final response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      final dynamic datosHemograma = json.decode(decodedResponse);
      if (datosHemograma['msg']) {
        return HRayto.fromJson(datosHemograma['data']);
      }
    } else {}
    return HRayto(identificacion: 'Error');
  } catch (e) {
    return HRayto(identificacion: 'ErrorInternet');
  }
}

Future<ParcialOrina> getParcialOrina(BuildContext context,
    {String identificacion = '', String fecha = ''}) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  Uri url = Uri.parse('${urlProvider.url}getParcialOrina.php');
  final String bodyData =
      json.encode({'identificacion': identificacion, 'fecha': fecha});
  try {
    final response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      final dynamic datosParcialOrina = json.decode(decodedResponse);
      if (datosParcialOrina['msg']) {
        return ParcialOrina.fromJson(datosParcialOrina['data']);
      }
    } else {}
    return ParcialOrina(identificacion: 'Error');
  } catch (e) {
    return ParcialOrina(identificacion: 'ErrorInternet');
  }
}

Future<Coprologico> getCoprologico(BuildContext context,
    {String identificacion = '', String fecha = ''}) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  Uri url = Uri.parse('${urlProvider.url}getCoprologico.php');
  final String bodyData =
      json.encode({'identificacion': identificacion, 'fecha': fecha});
  try {
    final response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      final dynamic datosCoprologico = json.decode(decodedResponse);
      if (datosCoprologico['msg']) {
        return Coprologico.fromJson(datosCoprologico['data']);
      }
    } else {
      return Coprologico(identificacion: 'Error');
    }
    return Coprologico(identificacion: 'Error');
  } catch (e) {
    return Coprologico(identificacion: 'ErrorInternet');
  }
}

Future<void> guardarHemograma(
    BuildContext context, HRayto hrayto, String codexamen) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  final Uri url = Uri.parse('${urlProvider.url}guardarExamen.php');
  late final http.Response response;
  final String bodyData =
      json.encode({...hrayto.toJson(), "tabla": "hemogramaRayto"});
  try {
    response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      final dynamic datos = json.decode(decodedResponse);
      print(datos);
      await updateExamen(
          urlProvider.url, codexamen, hrayto.identificacion!, hrayto.fecha!);
    } else {
      print({"error de response ": response.statusCode});
    }
  } catch (e) {
    print('Error al enviar los datos del hemograma: $e');
  }
}

Future<void> guardarParcialOrina(
    BuildContext context, ParcialOrina parcialOrina, String codexamen) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  final Uri url = Uri.parse('${urlProvider.url}guardarExamen.php');
  late final http.Response response;
  final String bodyData =
      json.encode({...parcialOrina.toJson(), "tabla": "parcialOrina"});
  try {
    response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      await updateExamen(urlProvider.url, codexamen,
          parcialOrina.identificacion!, parcialOrina.fecha!);
    } else {
      print({"error de response ": response.statusCode});
    }
  } catch (e) {
    print('Error al enviar los datos del hemograma: $e');
  }
}

Future<void> guardarCoprologico(
    BuildContext context, Coprologico coprologico, String codexamen) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  final Uri url = Uri.parse('${urlProvider.url}guardarExamen.php');
  late final http.Response response;
  final String bodyData =
      json.encode({...coprologico.toJson(), "tabla": "coprologico"});
  try {
    response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      await updateExamen(urlProvider.url, codexamen,
          coprologico.identificacion!, coprologico.fecha!);
    } else {
      print({"error de response ": response.statusCode});
    }
  } catch (e) {
    print('Error al enviar los datos del hemograma: $e');
  }
}

Future<bool> _launchInBrowser(Uri url) async {
  bool result = false;
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    result = false;
    throw Exception('Could not launch $url');
  } else {
    result = true;
  }
  return result;
}

Future<void> printPDFFile(
  BuildContext context,
  String tabla,
  String info,
  String fileName,
  String identificacion,
  String fecha,
  String nombres,
  String edad,
) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  /* final Uri url = Uri.parse(
      '${urlProvider.url}printphp/print_examen.php?identificacion=$identificacion&fecha=$fecha&nombres=$nombres&tabla=$tabla&info=$info'); */
  String ile =
      '${urlProvider.url}listaExamenes.php?identificacion=$identificacion&fecha=$fecha&tabla=$tabla&info=$info&embedido=1&nombres=$nombres&edad=$edad';
  print(ile);
  final Uri url = Uri.parse(ile);
  print(url);
  final bool result = await _launchInBrowser(url);
  print(result);
}

Future<bool> guardarConfiguracion(
    BuildContext context, ConfiguracionModel configuracion) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  final Uri url = Uri.parse('${urlProvider.url}guardarConfiguracion.php');
  final String bodyData = configuracionToJson(configuracion);
  late final http.Response response;
  try {
    response = await http.post(url, body: bodyData);
    return response.statusCode == 200;
  } catch (e) {
    print('Error al enviar los datos del hemograma: $e');
  }
  return false;
}

Future<ConfiguracionModel> getConfiguracion(BuildContext context) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  final Uri url = Uri.parse('${urlProvider.url}getConfiguracion.php');
  late final http.Response response;
  try {
    response = await http.get(url);
    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      final dynamic datosConfiguracion = json.decode(decodedResponse);
      if (datosConfiguracion['msg']) {
        return ConfiguracionModel.fromJson(datosConfiguracion['data']);
      }
    } else {
      return ConfiguracionModel();
    }
  } catch (e) {
    print(e);
  }
  return ConfiguracionModel();
}

Future<ExamenTipo1> getTipo1(BuildContext context,
    {String identificacion = '',
    String fecha = '',
    String codexamen = ''}) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  final Uri url = Uri.parse('${urlProvider.url}getTipo1.php');
  final String bodyData = json.encode({
    'identificacion': identificacion,
    'fecha': fecha,
    'codexamen': codexamen
  });
  late final http.Response response;
  try {
    response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      final dynamic datosExamen = json.decode(decodedResponse);
      if (datosExamen['msg']) {
        return ExamenTipo1.fromJson(datosExamen['data']);
      }
    } else {
      return ExamenTipo1(identificacion: 'Error');
    }
  } catch (e) {
    print(e);
  }
  return ExamenTipo1(identificacion: 'Error');
}

Future<ExamenTipo2> getTipo2(BuildContext context,
    {String identificacion = '',
    String fecha = '',
    String codexamen = ''}) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  final Uri url = Uri.parse('${urlProvider.url}getTipo2.php');
  final String bodyData = json.encode({
    'identificacion': identificacion,
    'fecha': fecha,
    'codexamen': codexamen
  });
  late final http.Response response;
  try {
    response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      final dynamic datosExamen = json.decode(decodedResponse);
      if (datosExamen['msg']) {
        return ExamenTipo2.fromJson(datosExamen['data']);
      }
    } else {
      return ExamenTipo2(identificacion: 'Error');
    }
  } catch (e) {
    print(e);
  }
  return ExamenTipo2(identificacion: 'Error');
}

Future<void> guardarTipo1(
    BuildContext context, ExamenTipo1 examen, String codexamen) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  final Uri url = Uri.parse('${urlProvider.url}guardarExamen.php');
  late final http.Response response;
  final String bodyData =
      json.encode({...examen.toJson(), "tabla": "examen_tipo_1"});
  try {
    response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      await updateExamen(
          urlProvider.url, codexamen, examen.identificacion!, examen.fecha!);
    } else {
      print({"error de response ": response.statusCode});
    }
  } catch (e) {
    print('Error al enviar los datos del examen: $e');
  }
}

Future<void> guardarTipo2(
    BuildContext context, ExamenTipo2 examen, String codexamen) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  final Uri url = Uri.parse('${urlProvider.url}guardarExamen.php');
  late final http.Response response;
  final String bodyData =
      json.encode({...examen.toJson(), "tabla": "examen_tipo_2"});
  try {
    response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      await updateExamen(
          urlProvider.url, codexamen, examen.identificacion!, examen.fecha!);
    } else {
      print({"error de response ": response.statusCode});
    }
  } catch (e) {
    print('Error al enviar los datos del examen tipo 2: $e');
  }
}

Future<UniConst> getUniConst(BuildContext context, String examen) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  final Uri url = Uri.parse('${urlProvider.url}getUniConst.php');
  late final http.Response response;
  final String bodyData = json.encode({"codexamen": examen});
  try {
    response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      final dynamic datosUC = json.decode(decodedResponse);
      return UniConst.fromJson(datosUC['data']);
    } else {
      print({"error de response ": response.statusCode});
    }
  } catch (e) {
    print('Error al enviar los datos del examen uniconst: $e');
  }
  return UniConst(constante: '', unidades: '');
}

Future<FrotisVaginal> getFrotisVaginal(BuildContext context,
    {String identificacion = '', String fecha = ''}) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  Uri url = Uri.parse('${urlProvider.url}getFrotisVaginal.php');
  final String bodyData =
      json.encode({'identificacion': identificacion, 'fecha': fecha});
  try {
    final response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      final dynamic datosFrotis = json.decode(decodedResponse);
      if (datosFrotis['msg']) {
        return FrotisVaginal.fromJson(datosFrotis['data']);
      }
    } else {
      return FrotisVaginal(identificacion: 'Error');
    }
    return FrotisVaginal(identificacion: 'Error');
  } catch (e) {
    return FrotisVaginal(identificacion: 'ErrorInternet');
  }
}

Future<void> guardarFrotisVaginal(
    BuildContext context, FrotisVaginal frotisVaginal, String codexamen) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  final Uri url = Uri.parse('${urlProvider.url}guardarExamen.php');
  late final http.Response response;
  final String bodyData =
      json.encode({...frotisVaginal.toJson(), "tabla": "frotisVaginal"});
  try {
    response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      await updateExamen(urlProvider.url, codexamen,
          frotisVaginal.identificacion!, frotisVaginal.fecha!);
    } else {
      print({"error de response ": response.statusCode});
    }
  } catch (e) {
    print('Error al enviar los datos del hemograma: $e');
  }
}

Future<PerfilLipidico> getPerfilLipidico(BuildContext context,
    {String identificacion = '', String fecha = ''}) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  Uri url = Uri.parse('${urlProvider.url}getPerfilLipidico.php');
  final String bodyData =
      json.encode({'identificacion': identificacion, 'fecha': fecha});
  try {
    final response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      final dynamic datosPerfil = json.decode(decodedResponse);
      if (datosPerfil['msg']) {
        return PerfilLipidico.fromJson(datosPerfil['data']);
      }
    } else {
      return PerfilLipidico(identificacion: 'Error');
    }
    return PerfilLipidico(identificacion: 'Error');
  } catch (e) {
    return PerfilLipidico(identificacion: 'ErrorInternet');
  }
}

Future<void> guardarPerfilLipidico(BuildContext context,
    PerfilLipidico perfilLipidico, String codexamen) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  final Uri url = Uri.parse('${urlProvider.url}guardarExamen.php');
  late final http.Response response;
  final String bodyData =
      json.encode({...perfilLipidico.toJson(), "tabla": "perfilLipidico"});
  try {
    response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      await updateExamen(urlProvider.url, codexamen,
          perfilLipidico.identificacion!, perfilLipidico.fecha!);
    } else {
      print({"error de response ": response.statusCode});
    }
  } catch (e) {
    print('Error al enviar los datos del hemograma: $e');
  }
}

Future<List<Procedimientos>> getProcedimientos(
  BuildContext context,
) async {
  List<Map<String, dynamic>> procedimientos = [];
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  Uri url = Uri.parse('${urlProvider.url}getProcedimientos.php');

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      procedimientos = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return procedimientos.map((e) => Procedimientos.fromJson(e)).toList();
    }
    return [];
  } catch (e) {
    return [];
  }
}

Future<Procedimientos> getProcedimiento(
    BuildContext context, String codigo) async {
  Map<String, dynamic> procedimiento;
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  Uri url = Uri.parse('${urlProvider.url}getProcedimiento.php');
  final String bodyData = json.encode({"codigo": codigo});

  try {
    final response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      procedimiento = jsonDecode(response.body);
      return Procedimientos.fromJson(procedimiento);
    }
    return Procedimientos();
  } catch (e) {
    print(e);
    return Procedimientos();
  }
}

Future<void> guardarProcedimiento(
    BuildContext context, Procedimientos procedimiento) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  Uri url = Uri.parse('${urlProvider.url}guardarProcedimiento.php');
  final String bodyData = json.encode(procedimiento.toJson());

  try {
    final response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {}
  } catch (e) {
    print(e);
  }
}

String procedisToJson(List<Procedimientos> procedimientos) {
  String json = "[";
  for (Procedimientos procedimiento in procedimientos) {
    json += "${procedimientosToJson(procedimiento)},";
  }
  json = json.substring(0, json.length - 1);
  json += "]";
  return json;
}

Future<void> guardarExamenes(
    BuildContext context,
    List<Procedimientos> procedimientos,
    String identificacion,
    String fecha) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  final Uri url = Uri.parse('${urlProvider.url}guardarExamenes.php');
  late final http.Response response;
  final String bodyData = json.encode({
    "examenes": procedisToJson(procedimientos),
    "identificacion": identificacion,
    "fecha": fecha
  });

  try {
    response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      print("bien");
    } else {
      print({"error de response ": response.statusCode});
    }
  } catch (e) {
    print('Error al enviar los datos del hemograma: $e');
  }
}

Future<List<Procedimientos>> getSeleccionados(
    BuildContext context, String identificacion, String fecha) async {
  List<Map<String, dynamic>> procedimientos = [];
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  Uri url = Uri.parse('${urlProvider.url}getSeleccionados.php');
  final String bodyData =
      json.encode({"identificacion": identificacion, "fecha": fecha});
  try {
    final response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      procedimientos = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return procedimientos.map((e) => Procedimientos.fromJson(e)).toList();
    }
    return [];
  } catch (e) {
    return [];
  }
}

Future<void> updateExamen(
    String Url, String codexamen, String identificacion, String fecha) async {
  final Uri url = Uri.parse('${Url}updateExamen.php');
  late final http.Response response;
  final String bodyData = json.encode({
    "codexamen": codexamen,
    "identificacion": identificacion,
    "fecha": fecha,
  });
  try {
    response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      print("bien");
    } else {
      print({"error de response upd ": response.statusCode});
    }
  } catch (e) {
    print('Error al enviar los datos del hemograma: $e');
  }
}

Future<List<Paciente>> getPacientesFecha(
    BuildContext context, String fecha) async {
  List<Map<String, dynamic>> pacientes = [];
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  Uri url = Uri.parse('${urlProvider.url}getPacientesFecha.php');
  final String bodyData = json.encode({"fecha": fecha});
  try {
    final response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      pacientes = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return pacientes.map((e) => Paciente.fromJson(e)).toList();
    }
    return [];
  } catch (e) {
    return [];
  }
}

Image imagenet(BuildContext context, String image) {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  return Image.network(
    "${urlProvider.url}printphp/$image",
    scale: 0.5,
  );
}

Future<DataHemat> getDataHemat(
    BuildContext context, String identificacion, String fecha) async {
  Map<String, dynamic> dataHemat;

  Uri url = Uri.parse('http://127.0.0.1:3000/dataHemat');
  /* if (!androidInfo.isPhysicalDevice) {
    url = Uri.parse('http://10.0.2.2:3000/dataHemat');
  } else {
    url = Uri.parse('http://127.0.0.1:3000/dataHemat');
  }
  url = Uri.parse('http://127.0.0.1:3000/dataHemat'); */
  final String bodyData =
      json.encode({"identificacion": identificacion, "fecha": fecha});
  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: bodyData,
    );
    if (response.statusCode == 200) {
      dataHemat = jsonDecode(response.body);
      return DataHemat.fromJson(dataHemat);
    } else {
      return DataHemat();
    }
  } catch (e) {
    print(e);
    return DataHemat();
  }
}

Future<List<String>> getItemsExamen(
    BuildContext context, String codexamen) async {
  //List<String> items = [' ' * 6];
  List<String> items = [];
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  Uri url = Uri.parse('${urlProvider.url}getItemsExamenes.php');
  final String bodyData = json.encode({"codexamen": codexamen});
  try {
    final response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      for (var element in data) {
        items.add(element['item']);
      }
      print(items);
    }
    return items;
  } catch (e) {
    print(e);
    return [];
  }
}
