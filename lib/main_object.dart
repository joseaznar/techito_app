import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class MainObject with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  Future<Map<String, dynamic>> submitAnswer(
      Map<String, dynamic> answerData) async {
    Map<String, dynamic> resp = {'hasError': true, 'message': 'No answer.'};
    try {
      _isLoading = true;
      notifyListeners();

      resp = await postAnswer(
        alimento: answerData['alimentos'],
        avion: answerData['avion'],
        carro: answerData['carro'],
        correo: answerData['correo'],
        gas: answerData['gas'],
        luz: answerData['luz'],
        personas: answerData['personas'],
      );

      _isLoading = false;
      notifyListeners();
    } catch (err) {
      print(err);
    }
    return resp;
  }

  /*  {
  "answers": [
    {
      "content": "2",
      "question": 4
    },
    {
      "content": "800",
      "question": 5
    },
    {
      "content": "1020",
      "question": 6
    },
    {
      "content": "2",
      "question": 7
    },
    {
      "content": "Vegetariano",
      "question": 8
    },
    {
      "content": "12",
      "question": 9
    }
  ],
  "email": "hello@example.com"
} */

  static Future<Map<String, dynamic>> postAnswer({
    String personas,
    String luz,
    String gas,
    String carro,
    String alimento,
    String avion,
    String correo,
  }) async {
    http.Response response;
    Map<String, dynamic> responseData;
    Map<String, dynamic> req = {
      "answers": [
        {"content": personas, "question": 4},
        {"content": luz, "question": 5},
        {"content": gas, "question": 6},
        {"content": carro, "question": 7},
        {"content": alimento, "question": 8},
        {"content": avion, "question": 9}
      ],
      "email": correo
    };

    print(req);

    response = await http.post('http://18.218.135.180/questions/answer',
        body: json.encode(req), headers: {'Content-Type': 'application/json'});

    responseData = json.decode(response.body);

    print(responseData);

    responseData = {...responseData, 'hasError': response.statusCode >= 400};

    return responseData;
  }
}
