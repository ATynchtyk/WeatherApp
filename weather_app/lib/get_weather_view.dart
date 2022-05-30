import 'package:flutter/material.dart';

import 'App_Constants/app_text_styles.dart';

class GetWeatherView extends StatefulWidget {
  @override
  _GetWeatherViewState createState() => _GetWeatherViewState();
}

class _GetWeatherViewState extends State<GetWeatherView> {
  String cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/weather.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: AppTextStyles.kTextFieldInputDecoration,
                  onChanged: (value) {
                    print('value: $value');
                    cityName = value;
                    print('cityname: $cityName');
                  },
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, cityName);
                },
                child: const Text(
                  'ИЗДЕ',
                  style: AppTextStyles.kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
