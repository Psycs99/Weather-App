import 'package:app_del_tiempo_2/pages/pa_export.dart';
import 'package:app_del_tiempo_2/provider/model_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuscaTuCiudad extends StatelessWidget {
  const BuscaTuCiudad({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Color.fromARGB(224, 66, 164, 245),
          title: const Text('Busca una Ciudad'),
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 3, 91, 163),
                  Color.fromARGB(255, 109, 187, 250),
                  Color.fromRGBO(115, 202, 148, 1),
                  Color.fromRGBO(217, 154, 77, 1)
                ],
              )),
            ),
            // Positioned(
            //   top: 220,
            //   left: 158,
            //   child: Container(
            //     height: 50,
            //     width: 50,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(4),
            //       //color: Colors.red, // Cambia el color de fondo aquí
            //     ),
            //     child: Image.asset('assets/paisaje.jpg'),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Center(
                        child: Text(
                          'Busca Cualquier ciudad del Mundo',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromRGBO(86, 86, 86, 1),
                          ),
                        ),
                      ),
                      const Divider(),
                      Container(
                        height: 418,
                        width: double.infinity,
                        //color: Colors.amber,
                        child: ListView(
                          children: [
                            CitySearchPage(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class CitySearchPage extends StatefulWidget {
  @override
  _CitySearchPageState createState() => _CitySearchPageState();
}

class _CitySearchPageState extends State<CitySearchPage> {
  List<String> selectedCities =
      []; // Lista para almacenar las ciudades seleccionadas
  String query = ''; // Variable para almacenar la consulta de búsqueda

  List<String> cities = [
    'New York',
    'Los Angeles',
    'Chicago',
    'Houston',
    'Philadelphia',
    'Phoenix',
    'San Antonio',
    'San Diego',
    'Dallas',
    'San Jose',
    'Austin',
    'Jacksonville',
    'San Francisco',
    'Columbus',
    'Fort Worth',
    'Indianapolis',
    'Charlotte',
    'Seattle',
    'Denver',
    'Washington',
  ];

  void _handleSearch(String value) {
    setState(() {
      query = value;
    });
  }

  void _handleCitySelected(String city) {
    setState(() {
      // Verificar si la ciudad ya está seleccionada antes de agregarla a la lista de ciudades seleccionadas
      if (!selectedCities.contains(city)) {
        selectedCities.add(city);
      }
    });
  }

  void _handleCityDeleted(String city) {
    setState(() {
      // Eliminar la ciudad seleccionada de la lista de ciudades seleccionadas
      selectedCities.remove(city);
    });
  }

  @override
  Widget build(BuildContext context) {
    final clima = Provider.of<ClimaProvider>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: TextField(
            onChanged: _handleSearch,
            decoration: const InputDecoration(
              labelText: 'Search city',
              labelStyle: TextStyle(
                fontSize: 20,
              ),
              hintText: 'Ej: New York',
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 110,
          //color: Colors.blue,
          child: ListView.builder(
            itemCount: cities.length,
            itemBuilder: (context, index) {
              final city = cities[index];
              if (query.isNotEmpty &&
                  !city.toLowerCase().contains(query.toLowerCase())) {
                return Container(); // Ocultar las ciudades que no coinciden con la búsqueda
              }
              return ListTile(
                title: Text(city),
                onTap: () {
                  _handleCitySelected(
                      city); // Manejar el evento de tocar una ciudad
                },
              );
            },
          ),
        ),
        const Divider(),
        selectedCities.isNotEmpty
            ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Selected Cities:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Color.fromRGBO(86, 86, 86, 1),
                  ),
                ),
              )
            : Container(
                width: double.infinity,
                height: 5,
              ),
        Container(
          width: double.infinity,
          height: 180,
          //color: Colors.red,
          child: ListView.builder(
            itemCount: selectedCities.length,
            itemBuilder: (context, index) {
              final selectedCity = selectedCities[index];
              return ListTile(
                title: Text(selectedCity),
                trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _handleCityDeleted(selectedCity);
                    }),
                onTap: () {
                  // Navegar a otra pantalla cuando se toca una ciudad seleccionada
                  clima.getObtenerClimaCiudad(selectedCity);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CityDetailsPage(city: selectedCity),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
