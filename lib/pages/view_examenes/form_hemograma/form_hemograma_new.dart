// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:movavid/models/data-hemat.dart';
import 'package:movavid/models/hg_rayto.dart';
import 'package:movavid/providers/hrayto_provider.dart';
import 'package:provider/provider.dart';

class FormHemogramaNew extends StatefulWidget {
  final String identificacion;
  final String fecha;
  final HRayto hemograma;
  const FormHemogramaNew({
    super.key,
    required this.hemograma,
    required this.identificacion,
    required this.fecha,
  });

  @override
  State<FormHemogramaNew> createState() => _FormHemogramaState();
}

class _FormHemogramaState extends State<FormHemogramaNew> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Widget> formFields = [];
  String fsistematizado = '';
  HRayto hrayto = HRayto();
  TextEditingController wbcController = TextEditingController();
  TextEditingController lymNumberController = TextEditingController();
  TextEditingController midNumberController = TextEditingController();
  TextEditingController graNumberController = TextEditingController();
  TextEditingController lymPercentController = TextEditingController();
  TextEditingController midPercentController = TextEditingController();
  TextEditingController graPercentController = TextEditingController();
  TextEditingController rbcController = TextEditingController();
  TextEditingController hgbController = TextEditingController();
  TextEditingController mchcController = TextEditingController();
  TextEditingController mchController = TextEditingController();
  TextEditingController mcvController = TextEditingController();
  TextEditingController rdwCvController = TextEditingController();
  TextEditingController rdwSdController = TextEditingController();
  TextEditingController hctController = TextEditingController();
  TextEditingController pltController = TextEditingController();
  TextEditingController mpvController = TextEditingController();
  TextEditingController pdwController = TextEditingController();
  TextEditingController pctController = TextEditingController();
  TextEditingController pLcrController = TextEditingController();
  TextEditingController observacionesController = TextEditingController();

  HRayto getHemograma() {
    return hrayto;
  }

  late HRaytoProvider hraytoProvider;
  late Map<String, TextEditingController> datosHemat;

  @override
  void initState() {
    super.initState();
    print("incializando");
    hraytoProvider = Provider.of<HRaytoProvider>(context, listen: false);
    inicializador();
    formFields = [
      _buildTextField(
        'WBC',
        wbcController,
      ),
      _buildTextField(
        'LYM#',
        lymNumberController,
      ),
      _buildTextField(
        'MID#',
        midNumberController,
      ),
      _buildTextField(
        'GRA#',
        graNumberController,
      ),
      _buildTextField(
        'LYM%',
        lymPercentController,
      ),
      _buildTextField(
        'MID%',
        midPercentController,
      ),
      _buildTextField(
        'GRA%',
        graPercentController,
      ),
      _buildTextField(
        'RBC',
        rbcController,
      ),
      _buildTextField(
        'HGB',
        hgbController,
      ),
      _buildTextField(
        'MCHC',
        mchcController,
      ),
      _buildTextField(
        'MCH',
        mchController,
      ),
      _buildTextField(
        'MCV',
        mcvController,
      ),
      _buildTextField(
        'RDW-CV',
        rdwCvController,
      ),
      _buildTextField(
        'RDW-SD',
        rdwSdController,
      ),
      _buildTextField(
        'HCT',
        hctController,
      ),
      _buildTextField(
        'PLT',
        pltController,
      ),
      _buildTextField(
        'MPV',
        mpvController,
      ),
      _buildTextField(
        'PDW',
        pdwController,
      ),
      _buildTextField(
        'PCT',
        pctController,
      ),
      _buildTextField(
        'P-LCR',
        pLcrController,
      ),
      _buildTextField(
        'Observaciones',
        observacionesController,
      ),
    ];
  }

  void inicializador() {
    if (widget.hemograma.identificacion != 'Error') {
      wbcController.text = widget.hemograma.wBC!;
      hraytoProvider.hrayto.wBC = wbcController.text;
      lymNumberController.text = widget.hemograma.lYMn!;
      hraytoProvider.hrayto.lYMn = lymNumberController.text;
      midNumberController.text = widget.hemograma.mIDn!;
      hraytoProvider.hrayto.mIDn = midNumberController.text;
      graNumberController.text = widget.hemograma.gRAn!;
      hraytoProvider.hrayto.gRAn = graNumberController.text;
      lymPercentController.text = widget.hemograma.lYMp!;
      hraytoProvider.hrayto.lYMp = lymPercentController.text;
      midPercentController.text = widget.hemograma.mIDp!;
      hraytoProvider.hrayto.mIDp = midPercentController.text;
      graPercentController.text = widget.hemograma.gRAp!;
      hraytoProvider.hrayto.gRAp = graPercentController.text;
      rbcController.text = widget.hemograma.rBC!;
      hraytoProvider.hrayto.rBC = rbcController.text;
      hgbController.text = widget.hemograma.hGB!;
      hraytoProvider.hrayto.hGB = hgbController.text;
      mchcController.text = widget.hemograma.mCHC!;
      hraytoProvider.hrayto.mCHC = mchcController.text;
      mchController.text = widget.hemograma.mCH!;
      hraytoProvider.hrayto.mCH = mchController.text;
      mcvController.text = widget.hemograma.mCV!;
      hraytoProvider.hrayto.mCV = mcvController.text;
      rdwCvController.text = widget.hemograma.rDWCV!;
      hraytoProvider.hrayto.rDWCV = rdwCvController.text;
      rdwSdController.text = widget.hemograma.rDWSD!;
      hraytoProvider.hrayto.rDWSD = rdwSdController.text;
      hctController.text = widget.hemograma.hCT!;
      hraytoProvider.hrayto.hCT = hctController.text;
      pltController.text = widget.hemograma.pLT!;
      hraytoProvider.hrayto.pLT = pltController.text;
      mpvController.text = widget.hemograma.mPV!;
      hraytoProvider.hrayto.mPV = mpvController.text;
      pdwController.text = widget.hemograma.pDW!;
      hraytoProvider.hrayto.pDW = pdwController.text;
      pctController.text = widget.hemograma.pCT!;
      hraytoProvider.hrayto.pCT = pctController.text;
      pLcrController.text = widget.hemograma.pLCR!;
      hraytoProvider.hrayto.pLCR = pLcrController.text;
      hraytoProvider.hrayto.identificacion = widget.identificacion;
      hraytoProvider.hrayto.fecha = widget.fecha;
      observacionesController.text = widget.hemograma.observaciones!;
      hraytoProvider.hrayto.observaciones = observacionesController.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Formulario(
      identificacion: widget.identificacion,
      fecha: widget.fecha,
      hrayto: hrayto,
      wbcController: wbcController,
      lymNumberController: lymNumberController,
      midNumberController: midNumberController,
      graNumberController: graNumberController,
      lymPercentController: lymPercentController,
      midPercentController: midPercentController,
      graPercentController: graPercentController,
      rbcController: rbcController,
      hgbController: hgbController,
      mchcController: mchcController,
      mchController: mchController,
      mcvController: mcvController,
      rdwCvController: rdwCvController,
      rdwSdController: rdwSdController,
      hctController: hctController,
      pltController: pltController,
      mpvController: mpvController,
      pdwController: pdwController,
      pctController: pctController,
      pLcrController: pLcrController,
      hraytoProvider: hraytoProvider,
      formKey: _formKey,
      formFields: formFields,
      observacionesController: observacionesController,
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller) {
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
          color: Colors.red,
        ),
      ),
    );
  }
}

