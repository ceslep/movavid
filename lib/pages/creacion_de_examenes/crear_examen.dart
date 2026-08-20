// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movavid/api/api_laboratorio.dart';
import 'package:movavid/models/paciente.dart';
import 'package:movavid/models/procedimientos_model.dart';
import 'package:movavid/pages/creacion_de_examenes/asignar_examenes.dart';
import 'package:movavid/widgets/app_page.dart';
import 'package:movavid/widgets/date_picker.dart';
import 'package:movavid/widgets/section_card.dart';

class CrearExamen extends StatefulWidget {
  const CrearExamen({
    super.key,
  });

  @override
  State<CrearExamen> createState() => _CrearExamenState();
}

class _CrearExamenState extends State<CrearExamen> {
  bool cargandoProcedimientos = false;
  Paciente paciente = Paciente();
  Uri url = Uri();
  final TextEditingController _fechaController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));

  final TextEditingController _identificacionController =
      TextEditingController();
  bool buscando = false;

  @override
  void initState() {
    super.initState();
    _identificacionController.addListener(
      () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return AppPage(
      title: 'Crear Exámenes',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SectionCard(
              title: 'Fecha de los exámenes',
              icon: Icons.event_rounded,
              child: buildDatePicker(
                context,
                _fechaController,
                'Fecha de Exámenes',
              ),
            ),
            const SizedBox(height: 14),
            SectionCard(
              title: 'Paciente',
              icon: Icons.person_search_rounded,
              child: Column(
                children: [
                  Form(
                    child: Focus(
                      onKeyEvent: (node, event) {
                        if (event.logicalKey.keyLabel == 'Enter') {
                          getInfoPac(context);
                        }
                        return KeyEventResult.ignored;
                      },
                      child: TextFormField(
                        onChanged: (value) {
                          if (value.length < 3) {
                            setState(() => paciente = Paciente());
                          }
                        },
                        autofocus: true,
                        controller: _identificacionController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Paciente',
                          hintText: 'Identificación del paciente',
                          prefixIcon: Icon(Icons.badge_rounded),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: buscando
                          ? null
                          : () async {
                              await getInfoPac(context);
                            },
                      icon: buscando
                          ? const SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : const Icon(Icons.search_rounded),
                      label: Text(buscando ? 'Buscando...' : 'Buscar'),
                    ),
                  ),
                ],
              ),
            ),
            if (paciente.nombres != null) ...[
              const SizedBox(height: 14),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: AssetImage(
                              paciente.genero == 'Masculino'
                                  ? 'images/male.png'
                                  : 'images/female.png',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${paciente.nombres} ${paciente.apellidos}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Text(
                                  '${paciente.edad} • ${paciente.genero}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: scheme.onSurfaceVariant,
                                  ),
                                ),
                                Text(
                                  'Fecha: ${_fechaController.text}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: scheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: cargandoProcedimientos
                              ? null
                              : () async {
                                  setState(() {
                                    cargandoProcedimientos = true;
                                  });
                                  getProcedimientos(context).then(
                                    (value) async {
                                      if (!mounted) return;
                                      setState(() {
                                        cargandoProcedimientos = false;
                                      });
                                      List<Procedimientos> procedimientos =
                                          value;
                                      var result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AsignarExamenes(
                                            paciente: paciente,
                                            fecha: _fechaController.text,
                                            procedimientos: procedimientos,
                                          ),
                                        ),
                                      );
                                      if (result == 'home' && mounted) {
                                        Navigator.pop(context, 'home');
                                      }
                                    },
                                  );
                                },
                          icon: cargandoProcedimientos
                              ? const SizedBox(
                                  width: 14,
                                  height: 14,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.assignment_add),
                          label: Text(cargandoProcedimientos
                              ? 'Cargando...'
                              : 'Asignar Exámenes'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> getInfoPac(BuildContext context) async {
    setState(() => buscando = true);
    paciente = await getInfoPaciente(context,
        identificacion: _identificacionController.text);
    if (mounted) setState(() => buscando = false);
  }
}