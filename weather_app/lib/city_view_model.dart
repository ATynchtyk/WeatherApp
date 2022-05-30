
import 'package:weather_app/location_repo.dart';
import 'package:weather_app/weather_model.dart';
import 'package:weather_app/weather_repo.dart';

class CityViewModel {
  WeatherModel _weatherModel;
  WeatherModel get getWeatherModel => _weatherModel;

  getLocationAndWeather() async {
    final _position = await locationRepo.getCurrentLocation();
    _weatherModel = await weatherRepo.getWeatherByLocation(_position);
  }

  getWeatherByCityname(String cityName) async {
    _weatherModel = await weatherRepo.getWeatherByCityName(cityName);
  }
}

final CityViewModel cityViewModel = CityViewModel();
