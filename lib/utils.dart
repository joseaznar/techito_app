import 'package:flutter/material.dart';

import 'main_object.dart';

double mainTextSize = 17;

showCustomDialog(BuildContext context, List<TextSpan> textWidgets) {
  bool isLandscape =
      MediaQuery.of(context).orientation == Orientation.landscape;
  double width = MediaQuery.of(context).size.width * 0.85;
  double height =
      MediaQuery.of(context).size.height * (isLandscape ? 0.9 : 0.6);
  showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 700),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          height: height,
          width: width,
          child: _buildMessage(textWidgets),
          //margin: EdgeInsets.only(bottom: 50, left: 0,),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: Offset(-1, 0), end: Offset(0, 0)).animate(anim1),
        child: child,
      );
    },
  );
}

Widget _buildMessage(List<TextSpan> textWidgets) {
  return Material(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(30),
      bottomRight: Radius.circular(30),
    ),
    child: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: new RichText(
        text: new TextSpan(
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: mainTextSize,
          ),
          children: textWidgets,
        ),
      ),
    ),
  );
}

Future<void> showAlert(BuildContext context, String title, String content,
    {goToLogin = false, goToPreviousScreen = false}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              if (goToLogin) {
                Navigator.of(context).pushReplacementNamed('/');
              } else {
                Navigator.of(context).pop();

                if (goToPreviousScreen) {
                  Navigator.of(context).pop();
                }
              }
            },
          )
        ],
      );
    },
  );

  return null;
}

Widget buildSubmitButtonOrLoader(
    double targetWidth, MainObject main, Function submitFunction,
    [bool endMode = false, bool saveMode = false]) {
  return Center(
    child: main.isLoading
        ? Padding(
            padding: EdgeInsets.only(
              bottom: 40,
            ),
            child: CircularProgressIndicator(),
          )
        : RaisedButton(
            padding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            textColor: Colors.black,
            child: Container(
              width: targetWidth,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(0.0),
              child: Center(
                child: Text(
                  endMode
                      ? 'TERMINAR'
                      : saveMode
                          ? 'QUIERO AHORRAR'
                          : 'CALCULAR',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            onPressed: submitFunction,
          ),
  );
}

Widget buildSectionText(String text, BuildContext context,
    [bool padding = false]) {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: padding ? 20 : 0,
      vertical: 10,
    ),
    child: Text(
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: mainTextSize,
        fontWeight: FontWeight.bold,
        //fontFamily: 'Arial',
      ),
    ),
  );
}
