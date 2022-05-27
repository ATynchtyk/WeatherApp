import 'dart:developer';

import 'package:flutter/material.dart';

class CityPage extends StatelessWidget {
  CityPage({Key key}) : super(key: key);

final  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Шаар аркылуу табуу'.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/weather.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children:  [
            const SizedBox(
              height: 200.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _textEditingController,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
                obscureText: false,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 3.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        )),
                    // hintText: 'ШААРДЫН АТЫН ЖАЗ',
                    // labelStyle: TextStyle(color: Colors.white),
                    hintText: 'ШААРДЫН АТЫН ЖАЗ',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 25.0),
                    fillColor: Colors.white),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            OutlinedButton(
              onPressed: () {
                log('_textEditingController ====> ${_textEditingController.text}');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 81, 83, 81),
                ),
              ),
           child:  const Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 80),
                child: Text(
                  'ИЗДЕ',
                  style: TextStyle(color: Colors.white, fontSize: 30.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
