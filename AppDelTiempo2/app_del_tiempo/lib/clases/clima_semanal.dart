import 'package:app_del_tiempo_2/provider/model_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClimaSemanal extends StatelessWidget {
  final List<Pronostico> forecastList = [
    Pronostico(day: 'Lunes', temperature: 28),
    Pronostico(day: 'Martes', temperature: 26),
    Pronostico(day: 'Miércoles', temperature: 27),
    Pronostico(day: 'Jueves', temperature: 25),
    Pronostico(day: 'Viernes', temperature: 26),
    Pronostico(day: 'Sábado', temperature: 24),
    Pronostico(day: 'Domingo', temperature: 25),
  ];
  final List<Pronostico> forecastList1 = [
    Pronostico(day: 'Lun', temperature: 28),
    Pronostico(day: 'Mar', temperature: 26),
    Pronostico(day: 'Mié', temperature: 27),
    Pronostico(day: 'Jue', temperature: 25),
    Pronostico(day: 'Vie', temperature: 26),
    Pronostico(day: 'Sáb', temperature: 24),
    Pronostico(day: 'Dom', temperature: 25),
  ];

  ClimaSemanal({super.key});

  double _temperaturaCelsius = 0.0;
  int nubes = 0;

  @override
  Widget build(BuildContext context) {
    final climaActual = Provider.of<ClimaProvider>(context);
    final tiempo = climaActual.climaActual;
    final t = tiempo?.main.temp;
    final n = tiempo?.clouds.all;

    if (t != null) {
      _temperaturaCelsius = t;
    }
    if (n != null) {
      nubes = n;
    }

    return Container(
      height: 220.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forecastList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'Detalles');
              },
              child: Container(
                height: 350,
                width: 150,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 0),
                    )
                  ],
                  //color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      image: AssetImage('assets/Nubes1.jpeg'),
                      fit: BoxFit.cover),
                  // border: Border.all(
                  //     width: 5,
                  //     color: const Color.fromRGBO(9, 255, 0, 0.2),
                  //     ),
                ),
                child: (nubes < 30)
                    ? Column(
                        children: [
                          const SizedBox(height: 10.0),
                          Text(
                            forecastList[index].day,
                            style: const TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              //color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            '${_temperaturaCelsius.toStringAsFixed(1)}°C',
                            style: const TextStyle(
                              fontSize: 40.0,
                              //color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          (nubes < 30)
                              ? const Icon(
                                  Icons.sunny,
                                  size: 50,
                                  color: Colors.amber,
                                )
                              : const Icon(
                                  Icons.cloud,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                        ],
                      )
                    : Column(
                        children: [
                          const SizedBox(height: 10.0),
                          Text(
                            forecastList[index].day,
                            style: const TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              //color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            '${_temperaturaCelsius.toStringAsFixed(1)}°C',
                            style: const TextStyle(
                              fontSize: 30.0,
                              //color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          const Icon(
                            Icons.cloud,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ],
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Pronostico {
  final String day;
  final int temperature;

  Pronostico({required this.day, required this.temperature});
}
