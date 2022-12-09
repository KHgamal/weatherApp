import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_state.dart';

import '../../models/weather_model.dart';

import '../../services/weather_services.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(InitialState());

  String? cityName;

  //object of class WeatherModel ( because we assigned it to object of class WeatherModel )
  // to access its attributes
  //api response ( map ) is passed to the first object
  //first object is returned through getWeather fun which make getWeather of type WeatherModel
  WeatherModel? varWeatherData;

  void weatherData(city) async {
    emit(WeatherLoading());
    cityName = city;
    //object to access fun
    WeatherServices service = WeatherServices();
    //fun itself has type WeatherModel cause it returns object of that class
    //that  means the class that contains the fun has different type from it
    try {
      varWeatherData = await service.getWeather(cityName: cityName);
      emit(WeatherSuccess());
    }
   catch(e){
      //rint("________________________${e['message']}__________________");

      emit(WeatherFailure(e.toString()));
    }
  }
}
