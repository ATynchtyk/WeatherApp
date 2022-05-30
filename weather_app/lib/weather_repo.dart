import 'package:geolocator/geolocator.dart';
import 'package:weather_app/App_Constants/weather_service.dart';
import 'package:weather_app/weather_model.dart';


class WeatherRepo {
  Future<WeatherModel> getWeatherByLocation(Position position) async {
    final _data = await weatherService.getWeatherByLocation(position);
    return WeatherModel.fromJson(_data);
  }

  Future<WeatherModel> getWeatherByCityName(String city) async {
    final _data = await weatherService.getWeatherByCityName(city);

    return WeatherModel.fromJson(_data);
  }
}

final WeatherRepo weatherRepo = WeatherRepo();
