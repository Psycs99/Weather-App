import 'package:app_del_tiempo_2/provider/model_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClimaActual extends StatefulWidget {
  const ClimaActual({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ClimaActualState createState() => _ClimaActualState();
}

class _ClimaActualState extends State<ClimaActual> {
  double _temperaturaCelsius = 0.0;
  int nubes = 0;
  String nombre = "";

  @override
  Widget build(BuildContext context) {
    final climaActual = Provider.of<ClimaProvider>(context);
    final tiempo = climaActual.climaActual;
    final t = tiempo?.main.temp;
    final n = tiempo?.clouds.all;
    final nom = tiempo?.name;

    if (t != null) {
      _temperaturaCelsius = t;
    }

    if (n != null) {
      nubes = n;
    }
    if (nom != null) {
      nombre = nom;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'Buscar');
            },
            child: Clima1(
              nombre: nombre,
              temperatura: _temperaturaCelsius,
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'DetallesActuales');
            },
            child: Clima2(
              nubes: nubes,
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class Clima2 extends StatelessWidget {
  const Clima2({
    super.key,
    this.nubes,
  });

  // ignore: prefer_typing_uninitialized_variables
  final nubes;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 150,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 0))
        ],
        //color: Colors.indigo,
        image: DecorationImage(
            image: AssetImage('assets/Soleado.jpg'), fit: BoxFit.cover),
        borderRadius: BorderRadius.all(
          Radius.elliptical(100, 50),
        ),
      ),
      child: (nubes <= 30)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40.0),
                const Text(
                  'Despejado',
                  style: TextStyle(
                    fontSize: 25.0,
                    //color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50.0),
                Icon(
                  Icons.wb_sunny,
                  size: 70.0,
                  color: Colors.amber[500],
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40.0),
                const Text(
                  'Nublado',
                  style: TextStyle(
                    fontSize: 25.0,
                    //color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50.0),
                Icon(
                  Icons.cloud_rounded,
                  size: 70.0,
                  color: Colors.grey[500],
                ),
              ],
            ),
    );
  }
}

class Clima1 extends StatelessWidget {
  const Clima1({super.key, required this.temperatura, required this.nombre});

  // ignore: prefer_typing_uninitialized_variables
  final temperatura;
  // ignore: prefer_typing_uninitialized_variables
  final nombre;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 170,
      margin: const EdgeInsets.only(left: 10),
      // decoration: const BoxDecoration(
      //   //color: Colors.amber,
      //   borderRadius: BorderRadius.only(
      //       topRight: Radius.elliptical(30, 30),
      //       bottomLeft: Radius.elliptical(100, 60),
      //       bottomRight: Radius.elliptical(100, 60)),
      // ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Text(
            '$nombre',
            style: const TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.bold,
              //color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            '${temperatura.toStringAsFixed(1)}°C',
            style: const TextStyle(
              fontSize: 50.0,
              //color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
