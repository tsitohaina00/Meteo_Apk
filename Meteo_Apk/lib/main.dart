import 'package:flutter/material.dart';
import 'data.dart';


import 'display.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();

  String errorText = "";
  bool searchPressed = false;

  WeatherResponse? _response;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color(0xffb0dbe8),
         body: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                     'METEO du JOUR',
                     textAlign: TextAlign.center,
                     style: TextStyle(
                       color: Color(0xff0b15bd),
                       fontSize: 30,
                       fontWeight: FontWeight.bold,
                       fontStyle: FontStyle.italic,
                     ),
                   ),
                  Container(
                    width:200,
                    height:130 ,
                    decoration: const BoxDecoration(
                      image:DecorationImage(image: AssetImage('assets/s.jpg'), fit: BoxFit.fill)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: SizedBox(
                        width: 160,
                        child: TextField(
                            controller: _cityTextController,
                            decoration: const InputDecoration(labelText: 'Veuillez entrer la ville'),
                            textAlign: TextAlign.center,
                        ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: (){
                        _search();
                        setState(() {
                          searchPressed = true;
                        });
                      },
                      child: const Text('Chercher')
                  ),
                  (searchPressed)?
                  (_response != null)?
                    Column(
                      children: [
                        Image.network(_response!.iconUrl),
                        Text(
                            _response!.weatherInfo.description,
                          style: const TextStyle(
                            color: Color(0xffea24d8),
                              fontSize: 15,
                          ),
                        ),
                        Text(
                          '${_response!.tempInfo.temperature}°',
                          style: const TextStyle(fontSize: 40),
                        ),
                        Text(
                          'Pression:${_response!.tempInfo.pressure} hPa',
                          style: const TextStyle(fontStyle: FontStyle.italic,color: Color(0xff798f2a)),
                        ),
                        Text(
                            'Humidité:${_response!.tempInfo.humidity} %',
                          style: const TextStyle(fontStyle: FontStyle.italic,color: Color(0xff798f2a)),
                        ),

                      ],
                    ):const Text(
                  'VEUILLEZ ENTRER UNE VILLE SVP!!',
                  style: TextStyle(fontSize: 10, color: Colors.red),
                  ):const Text('') ,

                ],
              ),
            ),
          ),
        ),
    );

  }

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    setState(() => _response = response);
  }
}


