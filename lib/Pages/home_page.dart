import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import '../constants/constants.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  WeatherModel? weatherData;
  TextEditingController city = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    weatherData =
        BlocProvider.of<WeatherCubit>(context, listen: true).varWeatherData;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor:BlocProvider.of<WeatherCubit>(context).varWeatherData==null? Colors.blue : BlocProvider.of<WeatherCubit>(context).varWeatherData!.getTheme(),
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 65,
          title: SizedBox(
            height:65,
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10
                ),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'field is required';
                    }
                    return null;
                  },
                  controller: city,
                  onFieldSubmitted:(city)=>fun(context),
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: IconButton(
                        onPressed: () => fun(context),
                        icon: const Icon(Icons.search),
                      ),
                      hintText: 'Search a city',
                      border: const OutlineInputBorder()),
                ),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<WeatherCubit,WeatherState>(builder: (BuildContext context, state) {
        if(state is WeatherLoading){
          return const Center(child:  CircularProgressIndicator(),);
        }
        else if (state is WeatherSuccess){
         return Container(
            height: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  weatherData!.getTheme(),
                  weatherData!.getTheme().shade200,
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              color: weatherData!.getTheme(),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.02,
                  ),
                  Text(
                    weatherData!.title,
                    style: textStyle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.access_time),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "last updated on ${DateFormat.jm().format(DateTime.now()).toString()}",
                      ),
                    ],
                  ),
                  Padding(
                    padding:  EdgeInsets.only(
                      left: MediaQuery.of(context).size.width*0.02,
                      right:MediaQuery.of(context).size.width*0.02,
                      top: 40,
                      bottom: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.network('http://openweathermap.org/img/wn/${weatherData!.icon}@2x.png',
                          color: Colors.white,
                        ),
                        Text(
                          "${weatherData!.temp.floor()}°",
                          style: textStyle,
                        ),
                        Column(
                          children: [
                            Text(
                              "min = ${weatherData!.minTemp.floor()} ℃",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "max = ${weatherData!.maxTemp.floor()} ℃",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text(
                    weatherData!.weatherDescription,
                    style: textStyle,
                  ),
                ],
              ),
            ),
          );
        }
        else if (state is WeatherFailure){
          return  Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text("ⓧ", style:  TextStyle(fontSize: 100, color: Colors.red)),
                  const SizedBox(height: 10,),
                  const Text("Something went wrong", style:  TextStyle(fontSize: 25,//fontWeight:FontWeight.bold
       )
        ),
                  const SizedBox(height: 20,),
                  Text("${state.error} ", style: const TextStyle(fontSize: 15,color: Colors.grey)),
                ],
              ),
            ),
          );
        }
        else{
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(' there is no weather 😔',
                    style: TextStyle(fontSize: 25)),
                SizedBox(
                  height: 8,
                ),
                Text('start searching now 🔍',
                    style: TextStyle(fontSize: 25))
              ],
            ),
          ) ;
        }
      },)
    );

  }
  fun(context){
    if(formKey.currentState!.validate())
    {
      BlocProvider.of<WeatherCubit>(context, listen: false).weatherData(city.text);
    }
  }
}
