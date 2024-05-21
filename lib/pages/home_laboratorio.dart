import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movavid/api/api_laboratorio.dart';
import 'package:movavid/models/paciente.dart';
import 'package:movavid/pages/configuracion/configuracion.dart';
import 'package:movavid/pages/lista_pacientes.dart';
import 'package:movavid/pages/view_examenes/porfecha/ver_por_fecha.dart';
import 'package:movavid/widgets/home/home_fl.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Homemovavid extends StatefulWidget {
  const Homemovavid({super.key, required this.title});

  final String title;

  @override
  State<Homemovavid> createState() => _HomemovavidState();
}

class _HomemovavidState extends State<Homemovavid> {
  bool listando = false;

  final TextEditingController _fechaController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Configuracion()),
                );
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.blueGrey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 2.0, right: 2),
            child: !listando
                ? IconButton(
                    onPressed: () {
                      String fecha =
                          DateFormat('yyyy-MM-dd').format(DateTime.now());
                      setState(() {
                        listando = !listando;
                      });
                      getPacientesFecha(context, fecha).then(
                        (value) {
                          setState(() {
                            listando = !listando;
                          });
                          List<Paciente> pacientes = value;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VerPorFecha(
                                pacientes: pacientes,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.calendar_month,
                      color: Colors.purple,
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.only(left: 2, right: 2),
                    child: SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListaPacientes(),
                    ));
              },
              icon: Icon(
                MdiIcons.listBox,
                color: Colors.deepPurpleAccent,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: IconButton(
              onPressed: () {
                exit(0);
              },
              icon: Icon(
                MdiIcons.exitToApp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: BodyHome(fechaController: _fechaController),
      floatingActionButton: FloatingActionButtonHome(
        fecha: _fechaController.text,
      ),
    );
  }
}
