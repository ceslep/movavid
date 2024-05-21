// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:movavid/api/api_laboratorio.dart';
import 'package:movavid/functions/show_toast.dart';
import 'package:movavid/models/paciente.dart';
import 'package:movavid/providers/url_provider.dart';
import 'package:movavid/widgets/date_picker.dart';
import 'package:movavid/widgets/text_fieldi.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Pacientes extends StatefulWidget {
  const Pacientes({super.key});

  @override
  State<Pacientes> createState() => _PacientesState();
}

class _PacientesState extends State<Pacientes> {
  bool guardando = false;
  FToast fToast = FToast();
  final TextEditingController _identificacionController =
      TextEditingController();
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _fecnacController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  final TextEditingController _entidadController = TextEditingController();

  String _genero = '';
  String id = '';
  String fecha = DateFormat('yyyy-MM-dd').format(DateTime.now());
  int identificaCount = 0;
  bool identificacionValida = false;
  bool nombresValido = false;
  bool apellidosValido = false;
  bool telefonoValido = false;

  int _nombresfieldiCount = 0;
  int _apellidosFieldiCount = 0;
  int _telefonofieldiCount = 0;
  int _correofieldiCount = 0;

  List<String> genero = [
    'Seleccione el genero del paciente',
    'Masculino',
    'Femenino',
    'Otro'
  ];

  List<DropdownMenuItem> _itemsGenero = [];

  List<DropdownMenuItem<String>> getGeneroItems(List<String> genero) {
    List<DropdownMenuItem<String>> items = [];
    for (String generoItem in genero) {
      items.add(
        DropdownMenuItem(
          enabled: !generoItem.contains('Seleccione'),
          value: generoItem.contains('Seleccione') ? '' : generoItem,
          child: Text(generoItem),
        ),
      );
    }
    return items;
  }

  final focusNode = FocusNode();
  final focusNodeNombres = FocusNode();

  @override
  void initState() {
    super.initState();
    fToast.init(context);
    _itemsGenero = getGeneroItems(genero);
    focusNode.addListener(() async {
      if (!focusNode.hasFocus) {
        Paciente paciente = await getInfoPaciente(context,
            identificacion: _identificacionController.text);

        //    print(paciente.toJson());
        if (paciente.identificacion != null) {
          id = '';
          if (paciente.identificacion != 'Error') {
            id = paciente.id!;
            identificacionValida = _identificacionController.text.length >= 6;
            identificaCount = paciente.identificacion!.length;
            _nombresController.text = paciente.nombres!;
            _nombresfieldiCount = _nombresController.text.length;
            nombresValido = _nombresController.text.length >= 3;
            _apellidosController.text =
                paciente.apellidos!.replaceAll('\ufffd', 'Ñ');
            apellidosValido = _apellidosController.text.length >= 5;
            _apellidosFieldiCount = _apellidosController.text.length;
            _fecnacController.text = paciente.fecnac!;
            _genero = paciente.genero!;
            _telefonoController.text = paciente.telefono!;
            telefonoValido = _telefonoController.text.length >= 10;
            _telefonofieldiCount = _telefonoController.text.length;
            _correoController.text = paciente.correo!;
            _correofieldiCount = _correoController.text.length;
            _entidadController.text = paciente.entidad!;
            if (mounted) setState(() {});
          } else {
            showToastB(
              fToast,
              'Sin Internet. Ha ocurrido un error obteniendo los datos del servidor',
              bacgroundColor: Colors.red,
              frontColor: Colors.yellow,
              icon: Icon(
                MdiIcons.networkOff,
                color: Colors.yellow,
              ),
              milliseconds: 10,
            );
          }
        }
      }
    });
  }

