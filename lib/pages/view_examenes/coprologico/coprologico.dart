import 'package:flutter/material.dart';
import 'package:movavid/api/api_laboratorio.dart';
import 'package:movavid/models/coprologico.dart';
import 'package:movavid/models/paciente.dart';
import 'package:movavid/widgets/modals/floating_modal.dart';
import 'package:movavid/widgets/modals/modal_fit.dart';

class ViewCoprologico extends StatefulWidget {
  final Coprologico coprologico;
  final Paciente paciente;
  final String fecha;
  final String codexamen;
  const ViewCoprologico(
      {super.key,
      required this.coprologico,
      required this.paciente,
      required this.fecha,
      required this.codexamen});

  @override
  State<ViewCoprologico> createState() => _CoprologicoState();
}

class _CoprologicoState extends State<ViewCoprologico> {
  Coprologico coprologicoS = Coprologico();

  late final TextEditingController _consistenciaController;
  late final TextEditingController _colorController;
  late final TextEditingController _sangreController;
  late final TextEditingController _mocoController;
  late final TextEditingController _otrosMacroscopicosController;
  late final TextEditingController _phController;
  late final TextEditingController _endamoebaHistoliticaQuistesController;
  late final TextEditingController _endamoebaColiQuistesController;
  late final TextEditingController _endolimaxQuistesController;
  late final TextEditingController _iodamoebaQuistesController;
  late final TextEditingController _giardaLambliaQuistesController;
  late final TextEditingController _chilomastixMesniliQuistesController;
  late final TextEditingController _trichomonaHominisQuistesController;
  late final TextEditingController _balantidiumColiQuistesController;
  late final TextEditingController _endamoebaHistoliticaTrofozoitosController;
  late final TextEditingController _endamoebaColiTrofozoitosController;
  late final TextEditingController _endolimaxTrofozoitosController;
  late final TextEditingController _iodamoebaTrofozoitosController;
  late final TextEditingController _giardaLambliaTrofozoitosController;
  late final TextEditingController _chilomastixMesniliTrofozoitosController;
  late final TextEditingController _trichomonaHominisTrofozoitosController;
  late final TextEditingController _balantidiumColiTrofozoitosController;
  late final TextEditingController _blastocystisHominisQuistesController;
  late final TextEditingController _blastocystisHominisTrofozoitosController;
  late final TextEditingController _ascarisController;
  late final TextEditingController _tricocefalosController;
  late final TextEditingController _uncinariaController;
  late final TextEditingController _teniaSaginataController;
  late final TextEditingController _teniaSoliumController;
  late final TextEditingController _himenolepsisController;
  late final TextEditingController _strongiloidesLarvaController;
  late final TextEditingController _oxiurosHuevosController;
  late final TextEditingController _sangreOcultaController;
  late final TextEditingController _leucocitosController;
  late final TextEditingController _observacionesController;

  bool guardando_ = false;

  @override
  void initState() {
    super.initState();

    _consistenciaController =
        TextEditingController(text: widget.coprologico.consistencia);

    _colorController = TextEditingController(text: widget.coprologico.color);
    _sangreController = TextEditingController(text: widget.coprologico.sangre);
    _mocoController = TextEditingController(text: widget.coprologico.moco);
    _otrosMacroscopicosController =
        TextEditingController(text: widget.coprologico.otrosMacroscopicos);

    _phController = TextEditingController(text: widget.coprologico.ph);
    _endamoebaHistoliticaQuistesController = TextEditingController(
        text: widget.coprologico.endamoebaHistoliticaQuistes);

    _endamoebaColiQuistesController =
        TextEditingController(text: widget.coprologico.endamoebaColiQuistes);

    _endolimaxQuistesController =
        TextEditingController(text: widget.coprologico.endolimaxQuistes);

    _iodamoebaQuistesController =
        TextEditingController(text: widget.coprologico.iodamoebaQuistes);

    _giardaLambliaQuistesController =
        TextEditingController(text: widget.coprologico.giardaLambliaQuistes);

    _chilomastixMesniliQuistesController = TextEditingController(
        text: widget.coprologico.chilomastixMesniliQuistes);

    _trichomonaHominisQuistesController = TextEditingController(
        text: widget.coprologico.trichomonaHominisQuistes);

    _balantidiumColiQuistesController = TextEditingController(
        text: widget.coprologico.balantidiumColiTrofozoitos);

    _endamoebaHistoliticaTrofozoitosController = TextEditingController(
        text: widget.coprologico.endamoebaHistoliticaTrofozoitos);

    _endamoebaColiTrofozoitosController = TextEditingController(
        text: widget.coprologico.endamoebaColiTrofozoitos);

    _endolimaxTrofozoitosController =
        TextEditingController(text: widget.coprologico.endolimaxTrofozoitos);

    _iodamoebaTrofozoitosController =
        TextEditingController(text: widget.coprologico.iodamoebaQuistes);

    _giardaLambliaTrofozoitosController =
        TextEditingController(text: widget.coprologico.giardaLambliaQuistes);

    _chilomastixMesniliTrofozoitosController = TextEditingController(
        text: widget.coprologico.chilomastixMesniliTrofozoitos);

    _trichomonaHominisTrofozoitosController = TextEditingController(
        text: widget.coprologico.trichomonaHominisTrofozoitos);

    _balantidiumColiTrofozoitosController = TextEditingController(
        text: widget.coprologico.balantidiumColiTrofozoitos);

    _blastocystisHominisQuistesController = TextEditingController(
        text: widget.coprologico.blastocystisHominisQuistes);

    _blastocystisHominisTrofozoitosController = TextEditingController(
        text: widget.coprologico.blastocystisHominisTrofozoitos);

    _ascarisController =
        TextEditingController(text: widget.coprologico.ascaris);
    _tricocefalosController =
        TextEditingController(text: widget.coprologico.tricocefalos);

    _uncinariaController =
        TextEditingController(text: widget.coprologico.uncinaria);

    _teniaSaginataController =
        TextEditingController(text: widget.coprologico.teniaSaginata);

    _teniaSoliumController =
        TextEditingController(text: widget.coprologico.teniaSolium);

    _himenolepsisController =
        TextEditingController(text: widget.coprologico.himenolepsis);

    _strongiloidesLarvaController =
        TextEditingController(text: widget.coprologico.strongiloidesLarva);

    _oxiurosHuevosController =
        TextEditingController(text: widget.coprologico.oxiurosHuevos);

    _sangreOcultaController =
        TextEditingController(text: widget.coprologico.sangreOculta);

    _leucocitosController =
        TextEditingController(text: widget.coprologico.lecucocitos);
    _observacionesController =
        TextEditingController(text: widget.coprologico.observaciones);
  }

