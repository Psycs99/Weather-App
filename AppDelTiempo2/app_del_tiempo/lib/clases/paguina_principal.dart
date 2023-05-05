import 'package:app_del_tiempo_2/clases/export_class.dart';
import 'package:app_del_tiempo_2/provider/model_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaguinaPrincipal extends StatelessWidget {
  const PaguinaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Provider.of<ClimaProvider>(context);

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.blue[400],
        title: const Text(
          'Aplicacion del Clima',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            //color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.cloud,
              size: 30,
            ),
            onPressed: () {
              c.getObtenerClimaActual();
            },
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            //color: Colors.red,
            image: DecorationImage(
                image: AssetImage('assets/clima1.jpg'), fit: BoxFit.cover)),
        child: ListView(
          children: [
            Column(
              children: [
                const ClimaActual(),
                ClimaSemanal(),
                const GraficaClima(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
