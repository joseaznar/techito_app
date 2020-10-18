import 'package:app/form_screen.dart';
import 'package:app/main_object.dart';
import 'package:app/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _scaffoldKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final MainObject main = Provider.of<MainObject>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Image.asset(
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
                image: AssetImage('assets/home_bg.png'),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    child: Text(
                      'Mejora tu economía, reduciendo tu huella de carbón',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: buildSubmitButtonOrLoader(
                      250,
                      main,
                      () => Navigator.of(context)
                          .pushReplacementNamed(FormScreen.routeName),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Text(
                      '☞ Cada SEGUNDO se talan 4 hectáreas de árboles',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Text(
                      '☞ La generación de energía es la fuente más grande de CO2',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Text(
                      '☞ Puedes ahorrar hasta el 90% de tus facturas de luz usando paneles solares',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
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
