import 'package:geolocator/geolocator.dart';
import 'package:weather_app/location_service.dart';


class LocationRepo {
  Future<Position> getCurrentLocation() async {
    return await locationService.getCurrentLocation();
  }
}

final LocationRepo locationRepo = LocationRepo();
