// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movavid/api/api_laboratorio.dart';
import 'package:movavid/functions/show_toast.dart';
import 'package:movavid/models/paciente.dart';
import 'package:movavid/pages/consulta_examenes.dart';
import 'package:movavid/widgets/app_page.dart';
import 'package:movavid/widgets/empty_state.dart';
import 'package:movavid/widgets/hover_card.dart';
import 'package:movavid/widgets/search_field.dart';
import 'package:movavid/theme/app_theme.dart';

class ListaPacientes extends StatefulWidget {
  const ListaPacientes({super.key});

  @override
  State<ListaPacientes> createState() => _ListaPacientesState();
}

class _ListaPacientesState extends State<ListaPacientes> {
  List<Paciente> pacientes = [];
  FToast fToast = FToast();
  bool cargado = false;
  final TextEditingController _controller = TextEditingController(text: '');
  bool buscando = false;
  bool _error = false;
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fToast.init(context);
    setState(() => buscando = true);
    getPacientes(context, criterio: _controller.text).then((value) {
      if (value != null) {
        pacientes = value;
        if (pacientes.isEmpty) {
          _error = true;
          showToastB(
            fToast,
            'No se ha podido obtener la información, Compruebe su conexión',
            bacgroundColor: Colors.red,
            frontColor: Colors.yellow,
            icon: const Icon(
              Icons.dangerous_outlined,
              color: Colors.lightGreenAccent,
            ),
          );
        } else {
          _error = false;
        }
      } else {
        _error = true;
        showToastB(
          fToast,
          'Error en el sevidor',
          bacgroundColor: Colors.red,
          frontColor: Colors.yellow,
          icon: const Icon(
            Icons.dangerous_outlined,
            color: Colors.lightGreenAccent,
          ),
        );
      }
      if (mounted) setState(() => buscando = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Pacientes',
      titleWidget: Row(
        children: [
          const Text('Pacientes'),
          const SizedBox(width: 10),
          if (buscando)
            const SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: SearchField(
              controller: _controller,
              autofocus: true,
              onChanged: buscarChanged,
            ),
          ),
          Expanded(
            child: buscando
                ? const Center(child: CircularProgressIndicator())
                : pacientes.isEmpty && _error
                    ? const EmptyState(
                        icon: Icons.cloud_off_rounded,
                        title: 'No se pudieron cargar los pacientes',
                        subtitle:
                            'Compruebe su conexión a internet e intente de nuevo.',
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          pacientes = await getPacientes(context) ?? [];
                          if (mounted) setState(() {});
                        },
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final bool wide = constraints.maxWidth >= 760;
                            if (wide) {
                              return GridView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(16),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 158,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                ),
                                itemCount: pacientes.length,
                                itemBuilder: (context, index) =>
                                    _PacienteCard(
                                  paciente: pacientes[index],
                                  onVer: () => _verExamenes(pacientes[index]),
                                ),
                              );
                            }
                            return ListView.separated(
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(16),
                              itemCount: pacientes.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 10),
                              itemBuilder: (context, index) =>
                                  _PacienteCard(
                                paciente: pacientes[index],
                                onVer: () => _verExamenes(pacientes[index]),
                              ),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  void _verExamenes(Paciente paciente) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConsultaExamenes(
          paciente: paciente,
          fecha: '',
        ),
      ),
    );
  }

  void buscarChanged(String value) {
    _debounce?.cancel();
    if (value.length < 6) {
      if (value.isEmpty) {
        _debounce = Timer(const Duration(milliseconds: 300), () async {
          setState(() => cargado = !cargado);
          pacientes = await getPacientes(context) ?? [];
          if (mounted) {
            setState(() => cargado = !cargado);
          }
        });
      }
      if (mounted) setState(() {});
    } else {
      _debounce = Timer(const Duration(milliseconds: 300), () async {
        setState(() => buscando = true);
        pacientes = await getPacientes(context, criterio: value) ?? [];
        if (mounted) setState(() => buscando = false);
      });
    }
  }
}

class _PacienteCard extends StatelessWidget {
  final Paciente paciente;
  final VoidCallback onVer;

  const _PacienteCard({required this.paciente, required this.onVer});

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final String? identificacion = paciente.identificacion;
    final String? fecnac = paciente.fecnac;
    final String? sexo = paciente.genero;
    final String? telefono = paciente.telefono;
    final String? correo = paciente.correo;

    return HoverCard(
      onTap: onVer,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              gradient: Theme.of(context).gradients.brand,
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage(
                sexo == 'Masculino' ? 'images/male.png' : 'images/female.png',
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  paciente.nombreCompleto,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14.5,
                    color: scheme.onSurface,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'CC: $identificacion',
                  style: TextStyle(
                    fontSize: 12,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  'Nacimiento: $fecnac',
                  style: TextStyle(
                    fontSize: 12,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 5),
                Wrap(
                  spacing: 12,
                  runSpacing: 2,
                  children: [
                    _meta(scheme, Icons.cake_rounded, paciente.edadY),
                    _meta(scheme, Icons.wc_rounded, sexo ?? ''),
                    if (telefono != null && telefono.isNotEmpty)
                      _meta(scheme, Icons.phone_rounded, telefono),
                  ],
                ),
                if (correo != null && correo.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      correo,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        color: scheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filledTonal(
            onPressed: onVer,
            tooltip: 'Ver exámenes',
            icon: Icon(
              Icons.medical_information_rounded,
              color: scheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _meta(ColorScheme scheme, IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: scheme.onSurfaceVariant),
        const SizedBox(width: 3),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: scheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}