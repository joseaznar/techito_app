import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'form_screen.dart';
import 'home_screen.dart';
import 'main_object.dart';
import 'results_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: MainObject(),
        ),
      ],
      child: Consumer<MainObject>(
        builder: (context, auth, child) {
          return MaterialApp(
            title: 'TECHito',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: Color(0xFF4B7977),
              accentColor: Color(0xFF7DA87B),
              buttonColor: Color(0xFFEAECC0),
              fontFamily: 'Poppins',
            ),
            home: HomeScreen(),
            routes: {
              HomeScreen.routeName: (context) => HomeScreen(),
              FormScreen.routeName: (context) => FormScreen(),
              ResultsScreen.routeName: (context) => ResultsScreen(),
            },
          );
        },
      ),
    );
  }
}
