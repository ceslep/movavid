import 'package:flutter/material.dart';
import 'package:movavid/pages/creacion_de_examenes/crear_examen.dart';
import 'package:movavid/pages/pacientes.dart';
import 'package:movavid/theme/app_theme.dart';
import 'package:movavid/widgets/hover_card.dart';

class FloatingActionButtonHome extends StatelessWidget {
  final String fecha;
  const FloatingActionButtonHome({
    super.key,
    required this.fecha,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FloatingActionButton.extended(
          heroTag: 0,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CrearExamen()),
            );
          },
          icon: const Icon(Icons.health_and_safety_rounded),
          label: const Text('Nuevo examen'),
        ),
        const SizedBox(height: 10),
        FloatingActionButton.extended(
          heroTag: 1,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Pacientes()),
            );
          },
          icon: const Icon(Icons.person_add_alt_1_rounded),
          label: const Text('Nuevo paciente'),
        ),
      ],
    );
  }
}

class BodyHome extends StatelessWidget {
  final String fecha;
  final bool listando;
  final VoidCallback onNuevoExamen;
  final VoidCallback onNuevoPaciente;
  final VoidCallback onVerHoy;
  final VoidCallback onResultados;

  const BodyHome({
    super.key,
    required this.fecha,
    required this.listando,
    required this.onNuevoExamen,
    required this.onNuevoPaciente,
    required this.onVerHoy,
    required this.onResultados,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HeroCard(
                fecha: fecha,
                listando: listando,
                onVerHoy: onVerHoy,
              ),
              const SizedBox(height: 20),
              _QuickActions(
                onNuevoExamen: onNuevoExamen,
                onNuevoPaciente: onNuevoPaciente,
                onResultados: onResultados,
              ),
              const SizedBox(height: 28),
              const _SectionTitle(
                title: 'Accesos rápidos',
                subtitle: 'Tipos de exámenes disponibles en el laboratorio',
              ),
              const SizedBox(height: 14),
              const _ShortcutsGrid(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  final String fecha;
  final bool listando;
  final VoidCallback onVerHoy;

  const _HeroCard({
    required this.fecha,
    required this.listando,
    required this.onVerHoy,
  });

  String _fechaLarga() {
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
    final DateTime now = DateTime.now();
    return '${dias[now.weekday - 1]}, ${now.day} de ${meses[now.month - 1]} de ${now.year}';
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool wide = constraints.maxWidth >= 640;
        final Widget info = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.calendar_month_rounded,
                      size: 14, color: Colors.white.withValues(alpha: 0.95)),
                  const SizedBox(width: 6),
                  Text(
                    _fechaLarga(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Bienvenido(a)',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Sistema de Manejo de Laboratorio Clínico',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.88),
                fontSize: 13.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );

        final Widget action = FilledButton.icon(
          onPressed: listando ? null : onVerHoy,
          style: FilledButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: scheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          ),
          icon: listando
              ? SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.2,
                    color: scheme.primary,
                  ),
                )
              : const Icon(Icons.event_available_rounded, size: 19),
          label: const Text('Exámenes del día'),
        );

        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: Theme.of(context).gradients.brand,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: scheme.primary.withValues(alpha: 0.3),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: wide
              ? Row(
                  children: [
                    Expanded(child: info),
                    const SizedBox(width: 16),
                    action,
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    info,
                    const SizedBox(height: 18),
                    action,
                  ],
                ),
        );
      },
    );
  }
}

class _QuickActions extends StatelessWidget {
  final VoidCallback onNuevoExamen;
  final VoidCallback onNuevoPaciente;
  final VoidCallback onResultados;

  const _QuickActions({
    required this.onNuevoExamen,
    required this.onNuevoPaciente,
    required this.onResultados,
  });

  @override
  Widget build(BuildContext context) {
    final Widget cardExamen = _QuickActionCard(
      icon: Icons.health_and_safety_rounded,
      title: 'Nuevo examen',
      subtitle: 'Registrar o crear un examen',
      onTap: onNuevoExamen,
    );
    final Widget cardPaciente = _QuickActionCard(
      icon: Icons.person_add_alt_1_rounded,
      title: 'Nuevo paciente',
      subtitle: 'Registrar datos de un paciente',
      onTap: onNuevoPaciente,
    );
    final Widget cardResultados = _QuickActionCard(
      icon: Icons.calendar_month_rounded,
      title: 'Días con resultados',
      subtitle: 'Ver fechas con exámenes registrados',
      onTap: onResultados,
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool wide = constraints.maxWidth >= 640;
        return wide
            ? Row(
                children: [
                  cardExamen,
                  const SizedBox(width: 14),
                  cardPaciente,
                  const SizedBox(width: 14),
                  cardResultados,
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  cardExamen,
                  const SizedBox(height: 14),
                  cardPaciente,
                  const SizedBox(height: 14),
                  cardResultados,
                ],
              );
      },
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Expanded(
      child: HoverCard(
        onTap: onTap,
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                gradient: Theme.of(context).gradients.brandSoft,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: scheme.primary, size: 26),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w800,
                      color: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: scheme.onSurfaceVariant,
                    ),
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
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionTitle({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: scheme.onSurface,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          style: TextStyle(fontSize: 12.5, color: scheme.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _ShortcutsGrid extends StatelessWidget {
  const _ShortcutsGrid();

  static const List<({String asset, String label})> _atajos = [
    (asset: 'images/hemat.png', label: 'Hemograma'),
    (asset: 'images/hdl.png', label: 'Perfil lipídico'),
    (asset: 'images/porina.png', label: 'Parcial de orina'),
    (asset: 'images/coprologico.png', label: 'Coprológico'),
    (asset: 'images/frotis.png', label: 'Frotis vaginal'),
    (asset: 'images/lab.png', label: 'Otros exámenes'),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final int columnas = constraints.maxWidth >= 900
            ? 3
            : constraints.maxWidth >= 560
                ? 2
                : 1;
        final double ancho =
            (constraints.maxWidth - (columnas - 1) * 12) / columnas;
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final atajo in _atajos)
              SizedBox(
                width: ancho,
                child: _ShortcutTile(asset: atajo.asset, label: atajo.label),
              ),
          ],
        );
      },
    );
  }
}

class _ShortcutTile extends StatelessWidget {
  final String asset;
  final String label;

  const _ShortcutTile({required this.asset, required this.label});

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return HoverCard(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CrearExamen()),
        );
      },
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              gradient: Theme.of(context).gradients.brandFaint,
              borderRadius: BorderRadius.circular(13),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                asset,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.biotech_rounded,
                  size: 22,
                  color: scheme.primary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                color: scheme.onSurface,
              ),
            ),
          ),
          Icon(
            Icons.add_circle_outline_rounded,
            size: 20,
            color: scheme.primary.withValues(alpha: 0.7),
          ),
        ],
      ),
    );
  }
}