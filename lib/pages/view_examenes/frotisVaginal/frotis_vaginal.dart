import 'package:flutter/material.dart';
import 'package:movavid/api/api_laboratorio.dart';
import 'package:movavid/models/frotis_vaginal_model.dart';
import 'package:movavid/models/paciente.dart';
import 'package:movavid/widgets/modals/floating_modal.dart';
import 'package:movavid/widgets/modals/modal_fit.dart';

class ViewFrotisVaginal extends StatefulWidget {
  final FrotisVaginal frotisVaginal;
  final Paciente paciente;
  final String fecha;
  final String codexamen;

  const ViewFrotisVaginal(
      {super.key,
      required this.paciente,
      required this.frotisVaginal,
      required this.fecha,
      required this.codexamen});

  @override
  State<ViewFrotisVaginal> createState() => _ViewFrotisVaginalState();
}

class _ViewFrotisVaginalState extends State<ViewFrotisVaginal> {
  FrotisVaginal frotisVaginalS = FrotisVaginal();
  bool guardando_ = false;
  late final TextEditingController _otrosFrescoController;
  late final TextEditingController _pruebaDeAminasController;
  late final TextEditingController _celulasGuia1Controller;
  late final TextEditingController _phController;
  late final TextEditingController _trichonomasVaginalesController;
  late final TextEditingController _pmnController;
  late final TextEditingController _celulasGuia2Controller;
  late final TextEditingController _blastoconidiasController;
  late final TextEditingController _seudomiceliosController;
  late final TextEditingController _lactobacillusController;
  late final TextEditingController _gardnerellaSpController;
  late final TextEditingController _bacteroidesSpController;
  late final TextEditingController _mobilluncusSpController;
  late final TextEditingController _pmnxController;
  late final TextEditingController _intracelularesController;
  late final TextEditingController _extracelularesController;
  late final TextEditingController _observacionesController;

