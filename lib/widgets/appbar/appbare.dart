import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movavid/models/paciente.dart';
import 'package:movavid/theme/app_theme.dart';
import 'package:movavid/widgets/exam_actions.dart';
import 'package:movavid/widgets/patient_header.dart';

class ExamViewScaffold extends StatelessWidget {
  final String asset;
  final String examen;
  final Paciente paciente;
  final String fecha;
  final bool guardando;
  final VoidCallback onPrint;
  final VoidCallback onSave;
  final Widget body;

  const ExamViewScaffold({
    super.key,
    required this.asset,
    required this.examen,
    required this.paciente,
    required this.fecha,
    required this.guardando,
    required this.onPrint,
    required this.onSave,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Focus(
      autofocus: true,
      child: CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.keyS, control: true):
              guardando ? () {} : () => _guardarConfirmado(context),
          const SingleActivator(LogicalKeyboardKey.keyP, control: true):
              guardando ? () {} : onPrint,
        },
        child: Scaffold(
          appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                gradient: Theme.of(context).gradients.brandSoft,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.biotech_rounded, size: 19, color: scheme.primary),
            ),
            const SizedBox(width: 10),
            const Text('Registro de Exámenes'),
          ],
        ),
        actions: [
          ExamActions(
            busy: guardando,
            onPrint: onPrint,
            onSave: () => _guardarConfirmado(context),
          ),
        ],
      ),
      body: Column(
        children: [
          PatientHeader(
            asset: asset,
            examen: examen,
            paciente: paciente.nombreCompleto,
            fecha: fecha,
            extra: '${paciente.identificacion} • ${paciente.edad}',
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: body,
                ),
              ),
            ),
          ),
        ],
      ),
        ),
      ),
    );
  }

  Future<void> _guardarConfirmado(BuildContext context) async {
    final bool? ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          Icons.save_rounded,
          size: 30,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: const Text('Guardar exámenes'),
        content: const Text('¿Desea guardar los datos del examen?'),
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
    if (ok == true) onSave();
  }
}