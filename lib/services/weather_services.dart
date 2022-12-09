
import 'dart:convert';
import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart'as http;

class WeatherServices{
//http://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=
  String baseUrl="http://api.openweathermap.org/data/2.5";
  String apiKey=""; //your key

  Future<WeatherModel> getWeather({required cityName})async {
    Uri url = Uri.parse(
        '$baseUrl/weather?q=$cityName&APPID=$apiKey&units=metric');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
//pass jsonBody and return what needed from it through weatherModel
      WeatherModel weather = WeatherModel.fromJson(data);
      return weather;
    }
    else{
      throw Exception(" ${response.reasonPhrase}   ");
    }
  }
}