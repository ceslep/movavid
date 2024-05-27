import 'package:flutter/material.dart';
import 'package:movavid/api/api_laboratorio.dart';
import 'package:movavid/models/paciente.dart';
import 'package:movavid/models/parcial_orina.dart';
import 'package:movavid/widgets/modals/floating_modal.dart';
import 'package:movavid/widgets/modals/modal_fit.dart';

class ViewParcialOrina extends StatefulWidget {
  final Paciente paciente;
  final ParcialOrina parcialOrina;
  final String fecha;
  final String codexamen;
  const ViewParcialOrina(
      {super.key,
      required this.paciente,
      required this.parcialOrina,
      required this.fecha,
      required this.codexamen});

  @override
  State<ViewParcialOrina> createState() => _ParcialOrinaState();
}

class _ParcialOrinaState extends State<ViewParcialOrina> {
  ParcialOrina parcialOrinaS = ParcialOrina();
  bool guardando_ = false;
  late final TextEditingController densidadController;
  late final TextEditingController colorController;
  late final TextEditingController aspectoController;
  late final TextEditingController phController;
  late final TextEditingController olorController;
  late final TextEditingController proteinasController;
  late final TextEditingController glucosaController;
  late final TextEditingController cuerposCetonicosController;
  late final TextEditingController sangreHemolizadaController;
  late final TextEditingController sangrenoHemolizadaController;
  late final TextEditingController bilirrubinaController;
  late final TextEditingController urobilinogenoController;
  late final TextEditingController nitritosController;
  late final TextEditingController leucocitosController;
  late final TextEditingController leucocitosmController;
  late final TextEditingController mocoController;
  late final TextEditingController eritrocitosController;
  late final TextEditingController levadurasController;
  late final TextEditingController piocitosController;
  late final TextEditingController celulasEpitelialesController;
  late final TextEditingController uratosAmorfosController;
  late final TextEditingController fosfatosAmorfosController;
  late final TextEditingController oxalatoDeCalcioController;
  late final TextEditingController bacteriasController;
  late final TextEditingController cilindrosHialinosController;
  late final TextEditingController cilindrosGranulososController;
  late final TextEditingController observacionesController;

