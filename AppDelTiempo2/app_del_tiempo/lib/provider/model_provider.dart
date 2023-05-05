import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'map_clima.dart';

class ClimaProvider with ChangeNotifier {
  String apiKey = "YOU API KEY";
  String city = "Madrid";
  String stateCode = ""; //solo para estados unidos
  String contryCode = "";
  Clima? climaActual;
  Clima? climaCiudad;

  Future getObtenerClimaActual() async {
    var url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      climaActual = Clima.fromJson(response.body);
      print('EXITOOOO');
    } else {
      //todo mensaje de error o lo que sea que pase
      print('Error General,___${response.statusCode}');
    }
    notifyListeners();
  }

  Future<void> getObtenerClimaCiudad(String cityName) async {
    var url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      climaCiudad = Clima.fromJson(response.body);
      print('EXITO CIUDAD');
    } else {
      //todo mensaje de error o lo que sea que pase
      print('Error Ciudad,___${response.statusCode}');
    }
    notifyListeners();
  }
}
