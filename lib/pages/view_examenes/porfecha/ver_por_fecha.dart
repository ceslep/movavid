// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movavid/api/api_laboratorio.dart';
import 'package:movavid/models/paciente.dart';
import 'package:movavid/pages/consulta_examenes.dart';
import 'package:movavid/widgets/app_page.dart';
import 'package:movavid/widgets/date_picker.dart';
import 'package:movavid/widgets/empty_state.dart';

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
        setState(() {
          consultando = true;
        });
        getPacientesFecha(context, _fechaController.text).then(
          (value) {
            pacientess = value;
            if (mounted) {
              setState(() {
                consultando = false;
              });
            }
          },
        );
      },
    );
    pacientess = widget.pacientes;
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return AppPage(
      title: 'Exámenes por fecha',
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: buildDatePicker(
              context,
              _fechaController,
              'Fecha de Exámenes',
            ),
          ),
          Expanded(
            child: consultando
                ? const Center(child: CircularProgressIndicator())
                : pacientess.isEmpty
                    ? EmptyState(
                        icon: Icons.event_busy_rounded,
                        title: 'No hay pacientes con exámenes',
                        subtitle:
                            'Cambie la fecha o registre exámenes para este día.',
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: pacientess.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final Paciente paciente = pacientess[index];
                          final String sexo = paciente.genero!;
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 24,
                                backgroundImage: AssetImage(
                                  sexo == 'Masculino'
                                      ? 'images/male.png'
                                      : 'images/female.png',
                                ),
                              ),
                              title: Text(
                                paciente.nombreCompleto,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                              subtitle: Text(
                                'CC: ${paciente.identificacion}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: scheme.onSurfaceVariant,
                                ),
                              ),
                              trailing: IconButton.filledTonal(
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
                                  if (result == 'home' && mounted) {
                                    Navigator.pop(context, 'home');
                                  }
                                },
                                tooltip: 'Ver exámenes',
                                icon: Icon(
                                  Icons.visibility_rounded,
                                  color: scheme.primary,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}