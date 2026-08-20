import 'package:flutter/material.dart';
import 'package:movavid/api/api_laboratorio.dart';
import 'package:movavid/models/paciente.dart';
import 'package:movavid/models/procedimientos_model.dart';
import 'package:movavid/widgets/app_page.dart';
import 'package:movavid/widgets/empty_state.dart';
import 'package:movavid/widgets/loading_overlay.dart';
import 'package:movavid/widgets/modals/floating_modal.dart';
import 'package:movavid/widgets/modals/modal_fit.dart';

class MostrarSeleccionados extends StatefulWidget {
  final Paciente paciente;
  final String fecha;
  final List<Procedimientos> seleccionados;
  final bool aguardar;
  const MostrarSeleccionados(
      {super.key,
      required this.seleccionados,
      required this.aguardar,
      required this.paciente,
      required this.fecha});

  @override
  State<MostrarSeleccionados> createState() => _MostrarSeleccionadosState();
}

class _MostrarSeleccionadosState extends State<MostrarSeleccionados> {
  late List<Procedimientos> seleccionadoss;
  bool guardando_ = false;
  @override
  void initState() {
    super.initState();
    seleccionadoss = widget.seleccionados;
  }

  Future<void> _confirmarGuardar() async {
    final bool? ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          Icons.save_rounded,
          size: 30,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: const Text('Guardar exámenes'),
        content: Text(
            '¿Desea guardar los ${seleccionadoss.length} exámenes seleccionados?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
    if (ok == true) _guardar();
  }

  void _guardar() {
    setState(() => guardando_ = true);
    guardarExamenes(context, seleccionadoss, widget.paciente.identificacion!,
            widget.fecha)
        .then(
      (value) {
        if (!mounted) return;
        setState(() => guardando_ = false);
        showFloatingModalBottomSheet(
          context: context,
          builder: (context) => const ModalFit(
            title: 'Exámenes almacenados',
            asset: 'images/logo.png',
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return AppPage(
      title: 'Exámenes Seleccionados',
      actions: [
        if (widget.aguardar) ...[
          IconButton(
            onPressed: guardando_
                ? null
                : () {
                    Navigator.pop(context, 'home');
                  },
            tooltip: 'Inicio',
            icon: const Icon(Icons.home_rounded),
          ),
          IconButton(
            onPressed: guardando_ ? null : _confirmarGuardar,
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
      ],
      body: LoadingOverlay(
        visible: guardando_,
        message: 'Guardando exámenes...',
        child: seleccionadoss.isNotEmpty
          ? Column(
              children: [
                Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundImage:
                          widget.paciente.genero! == 'Masculino'
                              ? const AssetImage('images/male.png')
                              : const AssetImage('images/female.png'),
                    ),
                    title: Text(
                      widget.paciente.nombreCompleto,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(widget.paciente.identificacion!),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        '${seleccionadoss.length} exámenes',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: scheme.primary,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        widget.fecha,
                        style: TextStyle(
                          fontSize: 12,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    itemCount: seleccionadoss.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final int indexx = index;
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 16,
                            backgroundColor:
                                scheme.primaryContainer,
                            child: Icon(
                              Icons.biotech_rounded,
                              size: 18,
                              color: scheme.onPrimaryContainer,
                            ),
                          ),
                          title: Text(
                            seleccionadoss[indexx].nombre!,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          trailing: IconButton(
                            tooltip: 'Quitar',
                            onPressed: () {
                              seleccionadoss.removeAt(indexx);
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.delete_outline_rounded,
                              color: scheme.error,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (widget.aguardar)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: guardando_ ? null : _confirmarGuardar,
                        icon: guardando_
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.save_rounded),
                        label: Text(
                            guardando_ ? 'Guardando...' : 'Guardar Exámenes'),
                      ),
                    ),
                  ),
              ],
            )
          : EmptyState(
              icon: Icons.assignment_rounded,
              title: 'Sin exámenes seleccionados',
              subtitle: 'Seleccione al menos un examen para continuar.',
            ),
      ),
    );
  }
}