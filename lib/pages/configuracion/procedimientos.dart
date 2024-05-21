// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:movavid/api/api_laboratorio.dart';
import 'package:movavid/models/procedimientos_model.dart';
import 'package:movavid/widgets/modals/floating_modal.dart';
import 'package:movavid/widgets/modals/modal_fit.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.lightGreenAccent,
        title: Text('Editar Exámen ${widget.procedimiento.codigo}'),
        actions: [
          IconButton(
            onPressed: () {
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
            },
            icon: const Icon(Icons.new_releases, color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: !guardando_
                ? IconButton(
                    onPressed: () async {
                      if (nombreController.text.isEmpty) return;
                      setState(() => guardando_ = !guardando_);
                      guardarProcedimiento(context, procedimientoss)
                          .then((value) {
                        showFloatingModalBottomSheet(
                          context: context,
                          builder: (context) => const ModalFit(
                            title: 'Exámen actualizado',
                            asset: 'images/logo.png',
                          ),
                        );
                        setState(() => guardando_ = !guardando_);
                      });
                    },
                    icon: const Icon(Icons.save),
                  )
                : const Padding(
                    padding: EdgeInsets.only(right: 14),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
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
              print(procedimientoss.toJson()),
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
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true && !nuevo,
                    minLines: 1,
                    maxLines: 3,
                    controller: nombreController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nombre Exámen',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true && !nuevo,
                    controller: tablaController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Tabla',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    minLines: 1,
                    maxLines: 3,
                    controller: infoController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Info',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {},
                    controller: colorController,
                    decoration: InputDecoration(
                      fillColor: colc,
                      border: const OutlineInputBorder(),
                      labelText: 'Color',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: constanteController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Constante',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: unidadesController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Unidades',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true && !nuevo,
                    controller: tipoController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Tipo',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: tipoProcedimientoController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Tipo de Procedimiento',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: abreviaturaController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Abreviatura',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
