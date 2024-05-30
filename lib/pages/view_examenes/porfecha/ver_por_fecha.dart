// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movavid/api/api_laboratorio.dart';
import 'package:movavid/models/paciente.dart';
import 'package:movavid/widgets/date_picker.dart';

import '../../consulta_examenes.dart';

class VerPorFecha extends StatefulWidget {
  final List<Paciente> pacientes;
  const VerPorFecha({super.key, required this.pacientes});

  @override
  State<VerPorFecha> createState() => _VerPorFechaState();
}

class _VerPorFechaState extends State<VerPorFecha> {
  final TextEditingController _fechaController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));

  List<Paciente> pacientess = [];
  bool consultando = false;
  @override
  void initState() {
    super.initState();
    _fechaController.addListener(
      () {
        print(_fechaController.text);
        setState(() {
          consultando = !consultando;
        });
        getPacientesFecha(context, _fechaController.text).then(
          (value) {
            pacientess = value;
            setState(() {
              consultando = !consultando;
            });
          },
        );
      },
    );
    pacientess = widget.pacientes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lista de Pacientes',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: !consultando
          ? ListView.builder(
              itemCount: pacientess.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildDatePicker(
                        context,
                        _fechaController,
                        'Fecha de Exámenes',
                      ));
                } else {
                  int indexx = index - 1;
                  String nombreCompleto = pacientess[indexx].nombreCompleto;
                  String identificacion = pacientess[indexx].identificacion!;
                  String sexo = pacientess[indexx].genero!;
                  Paciente paciente = pacientess[indexx];
                  return Card(
                    child: ListTile(
                      title: Text(nombreCompleto),
                      subtitle: Text(identificacion),
                      leading: CircleAvatar(
                        backgroundImage: sexo == 'Masculino'
                            ? const AssetImage('images/male.png')
                            : const AssetImage('images/female.png'),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          var result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ConsultaExamenes(
                                paciente: paciente,
                                fecha: _fechaController.text,
                              ),
                            ),
                          );
                          if (result == 'home') {
                            if (mounted) {
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context, 'home');
                            }
                          }
                        },
                        icon: const Icon(Icons.remove_red_eye,
                            color: Colors.blue),
                      ),
                    ),
                  );
                }
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
