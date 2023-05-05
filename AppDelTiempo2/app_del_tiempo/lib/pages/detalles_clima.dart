import 'package:app_del_tiempo_2/provider/model_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetallesClima extends StatefulWidget {
  const DetallesClima({super.key});

  @override
  State<DetallesClima> createState() => _DetallesClimaState();
}

class _DetallesClimaState extends State<DetallesClima> {
  double _visibilidad = 0;
  double _temperaturaCelsius = 0.0;
  double _temperaturaCelsiusSensacion = 0.0;

  int nubes = 0;
  double presion = 0.0;
  double viento = 0.0;
  double humedad = 0.0;

  @override
  Widget build(BuildContext context) {
    final climaActual = Provider.of<ClimaProvider>(context);
    final tiempo = climaActual.climaActual;
    final t = tiempo?.main.temp;
    final te = tiempo?.main.feelsLike;
    final n = tiempo?.clouds.all;
    final vie = tiempo?.wind.speed;
    final p = tiempo?.main.pressure;
    final visi = tiempo?.visibility;
    final h = tiempo?.main.humidity;

    if (t != null) {
      _temperaturaCelsius = t;
    }
    if (te != null) {
      _temperaturaCelsiusSensacion = te;
    }
    if (n != null) {
      nubes = n;
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

    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 245, 202, 71),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 11, 63, 249),
            Color.fromARGB(255, 82, 117, 245),
            Color.fromRGBO(4, 5, 98, 1)
          ],
        )),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                //color: Colors.blue,
                height: 40,
                width: 40,
                child: IconButton(
                  alignment: Alignment.topLeft,
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.grey,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                height: 515,
                width: double.infinity,
                //color: Colors.red,
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TopDetails(),
                    MidDetails(
                      temperatura: _temperaturaCelsius,
                      nubes: nubes,
                    ),
                    EndDetails(
                      visibilidad: _visibilidad,
                      presion: presion,
                      viento: viento,
                      humedad: humedad,
                      sensacion: _temperaturaCelsiusSensacion,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _calcularVisibilidad(double vis) {
    double visibilidad = vis / 1000;
    setState(() {
      _visibilidad = visibilidad;
    });
  }
}

class EndDetails extends StatelessWidget {
  const EndDetails({
    super.key,
    required this.viento,
    required this.presion,
    required this.visibilidad,
    required this.humedad,
    required this.sensacion,
  });

  final viento;
  final presion;
  final visibilidad;
  final humedad;
  final sensacion;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25, left: 4),
      //color: Colors.black,
      height: 295,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1, left: 10, right: 5),
            child: Wrap(
              spacing: 50,
              runSpacing: 35,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 60,
                      child: const Text(
                        'Viento',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '$viento km/h',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 170,
                      child: const Text(
                        'Direccion del Viento',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Text(
                      'NorEste',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),

                //const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      child: const Text(
                        'Humedad',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '$humedad %',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                //const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 160,
                      child: const Text(
                        'Sensacion Termica',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '$sensacion°',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                //const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      child: const Text(
                        'Visibilidad',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '$visibilidad km',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      child: const Text(
                        'Indice UV',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Text(
                      '1',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 90,
                      child: const Text(
                        'Presion',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '$presion mb',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 130,
                      child: const Text(
                        'Punto de Rocio',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Text(
                      '12°',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MidDetails extends StatelessWidget {
  const MidDetails({
    super.key,
    this.temperatura,
    this.nubes,
  });

  final temperatura;
  final nubes;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: (nubes < 30)
            ? InfoMid(
                nubes: nubes,
                temperatura: temperatura,
                icon: Icons.sunny,
                color: Colors.amber,
              )
            : InfoMid(
                nubes: nubes,
                temperatura: temperatura,
                icon: Icons.cloud_rounded,
                color: Colors.grey,
              ),
      ),
    );
  }
}

class InfoMid extends StatelessWidget {
  const InfoMid({
    super.key,
    required this.nubes,
    required this.temperatura,
    required this.icon,
    required this.color,
  });

  final nubes;
  final temperatura;
  final icon;
  final color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: Icon(
            icon,
            size: 125,
            color: color,
          ),
        ),
        const SizedBox(width: 20),
        Container(
          margin: const EdgeInsets.all(2),
          child: (nubes < 30)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${temperatura.toStringAsFixed(1)}°',
                      style: TextStyle(fontSize: 55),
                    ),
                    const Text(
                      'Soleado',
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${temperatura.toStringAsFixed(1)}°',
                      style: TextStyle(fontSize: 55),
                    ),
                    const Text(
                      'Nublado',
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
        )
      ],
    );
  }
}

class TopDetails extends StatelessWidget {
  const TopDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5, left: 5),
          child: const Text(
            'El Tiempo del dia "dia en el que estassss"',
            style: TextStyle(fontSize: 20),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8, left: 5),
          child: const Text(
            '16:15 hs',
            style: TextStyle(fontSize: 19),
          ),
        )
      ],
    );
  }
}
