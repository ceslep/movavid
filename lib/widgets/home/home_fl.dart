// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:movavid/api/api_laboratorio.dart';
import 'package:movavid/pages/creacion_de_examenes/crear_examen.dart';
import 'package:movavid/pages/pacientes.dart';

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
      children: [
        FloatingActionButton(
          heroTag: 0,
          backgroundColor: Colors.amber,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CrearExamen(),
                ));
          },
          tooltip: 'Agregar Examen',
          child: const Icon(
            Icons.health_and_safety,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        FloatingActionButton(
          heroTag: 1,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Pacientes(),
                ));
          },
          tooltip: 'Agregar Paciente',
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}

class BodyHome extends StatelessWidget {
  const BodyHome({
    super.key,
    required TextEditingController fechaController,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 0.7 * MediaQuery.of(context).size.height,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: imagenet(context, "logo.png"),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
