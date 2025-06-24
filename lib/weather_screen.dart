import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/secrets.dart';
import 'package:weather_app/additional_info_item.dart';
import 'package:weather_app/hourly_focus_item.dart';
import 'package:http/http.dart' as http;


class WeatherScreen extends StatefulWidget {

  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  double temp = 0;
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'Surat';
    final response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey&units=metric",
    ),
    );


    final data = jsonDecode(response.body);
    
    if(data['cod'] != '200') {
      throw "An unexpected error occured";
    }
    
    return data;
    
    } catch(e) {
      throw e.toString();
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const 
        Text("Weather App",style: 
          TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        actions: [
          Tooltip(
            message: "Refresh",
            child: IconButton(onPressed: () {
              setState(() {
                
              });
            }, icon: Icon(Icons.refresh_rounded,
              size: 40,
            ),),
          )
        ],
      ),


      body: 
      FutureBuilder(
        future: getCurrentWeather(),
        builder:(context,snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child:  CircularProgressIndicator.adaptive());
          } 

          if(snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final data = snapshot.data!;
          final currentTemp = data['list'][0]['main']['temp'];
          final currentSky = data['list'][0]['weather'][0]['main'];

          final currentHumidity = data['list'][0]['main']['humidity'];
          final currentWindSpeed = data['list'][0]['wind']['speed'];
          final currentPressure = data['list'][0]['main']['pressure'];

          return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // main card big size
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(13)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(13),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text('$currentTemp° C',style: 
                              const TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Icon(
                              currentSky == 'Clouds' || currentSky == 'Rain' ? Icons.cloud : Icons.sunny,
                              size: 80,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text('$currentSky', style:
                              const TextStyle(
                                fontSize: 30,
                                fontFamily: 'Times New Roman',
                                fontStyle: FontStyle.italic
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        
        
              const SizedBox(
                height: 20,
              ),
        
        
              // Hourly forecast cards
              const Text(
                "Hourly ForeCast",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 18),
        
              
        
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    final hourlyForecast = data['list'][index + 1];
                    final hourlySky = data['list'][index + 1]['weather'][0]['main'];
                    final hourlytemp = hourlyForecast['main']['temp'].toString();
                    final times = DateTime.parse(hourlyForecast['dt_txt'].toString());
                    return HourlyForecastItem(
                      time:  DateFormat.j().format(times),
                      icon: hourlySky == 'Clouds' || hourlySky == 'Rain'? Icons.cloud : Icons.sunny, 
                      temperature: hourlytemp ,
                    );
                  },
                ),
              ),
        
              const SizedBox(height: 20),
          
              // additional information cards
              const Text(
                "Additional Information",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
        
              const SizedBox(height: 20),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: AdditionalInfoWidget(icon: Icons.water_drop_sharp, label: 'Humidity', value: "$currentHumidity%",),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child:  AdditionalInfoWidget(icon: Icons.air_sharp, label: 'Wind Speed', value: "$currentWindSpeed m/s",),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: AdditionalInfoWidget(icon: Icons.beach_access_outlined, label: 'Pressure', value: "$currentPressure hPa",),
                  ),
                ],
              ),
        
            ],
          ),
        );
        },
      ),
    );
  }
}







