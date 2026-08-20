// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:movavid/api/api_laboratorio.dart';
import 'package:movavid/models/procedimientos_model.dart';
import 'package:movavid/widgets/app_page.dart';
import 'package:movavid/widgets/modals/floating_modal.dart';
import 'package:movavid/widgets/modals/modal_fit.dart';
import 'package:movavid/widgets/section_card.dart';

class ProcedimientosPage extends StatefulWidget {
  final Procedimientos procedimiento;
  const ProcedimientosPage({super.key, required this.procedimiento});

  @override
  State<ProcedimientosPage> createState() => _ProcedimientosPageState();
}

class _ProcedimientosPageState extends State<ProcedimientosPage> {
  bool guardando_ = false;
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController tablaController = TextEditingController();
  final TextEditingController infoController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController constanteController = TextEditingController();
  final TextEditingController unidadesController = TextEditingController();
  final TextEditingController tipoController = TextEditingController();
  final TextEditingController tipoProcedimientoController =
      TextEditingController();
  final TextEditingController abreviaturaController = TextEditingController();
  late Procedimientos procedimientoss;
  String color = "";
  List<String> colores = [];
  Color colc = Colors.white;
  bool nuevo = false;
  @override
  void initState() {
    super.initState();
    nombreController.text = widget.procedimiento.nombre!;
    tablaController.text = widget.procedimiento.tabla!;
    infoController.text = widget.procedimiento.info!;
    colorController.text = widget.procedimiento.color!;
    constanteController.text = widget.procedimiento.constante!;
    unidadesController.text = widget.procedimiento.unidades!;
    tipoController.text = widget.procedimiento.tipo!;
    tipoProcedimientoController.text = widget.procedimiento.tipoprocedimiento!;
    abreviaturaController.text = widget.procedimiento.abreviatura!;
    procedimientoss = widget.procedimiento;
  }

  void _nuevo() {
    setState(() {
      nuevo = true;
      procedimientoss = Procedimientos();
      nombreController.text = '';
      tablaController.text = '';
      infoController.text = '';
      unidadesController.text = '';
      tipoController.text = '';
      tipoProcedimientoController.text = '';
      abreviaturaController.text = '';
      colorController.text = '';
    });
  }

  void _guardar() {
    if (nombreController.text.isEmpty) return;
    setState(() => guardando_ = true);
    guardarProcedimiento(context, procedimientoss).then((value) {
      if (!mounted) return;
      showFloatingModalBottomSheet(
        context: context,
        builder: (context) => const ModalFit(
          title: 'Exámen actualizado',
          asset: 'images/logo.png',
        ),
      );
      setState(() => guardando_ = false);
    });
  }

  Widget _campo(String label, TextEditingController controller,
      {bool readOnly = false, int minLines = 1, int maxLines = 1}) {
    return TextFormField(
      readOnly: readOnly && !nuevo,
      minLines: minLines,
      maxLines: maxLines,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: label,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return AppPage(
      title: 'Exámen ${widget.procedimiento.codigo}',
      actions: [
        IconButton(
          onPressed: _nuevo,
          tooltip: 'Nuevo examen',
          icon: const Icon(Icons.new_releases_rounded),
        ),
        IconButton(
          onPressed: guardando_ ? null : _guardar,
          tooltip: 'Guardar',
          icon: guardando_
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Icon(Icons.save_rounded, color: scheme.primary),
        ),
      ],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          onChanged: () => {
            procedimientoss.color = colorController.text,
            procedimientoss.unidades = unidadesController.text,
            procedimientoss.constante = constanteController.text,
            procedimientoss.info = infoController.text,
            procedimientoss.tipoprocedimiento =
                tipoProcedimientoController.text,
            procedimientoss.abreviatura = abreviaturaController.text,
            color = colorController.text,
            if (color.isNotEmpty)
              {
                colores = color.split(";"),
                if (colores.length == 3)
                  {
                    colc = Color.fromARGB(0, int.parse(colores[0]),
                        int.parse(colores[1]), int.parse(colores[2])),
                    setState(() {})
                  }
              }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SectionCard(
                title: 'Información general',
                icon: Icons.info_rounded,
                child: Column(
                  children: [
                    _campo('Nombre Exámen', nombreController,
                        readOnly: true, minLines: 1, maxLines: 3),
                    const SizedBox(height: 12),
                    _campo('Tabla', tablaController, readOnly: true),
                    const SizedBox(height: 12),
                    _campo('Tipo', tipoController, readOnly: true),
                    const SizedBox(height: 12),
                    _campo(
                        'Tipo de Procedimiento', tipoProcedimientoController),
                    const SizedBox(height: 12),
                    _campo('Abreviatura', abreviaturaController),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              SectionCard(
                title: 'Valores del examen',
                icon: Icons.science_rounded,
                child: Column(
                  children: [
                    _campo('Info', infoController, minLines: 1, maxLines: 3),
                    const SizedBox(height: 12),
                    _campo('Constante', constanteController),
                    const SizedBox(height: 12),
                    _campo('Unidades', unidadesController),
                    const SizedBox(height: 12),
                    TextFormField(
                      onChanged: (value) {},
                      controller: colorController,
                      decoration: InputDecoration(
                        labelText: 'Color',
                        hintText: 'Color (r;g;b)',
                        fillColor: colc,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: guardando_ ? null : _guardar,
                icon: guardando_
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.save_rounded),
                label: Text(guardando_ ? 'Guardando...' : 'Guardar Exámen'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}