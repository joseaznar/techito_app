import 'package:app/main_object.dart';
import 'package:app/results_screen.dart';
import 'package:app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatefulWidget {
  static String routeName = '/form';

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  static final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _scaffoldKey = GlobalKey<FormState>();
  static Map<String, dynamic> _formData = {};

  _submitForm(
    BuildContext context,
    MainObject main,
    Map<String, dynamic> answerData,
  ) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    print(_formData);

    Map<String, dynamic> successInformation =
        await main.submitAnswer(answerData);

    print(successInformation);

    Navigator.of(context).pushReplacementNamed(
      ResultsScreen.routeName,
      arguments: successInformation,
    );

    /*

    if (!successInformation['hasError']) {
      Scaffold.of(_formKey.currentContext).showSnackBar(SnackBar(
        content: Text('Update  was succesful!'),
        duration: Duration(seconds: 3),
      ));

      await Future.delayed(Duration(seconds: 1));
      if (editMode) {
        Navigator.of(context).pop();
      }
    }

    if (!editMode) {
      _formData.remove('editMode');
      Navigator.pushReplacementNamed(context, ContactScreen.routeName,
          arguments: _formData);
    } */
  }

  @override
  Widget build(BuildContext context) {
    final MainObject main = Provider.of<MainObject>(context, listen: false);

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        child: Image.asset(
          'assets/icon-techito.png',
          fit: BoxFit.contain,
          height: 100,
        ),
      ),
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Color(0xFF032C43),
              image: DecorationImage(
                image: AssetImage('assets/form_bg.png'),
                fit: BoxFit.cover,
                /* colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.1),
                  BlendMode.dstATop,
                ), */
              ),
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: 35,
              vertical: 40,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    buildSectionText(
                        '¿Cuántas personas viven en tu hogar?', context),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (String value) {
                        if (value == null || value.isEmpty) {
                          return 'Se require este campo';
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _formData['personas'] = value;
                      },
                    ),
                    buildSectionText(
                        '¿De cuánto es tu recibo de luz (al mes)?', context),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        _formData['luz'] = value;
                      },
                      validator: (String value) {
                        if (value == null || value.isEmpty) {
                          return 'Se require este campo';
                        }

                        return null;
                      },
                    ),
                    buildSectionText(
                        '¿De cuánto es tu recibo de gas (al mes)?', context),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        _formData['gas'] = value;
                      },
                      validator: (String value) {
                        if (value == null || value.isEmpty) {
                          return 'Se require este campo';
                        }

                        return null;
                      },
                    ),
                    buildSectionText(
                        '¿Cuántas horas pasas en el carro promedio al día?',
                        context),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        _formData['carro'] = value;
                      },
                      validator: (String value) {
                        if (value == null || value.isEmpty) {
                          return 'Se require este campo';
                        }

                        return null;
                      },
                    ),
                    buildSectionText(
                        '¿Qué regimen alimenticio tienes?', context),
                    FormBuilderDropdown(
                      initialValue: 'Como carne diario',
                      attribute: "alimentos",
                      onSaved: (value) {
                        _formData['alimentos'] = value;
                      },
                      hint: Text('Escoja su regimen alimenticio'),
                      validators: [FormBuilderValidators.required()],
                      items: [
                        'Como carne diario',
                        'Como carne regularmente',
                        'Vegetariano',
                        'Vegano',
                      ]
                          .map((item) => DropdownMenuItem(
                              value: item, child: Text("$item")))
                          .toList(),
                    ),
                    buildSectionText(
                        '¿Cuántos horas promedio viajes en avión anualmente?',
                        context),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        _formData['avion'] = value;
                      },
                      validator: (String value) {
                        if (value == null || value.isEmpty) {
                          return 'Se require este campo';
                        }

                        return null;
                      },
                    ),
                    buildSectionText('Dejanos tu correo electrónico', context),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) {
                        _formData['correo'] = value;
                      },
                      validator: (String value) {
                        if (value == null || value.isEmpty) {
                          return 'Se require este campo';
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: buildSubmitButtonOrLoader(
                        250,
                        main,
                        () => _submitForm(context, main, _formData),
                        true,
                        false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
