import 'package:app_del_tiempo_2/provider/model_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CityDetailsPage extends StatefulWidget {
  final String city;

  const CityDetailsPage({Key? key, required this.city}) : super(key: key);

  @override
  State<CityDetailsPage> createState() => _CityDetailsPageState();
}

class _CityDetailsPageState extends State<CityDetailsPage> {
  double _temperaturaCelsius = 0.0;
  int nubes = 0;
  String nombre = "";
  double presion = 0.0;
  double viento = 0.0;
  double humedad = 0.0;
  double _temperaturaCelsiusSensacion = 0.0;
  double _visibilidad = 0;

  @override
  Widget build(BuildContext context) {
    final clima = Provider.of<ClimaProvider>(context);
    final tiempo = clima.climaCiudad;
    final t = tiempo?.main.temp;
    final n = tiempo?.clouds.all;
    final nom = tiempo?.name;
    final vie = tiempo?.wind.speed;
    final p = tiempo?.main.pressure;
    final visi = tiempo?.visibility;
    final h = tiempo?.main.humidity;
    final te = tiempo?.main.feelsLike;

    if (t != null) {
      _temperaturaCelsius = t;
    }

    if (n != null) {
      nubes = n;
    }
    if (nom != null) {
      nombre = nom;
    }
    if (te != null) {
      _temperaturaCelsiusSensacion = te;
    }
    if (vie != null) {
      viento = vie.toDouble();
    }

    if (p != null) {
      presion = p.toDouble();
    }

    if (visi != null) {
      _calcularVisibilidad(visi.toDouble());
    }
    if (h != null) {
      humedad = h.toDouble();
    }
    // Datos simulados del clima
    String temperature = "${_temperaturaCelsius.toStringAsFixed(1)}°C";
    String weatherStatus = "";
    if (nubes < 30) {
      weatherStatus = "Soleado";
    } else {
      weatherStatus = "Nublado";
    }
    String time = "14:30";
    List<Map<String, String>> weatherParameters = [
      {"Parámetro": "Viento", "Valor": "$viento km/h"},
      {"Parámetro": "Presión", "Valor": "$presion hPa"},
      {"Parámetro": "Humedad", "Valor": "$humedad%"},
      {"Parámetro": "Punto De Rocio", "Valor": "15°"},
      {"Parámetro": "Direccion Del Viento", "Valor": "SudEste"},
      {
        "Parámetro": "Sensacion Termica",
        "Valor": "${_temperaturaCelsiusSensacion.toStringAsFixed(1)}°c"
      },
      {"Parámetro": "Visibilidad", "Valor": "$_visibilidad km"},
      {"Parámetro": "Otros Parametros", "Valor": "def"},
      {"Parámetro": "Otros Parametros", "Valor": "ghi"},

      // Agrega más parámetros del clima aquí
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 40, 146, 246),
        elevation: 0,
        title: const Text(
          'City Details',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 5, bottom: 5),
            child: Container(
              padding: const EdgeInsets.only(right: 1, left: 1),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(90, 219, 255, 0.923),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextButton(
                onPressed: () {
                  clima.climaActual = clima.climaCiudad;
                  Navigator.pushNamed(context, 'home');
                },
                child: const Text(
                  'Actualizar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(247, 89, 255, 0.67),
              Color.fromRGBO(255, 131, 78, 1),
              Color.fromRGBO(103, 222, 255, 1),
            ],
          )),
          child: AllBody(
            city: nombre,
            time: time,
            temperature: temperature,
            weatherStatus: weatherStatus,
            weatherParameters: weatherParameters,
            nubes: nubes,
          )),
    );
  }

  void _calcularVisibilidad(double vis) {
    double visibilidad = vis / 1000;
    setState(() {
      _visibilidad = visibilidad;
    });
  }
}

class AllBody extends StatelessWidget {
  const AllBody({
    super.key,
    required this.city,
    required this.time,
    required this.temperature,
    required this.weatherStatus,
    required this.weatherParameters,
    required this.nubes,
  });

  final String city;
  final String time;
  final String temperature;
  final String weatherStatus;
  final List<Map<String, String>> weatherParameters;
  final int nubes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 180,
          //color: Colors.amber,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                NameAndTime(city: city, time: time),
                const SizedBox(height: 25),
                IconAndTempeture(
                  temperature: temperature,
                  weatherStatus: weatherStatus,
                  nubes: nubes,
                ),
              ],
            ),
          ),
        ),
        const Divider(),
        ListOfParameters(weatherParameters: weatherParameters),
      ],
    );
  }
}

class ListOfParameters extends StatelessWidget {
  const ListOfParameters({
    super.key,
    required this.weatherParameters,
  });

  final List<Map<String, String>> weatherParameters;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: weatherParameters.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(top: 3),
            padding: const EdgeInsets.only(left: 15, right: 25),
            width: double.infinity,
            height: 50,
            //color: Colors.red,
            child: Row(
              children: [
                Text(
                  weatherParameters[index]["Parámetro"]!,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                Expanded(child: Container()),
                Text(
                  weatherParameters[index]["Valor"]!,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class IconAndTempeture extends StatelessWidget {
  const IconAndTempeture({
    super.key,
    required this.temperature,
    required this.weatherStatus,
    required this.nubes,
  });

  final String temperature;
  final String weatherStatus;
  final int nubes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          (nubes < 30)
              ? const Icon(
                  Icons.wb_sunny,
                  size: 80,
                  color: Colors.amber,
                )
              : const Icon(
                  Icons.cloud,
                  size: 80,
                  color: Colors.white70,
                ),
          Expanded(child: Container()),
          Column(
            children: [
              Text(
                temperature,
                style: const TextStyle(
                  fontSize: 45,
                  //color: Colors.black,
                ),
              ),
              Text(
                weatherStatus,
                style: const TextStyle(
                  fontSize: 25,
                  //color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NameAndTime extends StatelessWidget {
  const NameAndTime({
    super.key,
    required this.city,
    required this.time,
  });

  final String city;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          city,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            //color: Colors.black,
          ),
        ),
        Expanded(child: Container()),
        const Icon(
          Icons.watch_later_outlined,
          size: 28,
          color: Colors.white,
        ),
        Text(
          time,
          style: const TextStyle(
            fontSize: 25,
            //color: Colors.black,
          ),
        ),
      ],
    );
  }
}
