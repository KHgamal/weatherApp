abstract class WeatherState{}
class InitialState extends WeatherState{}
class WeatherLoading extends WeatherState{}
class WeatherSuccess extends WeatherState{}
class WeatherFailure extends WeatherState{
  final String error;

  WeatherFailure(this.error, );
}

