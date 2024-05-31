// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:movavid/api/api_laboratorio.dart';
import 'package:movavid/functions/examenes.dart';
import 'package:movavid/models/examen-model.dart';
import 'package:movavid/models/examen_tipo1_model.dart';
import 'package:movavid/models/paciente.dart';
import 'package:movavid/widgets/modals/floating_modal.dart';
import 'package:movavid/widgets/modals/modal_fit.dart';
import 'package:movavid/widgets/text_field.dart';

class ViewExamenTipo1 extends StatefulWidget {
  final ExamenTipo1 examen;
  final Paciente paciente;
  final String fecha;
  final String codexamen;
  final List<CodExamen> exameneswi;
  const ViewExamenTipo1({
    super.key,
    required this.examen,
    required this.paciente,
    required this.fecha,
    required this.codexamen,
    required this.exameneswi,
  });

  @override
  State<ViewExamenTipo1> createState() => _ViewExamenTipo1State();
}

class _ViewExamenTipo1State extends State<ViewExamenTipo1> {
  bool guardando_ = false;
  ExamenTipo1 examenS = ExamenTipo1();
  late TextEditingController valoracionController;
  late TextEditingController observacionesController;
  @override
  void initState() {
    super.initState();
    try {
      valoracionController =
          TextEditingController(text: widget.examen.valoracion!);
      observacionesController =
          TextEditingController(text: widget.examen.observaciones!);
    } catch (e) {
      print(e);
    }

    examenS = widget.examen;
  }

  @override
  Widget build(BuildContext context) {
    String nexamen = widget.examen.nombreExamen!;
    /*  nexamen = nexamen.length > 25
        ? (widget.examen.nombreExamen!).substring(0, 25)
        : nexamen; */
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        foregroundColor: Colors.black,
        title: const Text(
          'Registro de Exámenes',
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          /*  IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WebViewLab()),
              );
            },
            icon: const Icon(Icons.web),
          ), */
          Padding(
            padding: const EdgeInsets.only(right: 1.0),
            child: !guardando_
                ? IconButton(
                    onPressed: () async {
                      setState(() => guardando_ = !guardando_);
                      guardarTipo1(context, examenS, widget.codexamen).then(
                        (value) {
                          if (true) {
                            printPDFFile(
                              context,
                              "examen_tipo_1",
                              widget.examen.nombreExamen!,
                              "${widget.examen.nombreExamen!}_${widget.paciente.identificacion}_${widget.fecha}.pdf",
                              widget.paciente.identificacion!,
                              widget.fecha,
                              widget.paciente.nombreCompleto,
                              widget.paciente.edad,
                            );
                          }
                          setState(() => guardando_ = !guardando_);
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.print,
                      color: Colors.brown,
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: SizedBox(
                      width: 13,
                      height: 13,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: !guardando_
                ? IconButton(
                    onPressed: () async {
                      setState(() => guardando_ = !guardando_);
                      guardarTipo1(context, examenS, widget.codexamen).then(
                        (value) {
                          showFloatingModalBottomSheet(
                            context: context,
                            builder: (context) => ModalFit(
                              title:
                                  '${examenS.nombreExamen!} almacenada con éxito',
                              asset: 'images/porina.png',
                            ),
                          );
                          setState(() => guardando_ = !guardando_);
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.save,
                      color: Colors.blueGrey,
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: SizedBox(
                      width: 13,
                      height: 13,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('images/lab.png'),
                ),
                const SizedBox(width: 2),
                Container(
                  constraints: const BoxConstraints(maxWidth: 250),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              nexamen,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const Text('', style: TextStyle(fontSize: 6))
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                widget.paciente.nombreCompleto,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.green),
                              ),
                              Text(
                                widget.fecha,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.blueGrey,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Form(
            onChanged: () {
              examenS.valoracion = valoracionController.text;
              examenS.observaciones = observacionesController.text;
              examenS.identificacion = widget.paciente.identificacion;
              examenS.fecha = widget.fecha;
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 0.76 * MediaQuery.of(context).size.width,
                        child: TextFieldI(
                            labelText: 'Valoración',
                            controller: valoracionController,
                            dropdown: examenesWithItems(
                                widget.codexamen, widget.exameneswi),
                            codexamen: widget.codexamen,
                            nombreExamen: nexamen,
                            campo: 'Valoracion'),
                      ),
                      SizedBox(
                        width: 0.1 * MediaQuery.of(context).size.width,
                        child: Text(widget.examen.unidades!),
                      ),
                      SizedBox(
                        width: 0.1 * MediaQuery.of(context).size.width,
                        child: Text('Normal: ${widget.examen.constant!}'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 0.95 * MediaQuery.of(context).size.width,
                  child: TextFieldI(
                      labelText: 'Observaciones',
                      controller: observacionesController),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
