import 'package:app_del_tiempo_2/clases/export_class.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Grafico extends StatelessWidget {
  final List<Pronostico> datos;

  const Grafico({super.key, required this.datos});

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      [
        charts.Series<Pronostico, String>(
          id: 'Parametros',
          data: datos,
          domainFn: (Pronostico registro, _) => registro.day,
          measureFn: (Pronostico registro, _) => registro.temperature,
          // Puedes personalizar la apariencia del gráfico según tus necesidades
          colorFn: (_, __) => charts.MaterialPalette.indigo.shadeDefault,
        ),
      ],
      // Configuración del gráfico
      animate: true,
      vertical: true, // Esto indica que el eje X está en posición vertical
    );
  }
}
