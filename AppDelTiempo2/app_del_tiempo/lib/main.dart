// ignore_for_file: deprecated_member_use

import 'package:app_del_tiempo_2/Temas/color_temas.dart';
import 'package:app_del_tiempo_2/clases/export_class.dart';
import 'package:app_del_tiempo_2/pages/pa_export.dart';
import 'package:app_del_tiempo_2/provider/model_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppClima());

class AppClima extends StatelessWidget {
  const AppClima({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ClimaProvider())],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: Temas().Tema(),
      initialRoute: 'home',
      routes: {
        'home': (_) => const PaguinaPrincipal(),
        'Buscar': (_) => const BuscaTuCiudad(),
        'Detalles': (_) => const DetallesClima(),
        'DetallesActuales': (_) => const DetallesActuales(),
      },
    );
  }
}
