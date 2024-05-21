import 'package:flutter/material.dart';
import 'package:movavid/api/api_laboratorio.dart';
import 'package:movavid/models/paciente.dart';
import 'package:movavid/models/perfil_lipidico_model.dart';
import 'package:movavid/widgets/appbar/appbare.dart';
import 'package:movavid/widgets/modals/floating_modal.dart';
import 'package:movavid/widgets/modals/modal_fit.dart';

class ViewPerfilLipidico extends StatefulWidget {
  final PerfilLipidico perfilLipidico;
  final Paciente paciente;
  final String fecha;
  final String codexamen;
  const ViewPerfilLipidico(
      {super.key,
      required this.perfilLipidico,
      required this.paciente,
      required this.fecha,
      required this.codexamen});

  @override
  State<ViewPerfilLipidico> createState() => _ViewPerfilLipidicoState();
}

class _ViewPerfilLipidicoState extends State<ViewPerfilLipidico> {
  bool guardando_ = false;
  PerfilLipidico perfilLipidicoS = PerfilLipidico();
  late final TextEditingController colesterolTotalController;
  late final TextEditingController colesterolHdlController;
  late final TextEditingController colesterolVldlController;
  late final TextEditingController colesterolLdlController;
  late final TextEditingController trigliceridosController;
  late final TextEditingController indiceArterialController;
  late final TextEditingController bacteriologoController;
  late final TextEditingController observacionesController;
  @override
  void initState() {
    super.initState();
    colesterolTotalController =
        TextEditingController(text: widget.perfilLipidico.colesterolTotal);
    colesterolHdlController =
        TextEditingController(text: widget.perfilLipidico.colesterolHdl);
    colesterolVldlController =
        TextEditingController(text: widget.perfilLipidico.colesterolVldl);
    colesterolLdlController =
        TextEditingController(text: widget.perfilLipidico.colesterolLdl);
    trigliceridosController =
        TextEditingController(text: widget.perfilLipidico.trigliceridos);
    indiceArterialController =
        TextEditingController(text: widget.perfilLipidico.indiceArterial);
    observacionesController =
        TextEditingController(text: widget.perfilLipidico.observaciones);
  }

  Widget _buildTextField(String labelText, TextEditingController controller) {
    String value = controller.text;
    value = value != 'null' ? value : '';
    controller.text = value;
    return TextFormField(
      maxLines: value.length > 30 && value.length < 95 ? 2 : 1,
      validator: (value) {
        if (value == '') return 'Falta el valor de este campo';
        return null;
      },
      onChanged: (value) {
        setState(() {});
      },
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.blueGrey,
        ),
      ),
      style: const TextStyle(color: Colors.blue),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarExam(
          context,
          widget.paciente,
          widget.fecha,
          () {
            setState(() => guardando_ = !guardando_);
            guardarPerfilLipidico(context, perfilLipidicoS, widget.codexamen)
                .then(
              (value) {
                if (true) {
                  printPDFFile(
                    context,
                    "perfilLipidico",
                    "Perfil Lipídico",
                    "perfil_${widget.paciente.identificacion}_${widget.fecha}.pdf",
                    widget.paciente.identificacion!,
                    widget.fecha,
                    widget.paciente.nombreCompleto,
                    widget.paciente.edad,
                  );
                }
                setState(() => guardando_ = !guardando_);
              },
            );
          },
          () {
            setState(() => guardando_ = !guardando_);
            guardarPerfilLipidico(context, perfilLipidicoS, widget.codexamen)
                .then(
              (value) {
                showFloatingModalBottomSheet(
                  context: context,
                  builder: (context) => const ModalFit(
                    title: 'Perfil Lipídico almacenado',
                    asset: 'images/hdl.png',
                  ),
                );
                setState(() => guardando_ = !guardando_);
              },
            );
          },
          guardando_,
          const Color.fromARGB(255, 255, 147, 219),
          Colors.black,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('images/hdl.png'),
                  ),
                  const SizedBox(width: 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Perfil Lipídico',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                widget.paciente.nombreCompleto,
                                style: const TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                widget.fecha,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.brown,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Form(
                onChanged: () {
                  perfilLipidicoS.colesterolTotal =
                      colesterolTotalController.text;
                  perfilLipidicoS.colesterolHdl = colesterolHdlController.text;
                  perfilLipidicoS.colesterolVldl =
                      colesterolVldlController.text;
                  perfilLipidicoS.colesterolLdl = colesterolLdlController.text;
                  perfilLipidicoS.trigliceridos = trigliceridosController.text;
                  perfilLipidicoS.indiceArterial =
                      indiceArterialController.text;
                  perfilLipidicoS.observaciones = observacionesController.text;
                  perfilLipidicoS.identificacion =
                      widget.paciente.identificacion;
                  perfilLipidicoS.fecha = widget.fecha;
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      _buildTextField(
                          'Colesterol Total', colesterolTotalController),
                      _buildTextField(
                          'Colesterol Hdl', colesterolHdlController),
                      _buildTextField(
                          'Colesterol Vldl', colesterolVldlController),
                      _buildTextField(
                          'Colesterol Ldl', colesterolLdlController),
                      _buildTextField('Trigliceridos', trigliceridosController),
                      _buildTextField(
                          'Indice Arterial', indiceArterialController),
                      _buildTextField('Observaciones', observacionesController),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