  @override
  void initState() {
    super.initState();

    _otrosFrescoController =
        TextEditingController(text: widget.frotisVaginal.otrosFresco);
    _pruebaDeAminasController =
        TextEditingController(text: widget.frotisVaginal.pruebaDeAminas);
    _celulasGuia1Controller =
        TextEditingController(text: widget.frotisVaginal.celulasGuia1);
    _phController = TextEditingController(text: widget.frotisVaginal.ph);
    _trichonomasVaginalesController =
        TextEditingController(text: widget.frotisVaginal.trichonomasVaginales);
    _pmnController = TextEditingController(text: widget.frotisVaginal.pmn);
    _celulasGuia2Controller =
        TextEditingController(text: widget.frotisVaginal.celulasGuia2);
    _blastoconidiasController =
        TextEditingController(text: widget.frotisVaginal.blastoconidias);
    _seudomiceliosController =
        TextEditingController(text: widget.frotisVaginal.seudomicelios);
    _lactobacillusController =
        TextEditingController(text: widget.frotisVaginal.lactobacillus);
    _gardnerellaSpController =
        TextEditingController(text: widget.frotisVaginal.gardnerellaSp);
    _bacteroidesSpController =
        TextEditingController(text: widget.frotisVaginal.bacteroidesSp);
    _mobilluncusSpController =
        TextEditingController(text: widget.frotisVaginal.mobilluncusSp);
    _pmnxController = TextEditingController(text: widget.frotisVaginal.pmnx);
    _intracelularesController =
        TextEditingController(text: widget.frotisVaginal.intracelulares);
    _extracelularesController =
        TextEditingController(text: widget.frotisVaginal.extracelulares);
    _observacionesController =
        TextEditingController(text: widget.frotisVaginal.observaciones);
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Colors.black,
        title: const Text(
          'Registro de Exámenes',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: !guardando_
                ? IconButton(
                    onPressed: () async {
                      setState(() => guardando_ = !guardando_);
                      guardarFrotisVaginal(
                              context, frotisVaginalS, widget.codexamen)
                          .then(
                        (value) {
                          if (true) {
                            printPDFFile(
                              context,
                              "frotisVaginal",
                              "Frotis Vaginal",
                              "frotis_${widget.paciente.identificacion}_${widget.fecha}.pdf",
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
                    icon: const Icon(
                      Icons.print,
                      color: Colors.white,
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: SizedBox(
                      width: 13,
                      height: 13,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: !guardando_
                ? IconButton(
                    onPressed: () async {
                      setState(() => guardando_ = !guardando_);
                      guardarFrotisVaginal(
                              context, frotisVaginalS, widget.codexamen)
                          .then(
                        (value) {
                          showFloatingModalBottomSheet(
                            context: context,
                            builder: (context) => const ModalFit(
                              title: 'Exámen Frotis Vaginal almacenado',
                              asset: 'images/lab.png',
                            ),
                          );
                          setState(() => guardando_ = !guardando_);
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: SizedBox(
                      width: 13,
                      height: 13,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
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
                    backgroundImage: AssetImage('images/frotis.png'),
                  ),
                  const SizedBox(width: 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Frotis Vaginal',
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
                                  fontSize: 12,
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
                  frotisVaginalS.identificacion =
                      widget.paciente.identificacion;
                  frotisVaginalS.fecha = widget.fecha;
                  frotisVaginalS.otrosFresco = _otrosFrescoController.text;
                  frotisVaginalS.pruebaDeAminas =
                      _pruebaDeAminasController.text;
                  frotisVaginalS.celulasGuia1 = _celulasGuia1Controller.text;
                  frotisVaginalS.ph = _phController.text;
                  frotisVaginalS.trichonomasVaginales =
                      _trichonomasVaginalesController.text;
                  frotisVaginalS.pmn = _pmnController.text;
                  frotisVaginalS.celulasGuia2 = _celulasGuia2Controller.text;
                  frotisVaginalS.blastoconidias =
                      _blastoconidiasController.text;
                  frotisVaginalS.seudomicelios = _seudomiceliosController.text;
                  frotisVaginalS.lactobacillus = _lactobacillusController.text;
                  frotisVaginalS.gardnerellaSp = _gardnerellaSpController.text;
                  frotisVaginalS.bacteroidesSp = _bacteroidesSpController.text;
                  frotisVaginalS.mobilluncusSp = _mobilluncusSpController.text;
                  frotisVaginalS.pmnx = _pmnxController.text;
                  frotisVaginalS.intracelulares =
                      _intracelularesController.text;
                  frotisVaginalS.extracelulares =
                      _extracelularesController.text;
                  frotisVaginalS.observaciones = _observacionesController.text;
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      _buildTextField('Otros Fresco ', _otrosFrescoController),
                      _buildTextField(
                          'Prueba De Aminas ', _pruebaDeAminasController),
                      _buildTextField(
                          'Celulas Guia 1 ', _celulasGuia1Controller),
                      _buildTextField('Ph ', _phController),
                      _buildTextField('Trichonomas Vaginales ',
                          _trichonomasVaginalesController),
                      _buildTextField('Pmn ', _pmnController),
                      _buildTextField(
                          'Celulas Guia 2 ', _celulasGuia2Controller),
                      _buildTextField(
                          'Blastoconidias ', _blastoconidiasController),
                      _buildTextField(
                          'Seudomicelios ', _seudomiceliosController),
                      _buildTextField(
                          'Lactobacillus ', _lactobacillusController),
                      _buildTextField(
                          'GardnerellaSp ', _gardnerellaSpController),
                      _buildTextField(
                          'BacteroidesSp ', _bacteroidesSpController),
                      _buildTextField(
                          'MobilluncusSp ', _mobilluncusSpController),
                      _buildTextField('Pmnx ', _pmnxController),
                      _buildTextField(
                          'Intracelulares ', _intracelularesController),
                      _buildTextField(
                          'Extracelulares ', _extracelularesController),
                      _buildTextField(
                          'Observaciones ', _observacionesController),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