  Future<bool> guardarPaciente() async {
    Paciente paciente = Paciente(
      id: NativeRuntime.buildId.toString(),
      identificacion: _identificacionController.text,
      nombres: _nombresController.text,
      apellidos: _apellidosController.text,
      fecnac: _fecnacController.text,
      genero: _genero,
      telefono: _telefonoController.text,
      correo: _correoController.text,
      entidad: _entidadController.text,
    );
    final urlProvider = Provider.of<UrlProvider>(context, listen: false);
    Uri url = Uri.parse('${urlProvider.url}savePaciente.php');
    final bodyData = json.encode(paciente.toJson());
    try {
      final response = await http.post(url, body: bodyData);
      if (response.statusCode == 200) {
        final dynamic datos = json.decode(response.body);
        return datos['msg'];
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Crear Paciente',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _identificacionController.clear();
              _nombresController.clear();
              _apellidosController.clear();
              _fecnacController.clear();
              _genero = '';
              _telefonoController.clear();
              _correoController.clear();
              _entidadController.clear();
              identificaCount = 0;
              _nombresfieldiCount = 0;
              _apellidosFieldiCount = 0;
              _telefonofieldiCount = 0;
              _correofieldiCount = 0;
              setState(() {});
            },
            icon: const Icon(
              Icons.new_label_rounded,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: guardaPaciente,
              icon: !guardando
                  ? const Icon(
                      Icons.save,
                      color: Colors.lightGreenAccent,
                    )
                  : const SizedBox(
                      width: 12,
                      height: 12,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFieldi(
                autoFocus: true,
                focusNode: focusNode,
                controller: _identificacionController,
                count: 6,
                color: Colors.green,
                hintText: 'Ingrese la Identificación del paciente',
                field: 'Identificación',
                keyboardType: const TextInputType.numberWithOptions(),
                textCapitalization: TextCapitalization.none,
                onChanged: (value) {
                  identificacionValida = value.length >= 6;
                },
                digitsOnly: true,
              ),
              const SizedBox(
                height: 18.0,
              ),
              TextFieldi(
                fieldiCount: _nombresfieldiCount,
                focusNode: focusNodeNombres,
                controller: _nombresController,
                hintText: 'Nombres del paciente',
                count: 3,
                field: 'Nombres',
                textCapitalization: TextCapitalization.characters,
                color: Colors.green,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  nombresValido = value.length >= 3;
                },
                digitsOnly: false,
              ),
              const SizedBox(
                height: 18.0,
              ),
              TextFieldi(
                fieldiCount: _apellidosFieldiCount,
                controller: _apellidosController,
                hintText: 'Apellidos del paciente',
                field: 'Apellidos',
                textCapitalization: TextCapitalization.characters,
                count: 5,
                color: Colors.green,
                focusNode: FocusNode(),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  apellidosValido = value.length >= 5;
                },
                digitsOnly: false,
              ),
              const SizedBox(
                height: 18.0,
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: buildDatePicker(
                  context,
                  _fecnacController,
                  'Fecha de Nacimiento',
                ),
              ),
              const SizedBox(
                height: 18.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DropdownButton(
                  items: _itemsGenero,
                  value: _genero,
                  onChanged: (value) {
                    setState(() {
                      _genero = value!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 18.0),
              TextFieldi(
                fieldiCount: _telefonofieldiCount,
                hintText: 'telefono del paciente',
                field: 'Teléfono',
                controller: _telefonoController,
                keyboardType: TextInputType.phone,
                color: Colors.green,
                count: 10,
                focusNode: FocusNode(),
                textCapitalization: TextCapitalization.none,
                onChanged: (value) {
                  telefonoValido = value.length >= 10;
                },
                digitsOnly: true,
              ),
              const SizedBox(height: 18.0),
              TextFieldi(
                fieldiCount: _correofieldiCount,
                controller: _correoController,
                hintText: 'Correo del paciente',
                field: 'Correo',
                keyboardType: TextInputType.emailAddress,
                color: Colors.green,
                count: 8,
                digitsOnly: false,
                focusNode: FocusNode(),
                onChanged: (value) {},
                textCapitalization: TextCapitalization.none,
                isCorreo: true,
                correoValido: validarCorreo(),
              ),
              const SizedBox(height: 18),
              TextFieldi(
                controller: _entidadController,
                hintText: 'Entidad del paciente',
                field: 'Entidad',
                keyboardType: TextInputType.text,
                color: Colors.green,
                digitsOnly: false,
                count: 0,
                focusNode: FocusNode(),
                textCapitalization: TextCapitalization.characters,
                onChanged: (value) {},
              ),
              const SizedBox(
                height: 36.0,
              ),
              SizedBox(
                width: 0.65 * MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: guardaPaciente,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Guardar",
                      ),
                      !guardando
                          ? const Icon(Icons.save)
                          : const SizedBox(
                              width: 12,
                              height: 12,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void guardaPaciente() async {
    if (!identificacionValida) {
      infoValido('Ingrese el número de identificacion correcto');
      return;
    } else if (!nombresValido) {
      infoValido('Ingrese un nombre válido');
      return;
    } else if (!apellidosValido) {
      infoValido('Ingrese apellidos más relevantes');
      return;
    } else if (!validarFecha()) {
      infoValido('Ingrese una fecha de Nacimiento correcta');
      return;
    } else if (_genero.isEmpty) {
      infoValido('Seleccione el género');
      return;
    } else if (!telefonoValido) {
      infoValido('Se necesita un numero de telefono correcto');
      return;
    } else if (!validarCorreo()) {
      infoValido('Ingrese un correo correcto');
      return;
    }
    setState(() => guardando = !guardando);
    bool save = await guardarPaciente();
    if (save) {
      await showToastB(
        fToast,
        id == ''
            ? 'Paciente Registrado Correctamente'
            : 'Paciente actualizado correctamente',
        bacgroundColor: Colors.lightGreen,
      );
      if (mounted) Navigator.pop(context);
    } else {
      showToastB(
          fToast, 'Ha ocurido un error. Intentelo nuevamente más tarde.');
    }
    setState(() => guardando = !guardando);
  }

  void infoValido(String text) {
    showToastB(
      fToast,
      text,
      milliseconds: 50,
      bacgroundColor: Colors.red,
      frontColor: Colors.yellow,
      icon: const Icon(Icons.dangerous, color: Colors.yellow),
    );
  }

  bool validarFecha() {
    if (_fecnacController.text != '') {
      DateTime dateTime =
          DateFormat("yyyy-MM-dd").parse(_fecnacController.text);
      Duration difference = DateTime.now().difference(dateTime);
      return difference.inDays > 10;
    }
    return false;
  }

  bool validarCorreo() {
    String correo = _correoController.text;
    if (correo == '') return false;
    final RegExp emailRegExp = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      caseSensitive: false,
      multiLine: false,
    );
    return emailRegExp.hasMatch(_correoController.text);
  }
}
