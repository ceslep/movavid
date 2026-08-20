// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movavid/api/api_laboratorio.dart';
import 'package:movavid/functions/examenes.dart';
import 'package:movavid/functions/show_toast.dart';
import 'package:movavid/models/examen-model.dart';
import 'package:movavid/models/examenes.dart';
import 'package:movavid/models/paciente.dart';
import 'package:movavid/pages/loading.dart';
import 'package:movavid/widgets/app_page.dart';
import 'package:movavid/widgets/empty_state.dart';
import 'package:movavid/widgets/hover_card.dart';
import 'package:movavid/widgets/loading_overlay.dart';
import 'package:movavid/widgets/status_pill.dart';

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
  bool mirando = false;
  bool _error = false;
  @override
  void initState() {
    super.initState();
    keyL = GlobalKey<State<StatefulWidget>>();
    fToast.init(context);
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
            _error = false;
            setState(() {});
            Set<String> listafechas =
                Set.from(examenes.map((Examenes examen) => examen.fecha));
            listaFechas = ['Todos'] + listafechas.toList();
            if (mounted) setState(() {});
          } else {
            _error = true;
            showToastB(fToast, 'Error en el sevidor');
          }
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
            _error = false;
            setState(() {});
            Set<String> listafechas =
                Set.from(examenes.map((Examenes examen) => examen.fecha));
            listaFechas = ['Todos'] + listafechas.toList();
            if (mounted) setState(() {});
          } else {
            _error = true;
            showToastB(fToast, 'Error en el sevidor');
          }
        });
      }
    } catch (e) {
      _error = true;
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

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return AppPage(
      title: 'Exámenes del paciente',
      titleWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.paciente.nombreCompleto,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '${widget.paciente.identificacion!} • ${widget.paciente.genero} • ${widget.paciente.edad}',
            style: TextStyle(
              fontSize: 11,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pop(context, 'home');
          },
          tooltip: 'Inicio',
          icon: const Icon(Icons.home_rounded),
        ),
      ],
      body: LoadingOverlay(
        visible: mirando,
        message: 'Cargando examen...',
        child: examenes.isEmpty && !_error
            ? const Center(child: CircularProgressIndicator())
            : examenes.isEmpty && _error
                ? const EmptyState(
                    icon: Icons.cloud_off_rounded,
                    title: 'No se pudieron cargar los exámenes',
                    subtitle:
                        'Compruebe su conexión a internet e intente de nuevo.',
                  )
                : Column(
                      children: [
                        if (listaFechas.length > 1)
                          SizedBox(
                            height: 56,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              itemCount: listaFechas.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 8),
                              itemBuilder: (context, index) {
                                final String fechaItem = listaFechas[index];
                                final bool isAll = fechaItem == 'Todos';
                                final bool selected = isAll
                                    ? fechae == ''
                                    : fechae == fechaItem;
                                return Center(
                                  child: ChoiceChip(
                                    label: Text(isAll
                                        ? 'Todos'
                                        : formatDate(fechaItem)),
                                    selected: selected,
                                    showCheckmark: false,
                                    onSelected: (_) {
                                      fechae = isAll ? '' : fechaItem;
                                      examenesFilter = examenes
                                          .where((element) =>
                                              fechae == '' ||
                                              (element.fecha!.contains('-')
                                                  ? element.fecha == fechae
                                                  : element.fecha != ''))
                                          .toList();
                                      setState(() {});
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        Expanded(
                          child: examenesFilter.isEmpty
                              ? const EmptyState(
                                  icon: Icons.search_off_rounded,
                                  title: 'Sin exámenes en esta fecha',
                                )
                              : ListView.separated(
                                  padding: const EdgeInsets.all(16),
                                  itemCount: examenesFilter.length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(height: 10),
                                  itemBuilder: (context, index) {
                                    final Examenes item =
                                        examenesFilter[index];
                                    final String examen = item.examen!;
                                    final String codexamen = item.codexamen!;
                                    final String fecha = item.fecha!;
                                    final String tipo = item.tipo!;
                                    final bool realizado =
                                        item.realizado! == 'S';
                                    return HoverCard(
                                      onTap: () async {
                                        await _abrirExamen(item);
                                      },
                                      padding: const EdgeInsets.all(12),
                                      child: Row(
                                        children: [
                                          Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              CircleAvatar(
                                                radius: 26,
                                                backgroundImage: AssetImage(
                                                    imageLab(examen)),
                                              ),
                                              if (realizado)
                                                Positioned(
                                                  right: -4,
                                                  bottom: -4,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(2),
                                                    decoration: BoxDecoration(
                                                      color: scheme
                                                          .primaryContainer,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: const Icon(
                                                      Icons.check_rounded,
                                                      size: 14,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  examen,
                                                  style: TextStyle(
                                                    color: scheme.onSurface,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .calendar_month_rounded,
                                                      size: 13,
                                                      color: scheme
                                                          .onSurfaceVariant,
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      fecha,
                                                      style: TextStyle(
                                                        color: scheme
                                                            .onSurfaceVariant,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 4),
                                                Wrap(
                                                  spacing: 6,
                                                  runSpacing: 4,
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.center,
                                                  children: [
                                                    StatusPill(
                                                      label: realizado
                                                          ? 'Realizado'
                                                          : 'Pendiente',
                                                      icon: realizado
                                                          ? Icons
                                                              .check_circle_rounded
                                                          : Icons
                                                              .schedule_rounded,
                                                      color: realizado
                                                          ? Colors.green
                                                          : Colors.orange,
                                                    ),
                                                    Text(
                                                      '$tipo - $codexamen',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        color: scheme
                                                            .onSurfaceVariant,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          IconButton.filledTonal(
                                            onPressed: () async {
                                              await _abrirExamen(item);
                                            },
                                            tooltip: 'Ver examen',
                                            icon: Icon(
                                              Icons.visibility_rounded,
                                              color: scheme.primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
        ),
    );
  }

  Future<void> _abrirExamen(Examenes item) async {
    mirando = true;
    setState(() {});
    await viewExam(
      context,
      widget.paciente,
      item.codexamen!,
      item.fecha!,
      item.tipo!,
      item.codexamen!,
      item.examen!,
      keyL,
    );
    mirando = false;
    if (mounted) setState(() {});
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
    getExamenesWithItems(context).then((value) async {
      List<CodExamen> exameneswi = value;
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Loading(
                  key: keyL,
                )),
      );
      if (tipo == '1') {
        await examentipo_1(context, paciente, fecha, codexamen, nombreExamen,
            exameneswi, fToast);
        Navigator.pop(keyL.currentState!.context);
      } else if (tipo == '2') {
        await examentipo_2(context, paciente, fecha, codexamen, nombreExamen,
            exameneswi, fToast);
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
    });
  }
}