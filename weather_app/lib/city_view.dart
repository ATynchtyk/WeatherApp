import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weather_app/App_Constants/app_text_styles.dart';
import 'package:weather_app/city_view_model.dart';
import 'package:weather_app/get_weather_view.dart';
import 'package:weather_app/progress_indicator.dart';



//Flutter StatefulWidget lifecycle
class CityView extends StatefulWidget {
  const CityView({Key key}) : super(key: key);

  @override
  _CityViewState createState() => _CityViewState();
}

class _CityViewState extends State<CityView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cityNameController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    getLocationAndWeather();
  }

  getLocationAndWeather() async {
    setState(() {
      isLoading = true;
    });

    await cityViewModel.getLocationAndWeather();

    setState(() {
      isLoading = false;
    });
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
                onChanged: (String danniy) {
               
                },
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
                  Navigator.of(context).pop(); //Dialogtu jap
          
                }
               
              },
            ),
          ],
        );
      },
    );
  }

  // @override
  // void dispose() {
 
  //   print('dispose');
  //   super.dispose();
  // }

  // @override
  // void deactivate() {
   
  //   print('deactivate');
  //   super.deactivate();
  // }

 
  @override
  Widget build(BuildContext context) {
  

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

                              await cityViewModel.getLocationAndWeather();

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

                              if (_cityNameFromCityPage != null) {
                                setState(() {
                                  isLoading = true;
                                });

                                await cityViewModel.getWeatherByCityname(
                                    _cityNameFromCityPage);

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
                              cityViewModel.getWeatherModel.celcius.toString(),
                              style: AppTextStyles.kTempTextStyle,
                            ),

                            Text (
                              '${cityViewModel.getWeatherModel.icon}',
                              style: AppTextStyles.kConditionTextStyle,
                            ), //Model mn ishtoo
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 15.0),
                        child: Text(
                          '${cityViewModel.getWeatherModel.message}',
                          textAlign: TextAlign.right,
                          style: AppTextStyles.kMessageTextStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${cityViewModel.getWeatherModel.cityName}',
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


//OOP Object Oriented Programming language

//Model 
//Class