  @override
  void initState() {
    super.initState();
    densidadController =
        TextEditingController(text: widget.parcialOrina.densidad);
    colorController = TextEditingController(text: widget.parcialOrina.color);
    aspectoController =
        TextEditingController(text: widget.parcialOrina.aspecto);
    phController = TextEditingController(text: widget.parcialOrina.ph);
    olorController = TextEditingController(text: widget.parcialOrina.olor);
    proteinasController =
        TextEditingController(text: widget.parcialOrina.proteinas);
    glucosaController =
        TextEditingController(text: widget.parcialOrina.glucosa);
    cuerposCetonicosController =
        TextEditingController(text: widget.parcialOrina.cuerposCetonicos);
    sangreHemolizadaController =
        TextEditingController(text: widget.parcialOrina.sangreHemolizada);
    sangrenoHemolizadaController =
        TextEditingController(text: widget.parcialOrina.sangreNoHemolizada);
    bilirrubinaController =
        TextEditingController(text: widget.parcialOrina.bilirrubina);
    urobilinogenoController =
        TextEditingController(text: widget.parcialOrina.urobilinogeno);
    nitritosController =
        TextEditingController(text: widget.parcialOrina.nitritos);
    leucocitosController =
        TextEditingController(text: widget.parcialOrina.leucocitos);
    leucocitosmController =
        TextEditingController(text: widget.parcialOrina.leucocitosm);
    mocoController = TextEditingController(text: widget.parcialOrina.moco);
    eritrocitosController =
        TextEditingController(text: widget.parcialOrina.eritrocitos);
    levadurasController =
        TextEditingController(text: widget.parcialOrina.levaduras);
    piocitosController =
        TextEditingController(text: widget.parcialOrina.piocitos);
    celulasEpitelialesController =
        TextEditingController(text: widget.parcialOrina.celulasEpiteliales);
    uratosAmorfosController =
        TextEditingController(text: widget.parcialOrina.uratosAmorfos);
    fosfatosAmorfosController =
        TextEditingController(text: widget.parcialOrina.fosfatosAmorfos);
    oxalatoDeCalcioController =
        TextEditingController(text: widget.parcialOrina.oxalatoDeCalcio);
    bacteriasController =
        TextEditingController(text: widget.parcialOrina.bacterias);
    cilindrosHialinosController =
        TextEditingController(text: widget.parcialOrina.cilindrosHialinos);
    cilindrosGranulososController =
        TextEditingController(text: widget.parcialOrina.cilindrosGranulosos);
    observacionesController =
        TextEditingController(text: widget.parcialOrina.observaciones);
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
        backgroundColor: Theme.of(context).colorScheme.primary,
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
                      guardarParcialOrina(
                              context, parcialOrinaS, widget.codexamen)
                          .then(
                        (value) {
                          if (true) {
                            printPDFFile(
                              context,
                              "parcialOrina",
                              "Parcial de Orina",
                              "parcialOrina_${widget.paciente.identificacion}_${widget.fecha}.pdf",
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
                      guardarParcialOrina(
                              context, parcialOrinaS, widget.codexamen)
                          .then(
                        (value) {
                          showFloatingModalBottomSheet(
                            context: context,
                            builder: (context) => const ModalFit(
                              title: 'Parcial de Orina almacenado',
                              asset: 'images/porina.png',
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
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('images/porina.png'),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Parcial de Orina',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.paciente.nombreCompleto,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.fecha,
                            style: const TextStyle(
                                fontSize: 10, color: Colors.blueGrey),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Form(
                autovalidateMode: AutovalidateMode.always,
                onChanged: () {
                  parcialOrinaS.densidad = densidadController.text;
                  parcialOrinaS.color = colorController.text;
                  parcialOrinaS.aspecto = aspectoController.text;
                  parcialOrinaS.color = colorController.text;
                  parcialOrinaS.aspecto = aspectoController.text;
                  parcialOrinaS.ph = phController.text;
                  parcialOrinaS.olor = olorController.text;
                  parcialOrinaS.proteinas = proteinasController.text;
                  parcialOrinaS.glucosa = glucosaController.text;
                  parcialOrinaS.cuerposCetonicos =
                      cuerposCetonicosController.text;
                  parcialOrinaS.sangreHemolizada =
                      sangreHemolizadaController.text;
                  parcialOrinaS.sangreNoHemolizada =
                      sangrenoHemolizadaController.text;
                  parcialOrinaS.bilirrubina = bilirrubinaController.text;
                  parcialOrinaS.urobilinogeno = urobilinogenoController.text;
                  parcialOrinaS.nitritos = nitritosController.text;
                  parcialOrinaS.leucocitos = leucocitosController.text;
                  parcialOrinaS.leucocitosm = leucocitosmController.text;
                  parcialOrinaS.moco = mocoController.text;
                  parcialOrinaS.eritrocitos = eritrocitosController.text;
                  parcialOrinaS.levaduras = levadurasController.text;
                  parcialOrinaS.piocitos = piocitosController.text;
                  parcialOrinaS.celulasEpiteliales =
                      celulasEpitelialesController.text;
                  parcialOrinaS.uratosAmorfos = uratosAmorfosController.text;
                  parcialOrinaS.fosfatosAmorfos =
                      fosfatosAmorfosController.text;
                  parcialOrinaS.oxalatoDeCalcio =
                      oxalatoDeCalcioController.text;
                  parcialOrinaS.bacterias = bacteriasController.text;
                  parcialOrinaS.cilindrosHialinos =
                      cilindrosHialinosController.text;
                  parcialOrinaS.cilindrosGranulosos =
                      cilindrosGranulososController.text;
                  parcialOrinaS.observaciones = observacionesController.text;
                  parcialOrinaS.identificacion = widget.paciente.identificacion;
                  parcialOrinaS.fecha = widget.fecha;
                },
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildTextField('Densidad', densidadController),
                      _buildTextField('Color', colorController),
                      _buildTextField('Aspecto', aspectoController),
                      _buildTextField('PH', phController),
                      _buildTextField('olor', olorController),
                      _buildTextField('Proteinas', proteinasController),
                      _buildTextField('Glucosa', glucosaController),
                      _buildTextField(
                          'Cuerpos Cetónicos', cuerposCetonicosController),
                      _buildTextField(
                          'Sangre Hemolizada', sangreHemolizadaController),
                      _buildTextField(
                          'Sangre No Hemolizada', sangrenoHemolizadaController),
                      _buildTextField('Bilirrubina', bilirrubinaController),
                      _buildTextField('Urobilinogeno', urobilinogenoController),
                      _buildTextField('Nitritos', nitritosController),
                      _buildTextField('Leucocitos', leucocitosController),
                      _buildTextField('leucocitos m', leucocitosmController),
                      _buildTextField('Moco', mocoController),
                      _buildTextField('Eritrocitos', eritrocitosController),
                      _buildTextField('Levaduras', levadurasController),
                      _buildTextField('Piocitos', piocitosController),
                      _buildTextField(
                          'Celulas Epiteliales', celulasEpitelialesController),
                      _buildTextField(
                          'Uratos Amorfos', uratosAmorfosController),
                      _buildTextField(
                          'Fosfatos Amorfos', fosfatosAmorfosController),
                      _buildTextField(
                          'Oxalato de Caalcio', oxalatoDeCalcioController),
                      _buildTextField('Bacterias', bacteriasController),
                      _buildTextField(
                          'Cilindros Hialinos', cilindrosHialinosController),
                      _buildTextField('Cilindros Granulosos',
                          cilindrosGranulososController),
                      _buildTextField('Observaciones', observacionesController),
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
