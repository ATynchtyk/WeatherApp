import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/App_Constants/app_text_styles.dart';
import 'package:weather_app/App_Constants/weather_service.dart';
import 'package:weather_app/get_weather_view.dart';
import 'package:weather_app/location_service.dart';
import 'package:weather_app/progress_indicator.dart';

class CityUiWithNoModel extends StatefulWidget {
  const CityUiWithNoModel({Key key}) : super(key: key);

  @override
  _CityUiWithNoModelState createState() => _CityUiWithNoModelState();
}

class _CityUiWithNoModelState extends State<CityUiWithNoModel> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cityNameController = TextEditingController();
  Position _position;

  bool isLoading = false;
  Map<String, dynamic> _data;
  int _tempCelcius = 0;
  String _cityName = 'Bishkek';
  String weatherIcon;
  String weatherMessage;

  @override
  void initState() {
    super.initState();
    print('initState');
    getLocation();
  }

  getLocation() async {
    setState(() {
      isLoading = true;
    });
    final _position = await LocationService().getCurrentLocation();
    _data = await weatherService.getWeatherByLocation(_position);

    double kelvin = _data['main']['temp'];

    _cityName = _data['name'];
    _tempCelcius = (kelvin - 273.15).round();

    print('_dataByLoc: ${_data['name']}');

    setState(() {
      isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    print('didChangeDependencies');
  }

  void showSnackbar() {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: const Text('snack'),
      duration: const Duration(seconds: 1),
      action: SnackBarAction(
        label: 'ACTION',
        onPressed: () {},
      ),
    ));
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Write your city'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: TextFormField(
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Required field';
                  } else {
                    return null;
                  }
                },
                onChanged: (String danniy) {},
                controller: _cityNameController,
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                print(
                    '_cityNameController.text before validate: ${_cityNameController.text}');
                if (_formKey.currentState.validate()) {
                  print(
                      '_cityNameController.text after validate: ${_cityNameController.text}');
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }

  @override
  void deactivate() {
    print('deactivate');
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    print('build');

    return Scaffold(
      body: Scaffold(
        key: scaffoldKey,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/images/weather.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop),
            ),
          ),
          constraints: const BoxConstraints.expand(),
          child: isLoading
              ? circularProgress()
              : SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });

                              final Position _pos =
                                  await locationService.getCurrentLocation();
                              _data = await weatherService
                                  .getWeatherByLocation(_pos);

                              _cityName = _data['name'];
                              double kelvin = _data['main']['temp'];
                              _tempCelcius = (kelvin - 273.15).round();

                              setState(() {
                                isLoading = false;
                              });
                            },
                            child: const Icon(
                              Icons.near_me,
                              size: 50.0,
                            ),
                          ),
                          FlatButton(
                            onPressed: () async {
                              final _cityNameFromCityPage =
                                  await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return GetWeatherView();
                                  },
                                ),
                              );

                              print(
                                  '_cityNameFromCityPage: ${_cityNameFromCityPage.runtimeType}');

                              if (_cityNameFromCityPage != null) {
                                setState(() {
                                  isLoading = true;
                                });
                                _data =
                                    await weatherService.getWeatherByCityName(
                                        _cityNameFromCityPage);

                                _cityName = _data['name'];
                                double kelvin = _data['main']['temp'];
                                _tempCelcius = (kelvin - 273.15).round();

                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                            child: const Icon(
                              Icons.location_city,
                              size: 50.0,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              _tempCelcius.toString(),
                              style: AppTextStyles.kTempTextStyle,
                            ),
                            const Text(
                              '☀️',
                              style: AppTextStyles.kConditionTextStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Text(
                          'bugun jamgyr jaayt $_cityName',
                          textAlign: TextAlign.right,
                          style: AppTextStyles.kMessageTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}





