// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movavid/api/api_laboratorio.dart';
import 'package:movavid/functions/show_toast.dart';
import 'package:movavid/models/paciente.dart';
import 'package:movavid/models/procedimientos_model.dart';
import 'package:movavid/pages/configuracion/procedimientos.dart';
import 'package:movavid/pages/creacion_de_examenes/mostrar_seleccionados.dart';

class AsignarExamenes extends StatefulWidget {
  final Paciente paciente;
  final String fecha;
  final List<Procedimientos> procedimientos;
  final List<bool>? checkeds;
  const AsignarExamenes(
      {super.key,
      required this.procedimientos,
      this.checkeds,
      required this.paciente,
      required this.fecha});

  @override
  State<AsignarExamenes> createState() => _AsignarExamenesState();
}

class _AsignarExamenesState extends State<AsignarExamenes> {
  List<bool> _isCheckedList = [];
  late List<Procedimientos> procedimientoss;
  final TextEditingController busquedaController = TextEditingController();
  List<Procedimientos> seleccionados = [];
  FToast fToast = FToast();
  bool editando = false;
  int seleccionadox = -1;
  @override
  void initState() {
    super.initState();
    fToast.init(context);
    print({widget.checkeds});
    if ((widget.checkeds == null)) {
      _isCheckedList = List<bool>.filled(widget.procedimientos.length, false);
    } else {
      if (widget.checkeds!.isNotEmpty) {
        _isCheckedList = widget.checkeds!;
      }
    }
    procedimientoss = widget.procedimientos;
    getSeleccionados(context, widget.paciente.identificacion!, widget.fecha)
        .then(
      (value) {
        seleccionados = value;
        setState(() {});
      },
    );
  }

  bool siselect(String examen) {
    return seleccionados.isNotEmpty
        ? seleccionados.indexWhere(
                (Procedimientos element) => element.nombre! == examen) >=
            0
        : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Seleccione los Exámenes',
          style: TextStyle(fontSize: 14),
        ),
        backgroundColor: Colors.red.shade100,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, _isCheckedList),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: const Icon(Icons.remove_red_eye),
              onPressed: () async {
                List<Procedimientos> result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MostrarSeleccionados(
                      paciente: widget.paciente,
                      fecha: widget.fecha,
                      seleccionados: seleccionados,
                      aguardar: false,
                    ),
                  ),
                );
                seleccionados = result;
                setState(() {});
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: const Icon(Icons.done),
              onPressed: () async {
                if (seleccionados.isNotEmpty) {
                  var result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MostrarSeleccionados(
                        paciente: widget.paciente,
                        fecha: widget.fecha,
                        seleccionados: seleccionados,
                        aguardar: true,
                      ),
                    ),
                  );
                  if (result == 'home') {
                    if (mounted) {
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context, 'home');
                    }
                  }
                } else {
                  showToastB(
                    fToast,
                    'No ha seleccionado ningún examen',
                    bacgroundColor: Colors.red,
                    frontColor: Colors.yellow,
                    milliseconds: 10,
                    icon: const Icon(
                      Icons.error,
                      color: Colors.yellow,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: procedimientoss.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    busqueda(value);
                  },
                  controller: busquedaController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Busqueda de Examenes',
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {
                          busquedaController.clear();
                          busqueda('');
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                ),
              );
            } else if (index == 1) {
              return const SizedBox();
            } else {
              int indexx = index - 2;
              String nombreExamen = procedimientoss[indexx].nombre!;
              String codigoExamen = procedimientoss[indexx].codigo!;
              bool seleccionado = siselect(nombreExamen);
              MaterialStateProperty<Color> bgColorn =
                  MaterialStateProperty.resolveWith(
                      (states) => const Color.fromARGB(255, 78, 39, 78));
              MaterialStateProperty<Color> bgColors =
                  MaterialStateProperty.resolveWith(
                      (states) => const Color.fromARGB(255, 255, 188, 255));
              MaterialStateProperty<Color> bgColor =
                  seleccionado ? bgColors : bgColorn;
              return Card(
                color: _isCheckedList[indexx]
                    ? Colors.amber.shade50
                    : Colors.white,
                child: ListTile(
                  title: Text(
                    nombreExamen,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  leading: !editando && seleccionadox == -1
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              seleccionadox = indexx;
                              editando = !editando;
                            });
                            getProcedimiento(context, codigoExamen).then(
                              (Procedimientos value) {
                                setState(() {
                                  editando = !editando;
                                  seleccionadox = -1;
                                });
                                Procedimientos procedimiento = value;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProcedimientosPage(
                                          procedimiento: procedimiento)),
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.settings_applications_rounded),
                        )
                      : indexx == seleccionadox
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                  strokeWidth: 2,
                                ),
                              ),
                            )
                          : const Icon(Icons.settings_applications_rounded),
                  trailing: ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.resolveWith(
                          (states) => const Color.fromARGB(255, 229, 255, 136)),
                      backgroundColor: bgColor,
                    ),
                    onPressed: () {
                      print(seleccionado);
                      if (!seleccionado) {
                        seleccionados.add(procedimientoss[indexx]);
                      } else {
                        int indice = seleccionados.indexWhere(
                            (Procedimientos element) =>
                                element.nombre == nombreExamen);
                        if (indice >= 0) {
                          seleccionados.removeAt(indice);
                        }
                      }
                      setState(() {});
                    },
                    child: !seleccionado
                        ? const Icon(Icons.add)
                        : const Icon(Icons.check),
                  ),
                ),
              );
            }
          }),
    );
  }

  void busqueda(value) {
    if (value.length > 3) {
      procedimientoss = widget.procedimientos
          .where((Procedimientos procedimiento) =>
              procedimiento.nombre!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    } else {
      procedimientoss = widget.procedimientos;
    }
    setState(() {});
  }
}