  Widget _buildTextField(String labelText, TextEditingController controller) {
    String value = controller.text;
    value = value != 'null' ? value : '';
    controller.text = value;
    return TextFormField(
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
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        foregroundColor: Colors.white,
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
                      guardarCoprologico(
                              context, coprologicoS, widget.codexamen)
                          .then(
                        (value) {
                          if (true) {
                            printPDFFile(
                                context,
                                "coprologico",
                                "Exámen Coprológico",
                                "coprologico_${widget.paciente.identificacion}_${widget.fecha}.pdf",
                                widget.paciente.identificacion!,
                                widget.fecha,
                                widget.paciente.nombreCompleto,
                                widget.paciente.edad);
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
                      guardarCoprologico(
                              context, coprologicoS, widget.codexamen)
                          .then(
                        (value) {
                          showFloatingModalBottomSheet(
                            context: context,
                            builder: (context) => const ModalFit(
                              title: 'Exámen Coprológico almacenado',
                              asset: 'images/coprologico.png',
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
                    backgroundImage: AssetImage('images/coprologico.png'),
                  ),
                  const SizedBox(width: 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Exámen Coprológico',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.paciente.nombreCompleto,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.fecha,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.blueGrey,
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Form(
                autovalidateMode: AutovalidateMode.always,
                onChanged: () {
                  coprologicoS.consistencia = _consistenciaController.text;
                  coprologicoS.color = _colorController.text;
                  coprologicoS.sangre = _sangreController.text;
                  coprologicoS.moco = _mocoController.text;
                  coprologicoS.otrosMacroscopicos =
                      _otrosMacroscopicosController.text;
                  coprologicoS.ph = _phController.text;
                  coprologicoS.endamoebaHistoliticaQuistes =
                      _endamoebaHistoliticaQuistesController.text;
                  coprologicoS.endamoebaColiQuistes =
                      _endamoebaColiQuistesController.text;
                  coprologicoS.endolimaxQuistes =
                      _endolimaxQuistesController.text;
                  coprologicoS.iodamoebaQuistes =
                      _iodamoebaQuistesController.text;
                  coprologicoS.giardaLambliaQuistes =
                      _giardaLambliaQuistesController.text;
                  coprologicoS.chilomastixMesniliQuistes =
                      _chilomastixMesniliQuistesController.text;
                  coprologicoS.trichomonaHominisQuistes =
                      _trichomonaHominisQuistesController.text;
                  coprologicoS.balantidiumColiQuistes =
                      _balantidiumColiQuistesController.text;
                  coprologicoS.endamoebaHistoliticaTrofozoitos =
                      _endamoebaHistoliticaTrofozoitosController.text;
                  coprologicoS.endamoebaColiTrofozoitos =
                      _endamoebaColiTrofozoitosController.text;
                  coprologicoS.endolimaxTrofozoitos =
                      _endolimaxTrofozoitosController.text;
                  coprologicoS.iodamoebaTrofozoitos =
                      _iodamoebaTrofozoitosController.text;
                  coprologicoS.giardaLambliaTrofozoitos =
                      _giardaLambliaTrofozoitosController.text;
                  coprologicoS.chilomastixMesniliTrofozoitos =
                      _chilomastixMesniliTrofozoitosController.text;
                  coprologicoS.trichomonaHominisTrofozoitos =
                      _trichomonaHominisTrofozoitosController.text;
                  coprologicoS.balantidiumColiTrofozoitos =
                      _balantidiumColiTrofozoitosController.text;
                  coprologicoS.blastocystisHominisQuistes =
                      _blastocystisHominisQuistesController.text;
                  coprologicoS.blastocystisHominisTrofozoitos =
                      _blastocystisHominisTrofozoitosController.text;
                  coprologicoS.ascaris = _ascarisController.text;
                  coprologicoS.tricocefalos = _tricocefalosController.text;
                  coprologicoS.uncinaria = _uncinariaController.text;
                  coprologicoS.teniaSaginata = _teniaSaginataController.text;
                  coprologicoS.teniaSolium = _teniaSoliumController.text;
                  coprologicoS.himenolepsis = _himenolepsisController.text;
                  coprologicoS.strongiloidesLarva =
                      _strongiloidesLarvaController.text;
                  coprologicoS.oxiurosHuevos = _oxiurosHuevosController.text;
                  coprologicoS.sangreOculta = _sangreOcultaController.text;
                  coprologicoS.lecucocitos = _leucocitosController.text;
                  coprologicoS.observaciones = _observacionesController.text;
                  coprologicoS.identificacion = widget.paciente.identificacion;
                  coprologicoS.fecha = widget.fecha;
                },
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildTextField('Consistencia', _consistenciaController),
                      _buildTextField('Color', _colorController),
                      _buildTextField('Sangre', _sangreController),
                      _buildTextField('Moco', _mocoController),
                      _buildTextField(
                          'Otros Macroscopicos', _otrosMacroscopicosController),
                      _buildTextField('Ph', _phController),
                      _buildTextField('Endamoeba Histolitica Quistes',
                          _endamoebaHistoliticaQuistesController),
                      _buildTextField('Endamoeba Coli Quistes',
                          _endamoebaColiQuistesController),
                      _buildTextField(
                          'Endolimax Quistes', _endolimaxQuistesController),
                      _buildTextField(
                          'Iodamoeba Quistes', _iodamoebaQuistesController),
                      _buildTextField('Giarda Lamblia Quistes',
                          _giardaLambliaQuistesController),
                      _buildTextField('Chilomastix Mesnili Quistes',
                          _chilomastixMesniliQuistesController),
                      _buildTextField('Trichomona Hominis Quistes',
                          _trichomonaHominisQuistesController),
                      _buildTextField('Balantidium Coli Quistes ',
                          _balantidiumColiQuistesController),
                      _buildTextField('Endamoeba Histolitica Trofozoitos',
                          _endamoebaHistoliticaTrofozoitosController),
                      _buildTextField('Endamoeba Coli Trofozoitos',
                          _endamoebaColiTrofozoitosController),
                      _buildTextField('Endolimax Trofozoitos',
                          _endolimaxTrofozoitosController),
                      _buildTextField('Iodamoeba Trofozoitos',
                          _iodamoebaTrofozoitosController),
                      _buildTextField('Giarda Lamblia Trofozoitos',
                          _giardaLambliaTrofozoitosController),
                      _buildTextField('Chilomastix Mesnili Trofozoitos',
                          _chilomastixMesniliTrofozoitosController),
                      _buildTextField('Trichomona Hominis Trofozoitos',
                          _trichomonaHominisTrofozoitosController),
                      _buildTextField('Balantidium Coli Trofozoitos',
                          _balantidiumColiTrofozoitosController),
                      _buildTextField('Blastocystis Hominis Quistes',
                          _blastocystisHominisQuistesController),
                      _buildTextField('Blastocystis Hominis Trofozoitos',
                          _blastocystisHominisTrofozoitosController),
                      _buildTextField('Ascaris Controller', _ascarisController),
                      _buildTextField('Tricocefalos', _tricocefalosController),
                      _buildTextField('Uncinaria', _uncinariaController),
                      _buildTextField(
                          'Tenia Saginata', _teniaSaginataController),
                      _buildTextField('Tenia Solium', _teniaSoliumController),
                      _buildTextField('Himenolepsis', _himenolepsisController),
                      _buildTextField(
                          'Strongiloides Larva', _strongiloidesLarvaController),
                      _buildTextField(
                          'Oxiuros Huevos', _oxiurosHuevosController),
                      _buildTextField('sangre Oculta', _sangreOcultaController),
                      _buildTextField('leucocitos', _leucocitosController),
                      _buildTextField(
                          'observaciones', _observacionesController),
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
