// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movavid/api/api_laboratorio.dart';
import 'package:movavid/functions/show_toast.dart';
import 'package:movavid/models/paciente.dart';
import 'package:movavid/models/procedimientos_model.dart';
import 'package:movavid/pages/configuracion/procedimientos.dart';
import 'package:movavid/pages/creacion_de_examenes/mostrar_seleccionados.dart';
import 'package:movavid/widgets/app_page.dart';
import 'package:movavid/widgets/empty_state.dart';
import 'package:movavid/widgets/search_field.dart';

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
    procedimientoss = widget.procedimientos;
    getSeleccionados(context, widget.paciente.identificacion!, widget.fecha)
        .then(
      (value) {
        seleccionados = value;
        if (mounted) setState(() {});
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

  void _abrirEditar(int indexx) {
    setState(() {
      seleccionadox = indexx;
      editando = !editando;
    });
    getProcedimiento(context, procedimientoss[indexx].codigo!).then(
      (Procedimientos value) {
        if (!mounted) return;
        setState(() {
          editando = !editando;
          seleccionadox = -1;
        });
        Procedimientos procedimiento = value;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ProcedimientosPage(procedimiento: procedimiento)),
        );
      },
    );
  }

  void _toggleSeleccion(int indexx) {
    Procedimientos proc = procedimientoss[indexx];
    if (!siselect(proc.nombre!)) {
      seleccionados.add(proc);
    } else {
      int indice = seleccionados.indexWhere(
          (Procedimientos element) => element.nombre == proc.nombre);
      if (indice >= 0) {
        seleccionados.removeAt(indice);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return AppPage(
      title: 'Seleccione los Exámenes',
      titleWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Seleccione los Exámenes',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          Text(
            '${widget.paciente.nombreCompleto} • ${seleccionados.length} seleccionados',
            style: TextStyle(
              fontSize: 11,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.visibility_rounded, color: scheme.primary),
          tooltip: 'Ver seleccionados',
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
            if (mounted) setState(() {});
          },
        ),
        IconButton(
          icon: Icon(Icons.check_rounded, color: scheme.primary),
          tooltip: 'Finalizar selección',
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
              if (result == 'home' && mounted) {
                Navigator.pop(context, 'home');
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
      ],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: SearchField(
              controller: busquedaController,
              onChanged: (value) => busqueda(value),
              hint: 'Buscar exámenes...',
              label: 'Búsqueda de Exámenes',
            ),
          ),
          Expanded(
            child: procedimientoss.isEmpty
                ? EmptyState(
                    icon: Icons.search_off_rounded,
                    title: 'Sin resultados',
                    subtitle: 'No hay exámenes que coincidan con la búsqueda.',
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: procedimientoss.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      int indexx = index;
                      final String nombreExamen =
                          procedimientoss[indexx].nombre!;
                      final String codigoExamen =
                          procedimientoss[indexx].codigo!;
                      final bool seleccionado = siselect(nombreExamen);
                      return Card(
                        color: seleccionado
                            ? scheme.primaryContainer.withValues(alpha: 0.4)
                            : null,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 18,
                            backgroundColor: seleccionado
                                ? scheme.primary
                                : scheme.surfaceContainerHighest,
                            child: Icon(
                              seleccionado
                                  ? Icons.check_rounded
                                  : Icons.biotech_rounded,
                              size: 20,
                              color: seleccionado
                                  ? scheme.onPrimary
                                  : scheme.onSurfaceVariant,
                            ),
                          ),
                          title: Text(
                            nombreExamen,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          subtitle: Text(
                            'Código: $codigoExamen',
                            style: TextStyle(
                              fontSize: 11,
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () => _abrirEditar(indexx),
                                tooltip: 'Editar examen',
                                icon: editando && indexx == seleccionadox
                                    ? const SizedBox(
                                        width: 15,
                                        height: 15,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Icon(
                                        Icons.settings_rounded,
                                        size: 20,
                                        color: scheme.onSurfaceVariant,
                                      ),
                              ),
                              IconButton.filled(
                                onPressed: () => _toggleSeleccion(indexx),
                                tooltip: seleccionado
                                    ? 'Quitar'
                                    : 'Seleccionar',
                                style: IconButton.styleFrom(
                                  backgroundColor: seleccionado
                                      ? scheme.primary
                                      : scheme.surfaceContainerHighest,
                                  foregroundColor: seleccionado
                                      ? scheme.onPrimary
                                      : scheme.onSurfaceVariant,
                                ),
                                icon: Icon(
                                  seleccionado
                                      ? Icons.check_rounded
                                      : Icons.add_rounded,
                                  size: 20,
                                ),
                              ),
                            ],
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