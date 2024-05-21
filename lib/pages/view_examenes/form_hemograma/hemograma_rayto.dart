// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:movavid/api/api_laboratorio.dart';
import 'package:movavid/functions/show_toast.dart';
import 'package:movavid/models/hemograma_rayto.dart';
import 'package:movavid/models/paciente.dart';
import 'package:movavid/pages/view_examenes/form_hemograma/form_hemograma.dart';
import 'package:movavid/providers/hrayto_provider.dart';
import 'package:movavid/providers/url_provider.dart';
import 'package:provider/provider.dart';

import '../../../widgets/modals/floating_modal.dart';
import '../../../widgets/modals/modal_fit.dart';

class ViewHemogramaRayto extends StatefulWidget {
  final HemogramaRayto hemograma;
  final Paciente paciente;
  final String fecha;
  final String codexamen;

  const ViewHemogramaRayto({
    super.key,
    required this.hemograma,
    required this.fecha,
    required this.paciente,
    required this.codexamen,
  });

  @override
  State<ViewHemogramaRayto> createState() => _ViewHemogramaRaytoState();
}

List<Map<String, dynamic>> parseText(String text) {
  final lines = text.split('\n');
  final List<Map<String, dynamic>> results = [];

  for (final line in lines) {
    if (line == '') continue;
    final parts = line.split(':');
    final key = parts[0].trim();
    final value = parts[1].trim();

    // Convertir a tipos de datos específicos

    results.add({
      key: value,
    });
  }

  return results;
}

class _ViewHemogramaRaytoState extends State<ViewHemogramaRayto> {
  void onFormHemogramaChange(FormHemograma formState) {}

  bool imprimiendo_ = false;
  bool guardando_ = false;
  FToast fToast = FToast();
  List<Map<String, dynamic>> dataHemograma = List.empty();
  String sistematizado = '';
  late HRaytoProvider hraytoProvider;
  late UrlProvider urlProvider;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    hraytoProvider = Provider.of<HRaytoProvider>(context, listen: false);
    urlProvider = Provider.of<UrlProvider>(context, listen: false);
    fToast.init(context);
    try {
      String resultadoExamen = widget.hemograma.sistematizado!;
      print(resultadoExamen);
      dataHemograma = parseText(resultadoExamen);
      print(dataHemograma);
    } catch (_) {
      showToastB(
        fToast,
        "Error al cargar los campos del hemograma o no existe.",
        bacgroundColor: Colors.red,
        frontColor: Colors.yellow,
        icon: const Icon(
          Icons.dangerous_outlined,
          color: Colors.lightGreenAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          textBaseline: TextBaseline.alphabetic,
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('images/hemat.png'),
            ),
            const SizedBox(width: 1),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hemograma Rayto 7600',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      widget.paciente.nombreCompleto,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      widget.fecha,
                      style: const TextStyle(
                        color: Colors.yellow,
                        fontSize: 8,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: !imprimiendo_
                ? IconButton(
                    tooltip: 'Imprimir pdf',
                    onPressed: () async {
                      setState(() {
                        imprimiendo_ = !imprimiendo_;
                      });
                      guardarHemograma(
                              context, hraytoProvider.hrayto, widget.codexamen)
                          .then(
                        (value) async {
                          setState(() {
                            imprimiendo_ = !imprimiendo_;
                          });
                          /*  if (Platform.isAndroid) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PDFRemoteViewer(
                                    urlpdf:
                                        "${urlProvider.url}print_hemograma.php",
                                    identificacion:
                                        widget.paciente.identificacion!,
                                    fecha: widget.fecha,
                                    nombres: widget.paciente.nombres!),
                              ),
                            );
                          } else  */
                          if (true) {
                            printPDFFile(
                              context,
                              "hemogramaRayto",
                              "Hemograma Sistematizado",
                              "hemograma_${widget.paciente.identificacion}_${widget.fecha}.pdf",
                              widget.paciente.identificacion!,
                              widget.fecha,
                              widget.paciente.nombreCompleto,
                              widget.paciente.edad,
                            );
                          }
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.print,
                      color: Colors.white,
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
            padding: const EdgeInsets.all(8),
            child: !guardando_
                ? IconButton(
                    tooltip: 'Guardar',
                    onPressed: () async {
                      setState(() {
                        guardando_ = !guardando_;
                      });
                      guardarHemograma(
                              context, hraytoProvider.hrayto, widget.codexamen)
                          .then(
                        (value) {
                          showFloatingModalBottomSheet(
                            context: context,
                            builder: (context) => const ModalFit(
                              title: 'Hemograma almacenado',
                              asset: 'images/hemat.png',
                            ),
                          );
                          setState(() {
                            guardando_ = !guardando_;
                          });
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.save,
                      color: Colors.lightGreenAccent,
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
      body: FormHemograma(
        hemograma: dataHemograma,
        identificacion: widget.paciente.identificacion!,
        fecha: widget.hemograma.fecha ??
            DateFormat('yyyy-MM-dd').format(DateTime.now()),
        observaciones: widget.hemograma.observaciones!,
      ),
    );
  }
}
