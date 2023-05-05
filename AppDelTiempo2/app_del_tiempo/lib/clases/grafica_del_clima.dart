import 'package:app_del_tiempo_2/clases/export_class.dart';
import 'package:flutter/material.dart';

class GraficaClima extends StatelessWidget {
  const GraficaClima({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 300,
      width: 600,
      color: Colors.grey[400],
      child: Grafico(datos: ClimaSemanal().forecastList1),
    );
  }
}
