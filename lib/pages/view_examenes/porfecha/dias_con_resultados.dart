// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movavid/api/api_laboratorio.dart';
import 'package:movavid/models/examenes.dart';
import 'package:movavid/models/paciente.dart';
import 'package:movavid/pages/view_examenes/porfecha/ver_por_fecha.dart';
import 'package:movavid/theme/app_theme.dart';
import 'package:movavid/widgets/app_page.dart';
import 'package:movavid/widgets/empty_state.dart';
import 'package:movavid/widgets/hover_card.dart';

class DiasConResultados extends StatefulWidget {
  const DiasConResultados({super.key});

  @override
  State<DiasConResultados> createState() => _DiasConResultadosState();
}

class _DiaResumen {
  final String fecha;
  int total = 0;
  int realizados = 0;
  final Set<String> pacientes = {};

  _DiaResumen({required this.fecha});
}

class _DiasConResultadosState extends State<DiasConResultados> {
  List<_DiaResumen> _dias = [];
  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    _cargar();
  }

  Future<void> _cargar() async {
    setState(() => _cargando = true);
    final FToast fToast = FToast()..init(context);
    final List<Examenes>? examenes =
        await examenesPaciente(context, fToast);
    if (!mounted) return;

    final Map<String, _DiaResumen> mapa = {};
    for (final Examenes examen in examenes ?? <Examenes>[]) {
      final String? fecha = examen.fecha;
      if (fecha == null || fecha.isEmpty || !fecha.contains('-')) continue;
      final _DiaResumen resumen =
          mapa.putIfAbsent(fecha, () => _DiaResumen(fecha: fecha));
      resumen.total++;
      if (examen.realizado == 'S') resumen.realizados++;
      final String? id = examen.identificacion;
      if (id != null && id.isNotEmpty) resumen.pacientes.add(id);
    }

    final List<_DiaResumen> dias = mapa.values.toList()
      ..sort((a, b) => b.fecha.compareTo(a.fecha));

    setState(() {
      _dias = dias;
      _cargando = false;
    });
  }

  Future<void> _abrirDia(_DiaResumen dia) async {
    final List<Paciente> pacientes =
        await getPacientesFecha(context, dia.fecha);
    if (!mounted) return;
    if (pacientes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No hay pacientes registrados para el ${_fechaLarga(dia.fecha)}'),
        ),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerPorFecha(pacientes: pacientes),
      ),
    );
  }

  String _fechaLarga(String fecha) {
    const List<String> dias = [
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado',
      'Domingo'
    ];
    const List<String> meses = [
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
    final DateTime dt = DateTime.parse(fecha);
    return '${dias[dt.weekday - 1]}, ${dt.day} de ${meses[dt.month - 1]} de ${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return AppPage(
      title: 'Días con resultados',
      actions: [
        IconButton(
          onPressed: _cargando ? null : _cargar,
          tooltip: 'Actualizar',
          icon: Icon(
            Icons.refresh_rounded,
            color: _cargando ? scheme.onSurfaceVariant : scheme.primary,
          ),
        ),
      ],
      body: _cargando
          ? const Center(child: CircularProgressIndicator())
          : _dias.isEmpty
              ? EmptyState(
                  icon: Icons.event_note_rounded,
                  title: 'Sin resultados registrados',
                  subtitle:
                      'Cuando se registren exámenes, aquí aparecerán los días con resultados.',
                  action: FilledButton.icon(
                    onPressed: _cargar,
                    icon: const Icon(Icons.refresh_rounded, size: 18),
                    label: const Text('Actualizar'),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _cargar,
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: _dias.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final _DiaResumen dia = _dias[index];
                      final DateTime dt = DateTime.parse(dia.fecha);
                      return HoverCard(
                        onTap: () => _abrirDia(dia),
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          children: [
                            Container(
                              width: 54,
                              height: 54,
                              decoration: BoxDecoration(
                                gradient: Theme.of(context).gradients.brand,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${dt.day}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      height: 1,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    _mesCorto(dt.month),
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.9),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _fechaLarga(dia.fecha),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w800,
                                      color: scheme.onSurface,
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                  const SizedBox(height: 7),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 6,
                                    children: [
                                      _pill(
                                        context,
                                        Icons.biotech_rounded,
                                        '${dia.total} exámenes',
                                      ),
                                      _pill(
                                        context,
                                        Icons.people_alt_rounded,
                                        '${dia.pacientes.length} pacientes',
                                      ),
                                      if (dia.realizados > 0)
                                        _pill(
                                          context,
                                          Icons.check_circle_rounded,
                                          '${dia.realizados} realizados',
                                          destacado: true,
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              color: scheme.onSurfaceVariant.withValues(alpha: 0.6),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
    );
  }

  String _mesCorto(int mes) {
    const List<String> meses = [
      'ENE', 'FEB', 'MAR', 'ABR', 'MAY', 'JUN',
      'JUL', 'AGO', 'SEP', 'OCT', 'NOV', 'DIC'
    ];
    return meses[mes - 1];
  }

  Widget _pill(
    BuildContext context,
    IconData icon,
    String text, {
    bool destacado = false,
  }) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Color color = destacado ? scheme.primary : scheme.onSurfaceVariant;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}