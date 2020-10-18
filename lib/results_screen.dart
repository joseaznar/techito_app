import 'package:app/main_object.dart';
import 'package:app/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultsScreen extends StatefulWidget {
  static String routeName = '/results';

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  final GlobalKey<FormState> _scaffoldKey = GlobalKey<FormState>();

  _submitForm(BuildContext context) {
    List<TextSpan> _spans = [
      new TextSpan(
        style: TextStyle(fontSize: 25),
        text: " ¡Felicidades!  \n\n",
      ),
      new TextSpan(
        style: TextStyle(fontWeight: FontWeight.bold),
        text: " TECHito ",
      ),
      new TextSpan(
        style: TextStyle(color: Colors.grey),
        text:
            "te recomendará posibles soluciones que podrás adquirir con ayuda de créditos verdes de ",
      ),
      new TextSpan(
        style: TextStyle(fontWeight: FontWeight.bold),
        text: "BBVA",
      ),
      new TextSpan(
        style: TextStyle(color: Colors.grey),
        text: ", la banca líder en financiación sostenible. \n\n",
      ),
      new TextSpan(
        style: TextStyle(color: Colors.grey),
        text: " Un agente de ",
      ),
      new TextSpan(
        style: TextStyle(fontWeight: FontWeight.bold),
        text: "BBVA",
      ),
      new TextSpan(
        style: TextStyle(color: Colors.grey),
        text: " te contactará a la brevedad.",
      ),
    ];

    showCustomDialog(context, _spans);
  }

  @override
  Widget build(BuildContext context) {
    final MainObject main = Provider.of<MainObject>(context, listen: false);
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;

    if (args == null) {
      args = {
        "id": 5,
        "email": "hello@example.com",
        "phone": "",
        "carbonFootprint": 12679,
        "answers": [
          {
            "id": 25,
            "content": "Vegetariano",
            "question": {
              "id": 8,
              "content": "¿Qué regimen alimenticio tienes?",
              "type": "MultipleChoice",
              "options": [
                {"id": 3, "content": "Como carne diario"},
                {"id": 4, "content": "Como carne regularmente"},
                {"id": 5, "content": "Vegetariano"},
                {"id": 6, "content": "Vegano"}
              ]
            }
          },
          {
            "id": 21,
            "content": "2",
            "question": {
              "id": 4,
              "content": "¿Cuántas personas viven en tu hogar?",
              "type": "Open",
              "options": []
            }
          },
          {
            "id": 22,
            "content": "2500",
            "question": {
              "id": 5,
              "content": "¿De cuánto es tu recibo de luz (al mes)?",
              "type": "Open",
              "options": []
            }
          },
          {
            "id": 23,
            "content": "1020",
            "question": {
              "id": 6,
              "content": "¿De cuánto es tu recibo de gas (al mes)?",
              "type": "Open",
              "options": []
            }
          },
          {
            "id": 24,
            "content": "2",
            "question": {
              "id": 7,
              "content": "¿Cuántas horas pasas en el carro promedio al día?",
              "type": "Open",
              "options": []
            }
          },
          {
            "id": 26,
            "content": "12",
            "question": {
              "id": 9,
              "content": "¿Cuántos horas promedio viajes en avión anualmente? ",
              "type": "Open",
              "options": []
            }
          }
        ]
      };
    }

    double ahorroLuz = 0;
    (args['answers'] as List).forEach((ans) {
      if ((ans['question']['content'] as String).contains('luz')) {
        ahorroLuz = double.parse('${ans['content']}') * 0.9 * 12;
      }
    });

    double carbonFootprint = double.parse('${args['carbonFootprint']}') / 1000;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).buttonColor,
        child: Icon(
          Icons.home,
        ),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/');
        },
      ),
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Color(0xFF032C43),
              image: DecorationImage(
                image: AssetImage('assets/results_bg.jpeg'),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    child: Text(
                      'Tu huella de carbón es',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).buttonColor.withOpacity(0.7),
                      ),
                      child: Text(
                        '$carbonFootprint toneladas de CO2',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Esto equivale a:',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      '☞ ${carbonFootprint * 64} árboles necesarios al año para mitigarlo',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      '☞ ${carbonFootprint * 0.04 * 10000} metros cuadrados del planeta para compensar por tu consumo',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Todos tenemos un techo. ¡APROVÉCHALO!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Según nuestros cálculos podrás ahorrar \$$ahorroLuz  anualmente con ayuda de TECHito.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: buildSubmitButtonOrLoader(
                            250,
                            main,
                            () => _submitForm(context),
                            false,
                            true,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).accentColor.withOpacity(0.7),
                          ),
                          child: Text(
                            ' ¡CAMBIATE A ENERGÍAS RENOVABLES Y LUCHEMOS JUNTOS CONTRA EL CALENTAMIENTO GLOBAL!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor.withOpacity(0.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icon-techito.png',
                    fit: BoxFit.contain,
                    height: 70,
                  ),
                  Image.asset(
                    'assets/bbva-icon.png',
                    fit: BoxFit.contain,
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
