import 'package:flutter/material.dart';
class WeatherModel {
  String title;

  double minTemp;

  double maxTemp;

  double temp;

  String condition;

  String weatherDescription;

  String icon;

  WeatherModel({
    required this.icon,
    required this.weatherDescription,
    required this.title,
    required this.temp,
    required this.maxTemp,
    required this.minTemp,
    required this.condition,
  });

  factory WeatherModel.fromJson(dynamic data){
    var main = data["main"];
    var weather = data["weather"][0];
    return WeatherModel(
      icon: weather["icon"],
      weatherDescription: weather["description"],
      title: data["name"],
      temp: main["temp"],
      minTemp: main["temp_min"],
      maxTemp: main["temp_max"],
      condition: weather["main"],

    );
  }

  @override
  String toString() {
    return 'title =$title temp=$temp maxTemp=$maxTemp minTemp=$minTemp condition=$condition';
  }

  MaterialColor getTheme() {
    if (condition == 'Clear') {
      return Colors.amber;
    } else if (condition == 'Clouds') {
      return Colors.blueGrey;
    } else if (condition == 'Drizzle' || condition == 'Rain') {
      return Colors.indigo;
    } else if (condition == 'Thunderstorm') {
      return Colors.deepPurple;
    } else if (condition == 'Snow') {
      return Colors.grey;
    } else {
      return Colors.lime;
    }
  }
}