class Formulario extends StatelessWidget {
  final String identificacion;
  final String fecha;
  const Formulario({
    super.key,
    required this.hrayto,
    required this.wbcController,
    required this.lymNumberController,
    required this.midNumberController,
    required this.graNumberController,
    required this.lymPercentController,
    required this.midPercentController,
    required this.graPercentController,
    required this.rbcController,
    required this.hgbController,
    required this.mchcController,
    required this.mchController,
    required this.mcvController,
    required this.rdwCvController,
    required this.rdwSdController,
    required this.hctController,
    required this.pltController,
    required this.mpvController,
    required this.pdwController,
    required this.pctController,
    required this.pLcrController,
    required this.hraytoProvider,
    required GlobalKey<FormState> formKey,
    required this.formFields,
    required this.identificacion,
    required this.fecha,
    required this.observacionesController,
  }) : _formKey = formKey;

  final HRayto hrayto;
  final TextEditingController wbcController;
  final TextEditingController lymNumberController;
  final TextEditingController midNumberController;
  final TextEditingController graNumberController;
  final TextEditingController lymPercentController;
  final TextEditingController midPercentController;
  final TextEditingController graPercentController;
  final TextEditingController rbcController;
  final TextEditingController hgbController;
  final TextEditingController mchcController;
  final TextEditingController mchController;
  final TextEditingController mcvController;
  final TextEditingController rdwCvController;
  final TextEditingController rdwSdController;
  final TextEditingController hctController;
  final TextEditingController pltController;
  final TextEditingController mpvController;
  final TextEditingController pdwController;
  final TextEditingController pctController;
  final TextEditingController pLcrController;
  final TextEditingController observacionesController;
  final HRaytoProvider hraytoProvider;
  final GlobalKey<FormState> _formKey;
  final List<Widget> formFields;

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      onChanged: () {
        print("forms");
        hrayto.wBC = wbcController.text;
        hrayto.lYMn = lymNumberController.text;
        hrayto.mIDn = midNumberController.text;
        hrayto.gRAn = graNumberController.text;
        hrayto.lYMp = lymPercentController.text;
        hrayto.mIDp = midPercentController.text;
        hrayto.gRAp = graPercentController.text;
        hrayto.rBC = rbcController.text;
        hrayto.hGB = hgbController.text;
        hrayto.mCHC = mchcController.text;
        hrayto.mCH = mchController.text;
        hrayto.mCV = mcvController.text;
        hrayto.rDWCV = rdwCvController.text;
        hrayto.rDWSD = rdwSdController.text;
        hrayto.hCT = hctController.text;
        hrayto.pLT = pltController.text;
        hrayto.mPV = mpvController.text;
        hrayto.pDW = pdwController.text;
        hrayto.pCT = pctController.text;
        hrayto.pLCR = pLcrController.text;
        hrayto.observaciones = observacionesController.text;
        hrayto.identificacion = identificacion;
        hrayto.fecha = fecha;
        hraytoProvider.setData(hrayto);
      },
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: formFields,
        ),
      ),
    );
  }
}
