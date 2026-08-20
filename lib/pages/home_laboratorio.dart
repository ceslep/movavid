import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:movavid/api/api_laboratorio.dart';
import 'package:movavid/models/paciente.dart';
import 'package:movavid/pages/configuracion/configuracion.dart';
import 'package:movavid/pages/creacion_de_examenes/crear_examen.dart';
import 'package:movavid/pages/lista_pacientes.dart';
import 'package:movavid/pages/pacientes.dart';
import 'package:movavid/pages/view_examenes/porfecha/dias_con_resultados.dart';
import 'package:movavid/pages/view_examenes/porfecha/ver_por_fecha.dart';
import 'package:movavid/theme/app_theme.dart';
import 'package:movavid/widgets/home/home_fl.dart';

class Homemovavid extends StatefulWidget {
  const Homemovavid({super.key, required this.title});

  final String title;

  @override
  State<Homemovavid> createState() => _HomemovavidState();
}

class _HomemovavidState extends State<Homemovavid> {
  bool listando = false;

  final TextEditingController _fechaController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));

  Future<void> _verExamenesFecha() async {
    if (listando) return;
    setState(() => listando = true);
    try {
      List<Paciente> pacientes =
          await getPacientesFecha(context, _fechaController.text);
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerPorFecha(pacientes: pacientes),
        ),
      );
    } finally {
      if (mounted) setState(() => listando = false);
    }
  }

  void _ir(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  Future<void> _salir() async {
    final bool? confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          Icons.logout_rounded,
          size: 32,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: const Text('Salir del sistema'),
        content: const Text('¿Desea cerrar la aplicación?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Salir'),
          ),
        ],
      ),
    );
    if (confirmar == true) exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool wide = constraints.maxWidth >= 900;
        final Widget dashboard = BodyHome(
          fecha: _fechaController.text,
          listando: listando,
          onNuevoExamen: () => _ir(const CrearExamen()),
          onNuevoPaciente: () => _ir(const Pacientes()),
          onVerHoy: _verExamenesFecha,
          onResultados: () => _ir(const DiasConResultados()),
        );

        return Focus(
          autofocus: true,
          child: CallbackShortcuts(
            bindings: {
              const SingleActivator(LogicalKeyboardKey.keyN, control: true):
                  () => _ir(const CrearExamen()),
              const SingleActivator(
                LogicalKeyboardKey.keyR,
                control: true,
                shift: true,
              ): () => _ir(const DiasConResultados()),
            },
            child: Scaffold(
          body: SafeArea(
            child: wide
                ? Row(
                    children: [
                      _NavRail(
                        onInicio: () => setState(() {}),
                        onPacientes: () => _ir(const ListaPacientes()),
                        onConfig: () => _ir(const Configuracion()),
                        onResultados: () => _ir(const DiasConResultados()),
                        onExit: _salir,
                      ),
                      const VerticalDivider(width: 1, thickness: 1),
                      Expanded(child: dashboard),
                    ],
                  )
                : Column(
                    children: [
                      _HomeHeader(
                        listando: listando,
                        onDate: _verExamenesFecha,
                        onPacientes: () => _ir(const ListaPacientes()),
                        onConfig: () => _ir(const Configuracion()),
                        onExit: _salir,
                      ),
                      Expanded(child: dashboard),
                    ],
                  ),
          ),
          bottomNavigationBar: wide
              ? null
              : NavigationBar(
                  selectedIndex: 0,
                  onDestinationSelected: (index) {
                    if (index == 1) _ir(const ListaPacientes());
                    if (index == 2) _ir(const Configuracion());
                    if (index == 3) _ir(const DiasConResultados());
                  },
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home_rounded),
                      label: 'Inicio',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.people_alt_outlined),
                      selectedIcon: Icon(Icons.people_alt_rounded),
                      label: 'Pacientes',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.settings_outlined),
                      selectedIcon: Icon(Icons.settings_rounded),
                      label: 'Configuración',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.calendar_month_outlined),
                      selectedIcon: Icon(Icons.calendar_month_rounded),
                      label: 'Resultados',
                    ),
                  ],
                ),
          floatingActionButton: wide
              ? null
              : FloatingActionButtonHome(fecha: _fechaController.text),
        ),
          ),
        );
      },
    );
  }
}

class _NavRail extends StatelessWidget {
  final VoidCallback onInicio;
  final VoidCallback onPacientes;
  final VoidCallback onConfig;
  final VoidCallback onResultados;
  final VoidCallback onExit;

  const _NavRail({
    required this.onInicio,
    required this.onPacientes,
    required this.onConfig,
    required this.onResultados,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return NavigationRail(
      extended: true,
      minExtendedWidth: 216,
      selectedIndex: 0,
      onDestinationSelected: (index) {
        if (index == 1) onPacientes();
        if (index == 2) onConfig();
        if (index == 3) onResultados();
        onInicio();
      },
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 8),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: Theme.of(context).gradients.brandSoft,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  'images/logo.png',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.biotech_rounded,
                    size: 22,
                    color: scheme.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Laboratorio',
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    color: scheme.onSurface,
                    letterSpacing: -0.2,
                  ),
                ),
                Text(
                  'Clínico',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      trailing: Expanded(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: IconButton(
              onPressed: onExit,
              tooltip: 'Salir',
              icon: const Icon(Icons.logout_rounded),
            ),
          ),
        ),
      ),
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home_rounded),
          label: Text('Inicio'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.people_alt_outlined),
          selectedIcon: Icon(Icons.people_alt_rounded),
          label: Text('Pacientes'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings_rounded),
          label: Text('Configuración'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.calendar_month_outlined),
          selectedIcon: Icon(Icons.calendar_month_rounded),
          label: Text('Resultados'),
        ),
      ],
    );
  }
}

class _HomeHeader extends StatelessWidget {
  final bool listando;
  final VoidCallback onDate;
  final VoidCallback onPacientes;
  final VoidCallback onConfig;
  final VoidCallback onExit;

  const _HomeHeader({
    required this.listando,
    required this.onDate,
    required this.onPacientes,
    required this.onConfig,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 14),
      decoration: BoxDecoration(
        gradient: Theme.of(context).gradients.brand,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(28),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.asset(
                'images/logo.png',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.biotech_rounded,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Laboratorio',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
                ),
                Text(
                  'Sistema de Manejo de Laboratorio Clínico',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.88),
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onConfig,
            tooltip: 'Configuración',
            style: IconButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.white.withValues(alpha: 0.12),
            ),
            icon: const Icon(Icons.settings_rounded),
          ),
          IconButton(
            onPressed: onPacientes,
            tooltip: 'Lista de pacientes',
            style: IconButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.white.withValues(alpha: 0.12),
            ),
            icon: const Icon(Icons.people_alt_rounded),
          ),
          IconButton(
            onPressed: onDate,
            tooltip: 'Exámenes de hoy',
            style: IconButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.white.withValues(alpha: 0.12),
            ),
            icon: listando
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.calendar_month_rounded),
          ),
          IconButton(
            onPressed: onExit,
            tooltip: 'Salir',
            style: IconButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.white.withValues(alpha: 0.12),
            ),
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
    );
  }
}