// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:movavid/api/api_laboratorio.dart';
import 'package:movavid/functions/show_toast.dart';
import 'package:movavid/models/paciente.dart';
import 'package:movavid/pages/consulta_examenes.dart';

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
  @override
  void initState() {
    super.initState();
    fToast.init(context);
    //  pacientes = await getPacientes(context) as List<Paciente>;
    setState(() => buscando = !buscando);
    getPacientes(context, criterio: _controller.text).then((value) {
      if (value != null) {
        pacientes = value;
        setState(() => buscando = !buscando);
        if (pacientes.isEmpty) {
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
        }
      } else {
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
      setState(() {});
    });
  }

  int calcularEdad(String fecnac) {
    DateTime fechaNacimiento = DateFormat("yyyy-MM-dd").parse(fecnac);
    DateTime ahora = DateTime.now();
    int diferenciaAnios = ahora.year - fechaNacimiento.year;
    int diferenciaMeses = ahora.month - fechaNacimiento.month;
    int diferenciaDias = ahora.day - fechaNacimiento.day;

    if (diferenciaMeses < 0 || (diferenciaMeses == 0 && diferenciaDias < 0)) {
      diferenciaAnios--;
    }

    return diferenciaAnios;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Lista de Pacientes'),
            !buscando
                ? const Icon(Icons.star_border)
                : const SizedBox(
                    width: 15,
                    height: 15,
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                  ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: pacientes.length + 1,
        itemBuilder: (context, index) {
          late final Paciente paciente;
          late final String? identificacion;
          late final String? fecnac;
          late final String? sexo;
          late final String? telefono;
          late final String? correo;
          int iindex = index - 1;
          if (index > 0) {
            paciente = pacientes[iindex];
            identificacion = pacientes[iindex].identificacion;
            //          pacientes[iindex].nombreCompleto.replaceAll('\ufffd', 'Ñ');

            fecnac = pacientes[iindex].fecnac;
            sexo = pacientes[iindex].genero;
            telefono = pacientes[iindex].telefono;
            correo = pacientes[iindex].correo;
          }
          return index == 0
              ? SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18),
                    child: TextField(
                      controller: _controller,
                      autofocus: true,
                      onChanged: buscarChanged,
                      decoration: InputDecoration(
                        labelText: 'Buscar...',
                        suffixIcon: IconButton(
                          onPressed: () {
                            _controller.clear();
                            buscarChanged('');
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: sexo == 'Masculino'
                            ? const AssetImage('images/male.png')
                            : const AssetImage('images/female.png'),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConsultaExamenes(
                                    paciente: paciente, fecha: ''),
                              ));
                        },
                        icon: const Icon(Icons.medical_information,
                            color: Colors.blueAccent),
                      ),
                      title: Text(
                        paciente.nombreCompleto,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Identificación: $identificacion"),
                          Text("Fecha de Nacimiento: $fecnac"),
                          Row(
                            children: [
                              Text(
                                "Edad: ${paciente.edadY}.",
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                "Sexo: $sexo",
                              ),
                            ],
                          ),
                          Text(
                            "Telefono: $telefono",
                            style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            correo != null ? "Correo: $correo" : "",
                            style: const TextStyle(color: Colors.deepPurple),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }

  void buscarChanged(value) async {
    if (value.length < 6) {
      if (value.isEmpty) {
        setState(() => cargado = !cargado);
        pacientes = await getPacientes(context) as List<Paciente>;
        if (mounted) {
          setState(() => cargado = !cargado);
        }
      }
      setState(() {});
    } else {
      setState(() => cargado = !cargado);
      //  setState(() => pacientes = []);
      pacientes =
          await getPacientes(context, criterio: value) as List<Paciente>;
      print(pacientes);
      setState(() => cargado = !cargado);
    }
  }
}
