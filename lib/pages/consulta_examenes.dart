// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movavid/api/api_laboratorio.dart';
import 'package:movavid/functions/examenes.dart';
import 'package:movavid/functions/show_toast.dart';
import 'package:movavid/models/examenes.dart';
import 'package:movavid/models/paciente.dart';
import 'package:movavid/pages/loading.dart';

class ConsultaExamenes extends StatefulWidget {
  final Paciente paciente;
  final String fecha;

  const ConsultaExamenes({
    super.key,
    required this.paciente,
    required this.fecha,
  });

  @override
  State<ConsultaExamenes> createState() => _ConsultaExamenesState();
}

String formatDate(String dateString) {
  final dateTime = DateTime.parse(dateString);
  final List<String> weekdays = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo'
  ];
  final monthNames = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];

  return '${weekdays[dateTime.weekday - 1]} ${dateTime.day} de ${monthNames[dateTime.month - 1]} de ${dateTime.year}';
}

class _ConsultaExamenesState extends State<ConsultaExamenes> {
  late final GlobalKey keyL;
  List<Examenes> examenes = [];
  List<Examenes> examenesFilter = [];
  List<String> listaFechas = [];
  FToast fToast = FToast();
  String fechae = '';
  late final List<DropdownMenuItem> _fechas;
  bool mirando = false;
  @override
  void initState() {
    super.initState();
    keyL = GlobalKey<State<StatefulWidget>>();
    fToast.init(context);
    //  pacientes = await getPacientes(context) as List<Paciente>;
    setState(() => mirando = !mirando);
    try {
      if (widget.fecha == '') {
        examenesPaciente(context, fToast,
                criterio: widget.paciente.identificacion!)
            .then((value) {
          if (value != null) {
            examenes = value;
            examenesFilter = examenes;
            if (fechae != "") {
              examenesFilter = examenes
                  .where((Examenes element) => element.fecha!.contains('-')
                      ? element.fecha == fechae
                      : element.fecha != '')
                  .toList();
            }
            setState(() {});
            setState(() => mirando = !mirando);
            Set<String> listafechas =
                Set.from(examenes.map((Examenes examen) => examen.fecha));
            print(listafechas);
            listaFechas.addAll(listafechas);
            listaFechas =
                ['Fecha del o de los examenes', 'Todos'] + listaFechas;
            int idx = 0;
            _fechas = listaFechas.map((e) {
              idx++;
              return DropdownMenuItem(
                value: e.contains('Fecha') ? '' : e,
                enabled: e != '',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e,
                      style: TextStyle(
                        color: e.contains('Fecha') || e.contains('Todos')
                            ? Colors.grey
                            : idx % 2 == 0
                                ? Colors.green
                                : Colors.amber,
                      ),
                    ),
                    Text(
                      e.contains('-') ? formatDate(e) : '',
                      style: const TextStyle(
                          fontSize: 10, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              );
            }).toList();
          } else {
            showToastB(fToast, 'Error en el sevidor');
          }
          setState(() {});
        });
      } else if (widget.fecha.contains('-')) {
        examenesPacienteFecha(context, fToast,
                fecha: widget.fecha,
                identificacion: widget.paciente.identificacion!)
            .then((value) {
          if (value != null) {
            examenes = value;
            examenesFilter = examenes;
            if (fechae != "") {
              examenesFilter = examenes
                  .where((Examenes element) => element.fecha!.contains('-')
                      ? element.fecha == fechae
                      : element.fecha != '')
                  .toList();
            }
            setState(() {});
            setState(() => mirando = !mirando);
            Set<String> listafechas =
                Set.from(examenes.map((Examenes examen) => examen.fecha));
            print(listafechas);
            listaFechas.addAll(listafechas);
            listaFechas =
                ['Fecha del o de los examenes', 'Todos'] + listaFechas;
            int idx = 0;
            _fechas = listaFechas.map((e) {
              idx++;
              return DropdownMenuItem(
                value: e.contains('Fecha') ? '' : e,
                enabled: e != '',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e,
                      style: TextStyle(
                        color: e.contains('Fecha') || e.contains('Todos')
                            ? Colors.grey
                            : idx % 2 == 0
                                ? Colors.green
                                : Colors.amber,
                      ),
                    ),
                    Text(
                      e.contains('-') ? formatDate(e) : '',
                      style: const TextStyle(
                          fontSize: 10, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              );
            }).toList();
          } else {
            showToastB(fToast, 'Error en el sevidor');
          }
          setState(() {});
        });
      }
    } catch (e) {
      showToastB(fToast, 'Error de Conexión a internet');
    }
  }

  String imageLab(String examen) {
    String result = '';
    if (examen.toLowerCase().contains('hemo') ||
        examen.toLowerCase().contains('hema')) {
      result = 'images/hemat.png';
      // ignore: curly_braces_in_flow_control_structures
    } else if (examen.toLowerCase().contains('coles') ||
        examen.toLowerCase().contains('trigli') ||
        examen.toLowerCase().contains('lip'))
    // ignore: curly_braces_in_flow_control_structures
    {
      result = 'images/hdl.png';
    } else if (examen.toLowerCase().contains('orina')) {
      result = 'images/porina.png';
    } else if (examen.toLowerCase().contains('copro')) {
      result = 'images/coprologico.png';
    } else if (examen.toLowerCase().contains('frotis')) {
      result = 'images/frotis.png';
    } else {
      result = 'images/lab.png';
    }
    return result;
  }

  Future<void> espera() async {
    // Simulate an asynchronous data fetch (e.g., network request)
    await Future.delayed(const Duration(seconds: 1));
    print('Listo!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.paciente.nombreCompleto,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${widget.paciente.identificacion!} ${widget.paciente.genero}',
              style: const TextStyle(fontSize: 10),
            ),
            Text(
              widget.paciente.edad,
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context, 'home');
              },
              icon: const Icon(Icons.home),
            ),
          ),
        ],
      ),
      body: examenes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                ListView.builder(
                  itemCount: examenesFilter.length + 1,
                  itemBuilder: (context, index) {
                    late String examen;
                    late String codexamen;
                    late String fecha;
                    late String tipo;
                    late bool realizado;
                    int indexx = index - 1;
                    if (index == 0) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(
                            18.0,
                          ),
                          child: DropdownButton(
                            value: fechae,
                            items: _fechas,
                            onChanged: (value) {
                              fechae = value;
                              examenesFilter = examenes
                                  .where((element) => value.contains('-')
                                      ? element.fecha == fechae
                                      : element.fecha != '')
                                  .toList();
                              setState(() {});
                            },
                          ),
                        ),
                      );
                    } else {
                      examen = examenesFilter[indexx].examen!;
                      codexamen = examenesFilter[indexx].codexamen!;
                      fecha = examenesFilter[indexx].fecha!;
                      tipo = examenesFilter[indexx].tipo!;
                      realizado = examenesFilter[indexx].realizado! == 'S';
                    }
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Card(
                        child: ListTile(
                          leading: Stack(
                            children: [
                              CircleAvatar(
                                radius: 25, // Ajusta el tamaño del avatar
                                backgroundImage: AssetImage(imageLab(examen)),
                              ),
                              realizado
                                  ? SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: Image.asset('images/check.png',
                                          scale: 0.5),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () async {
                              mirando = true;
                              setState(() {});
                              //   await espera();
                              await viewExam(
                                  // ignore: use_build_context_synchronously
                                  context,
                                  widget.paciente,
                                  codexamen,
                                  fecha,
                                  tipo,
                                  codexamen,
                                  examen,
                                  keyL);
                              mirando = false;
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.remove_red_eye,
                              color: Colors.blue,
                            ),
                          ),
                          title: Text(
                            examen,
                            style: const TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    fecha,
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '$tipo - $codexamen',
                                    style: const TextStyle(
                                      fontSize: 7,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                mirando
                    ? Center(
                        child: Opacity(
                          opacity: 0.4,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(168.0),
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
    );
  }

  Future<void> viewExam(
      BuildContext context,
      Paciente paciente,
      String codigo,
      String fecha,
      String tipo,
      String codexamen,
      String nombreExamen,
      final keyL) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Loading(
                key: keyL,
              )),
    );
    if (tipo == '1') {
      await examentipo_1(
          context, paciente, fecha, codexamen, nombreExamen, fToast);
      Navigator.pop(keyL.currentState!.context);
    } else if (tipo == '2') {
      await examentipo_2(
          context, paciente, fecha, codexamen, nombreExamen, fToast);
      Navigator.pop(keyL.currentState!.context);
    } else if (tipo == '5') {
      await hemogramas2(context, paciente, fecha, codexamen, fToast);
      Navigator.pop(keyL.currentState!.context);
    } else if (tipo == '3') {
      await parcialOrina2(context, paciente, fecha, codexamen, fToast);
      Navigator.pop(keyL.currentState!.context);
    } else if (tipo == '4') {
      await coprologico2(context, paciente, fecha, codexamen, fToast);
      Navigator.pop(keyL.currentState!.context);
    } else if (tipo == '6') {
      await frotisVaginal(context, paciente, fecha, codexamen, fToast);
      Navigator.pop(keyL.currentState!.context);
    } else if (tipo == '8') {
      await perfilLipidico(context, paciente, fecha, codexamen, fToast);
      Navigator.pop(keyL.currentState!.context);
    }
  }
}
