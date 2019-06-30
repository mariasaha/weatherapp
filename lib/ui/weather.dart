import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import '../util/utils.dart' as util;
import 'package:http/http.dart' as http;

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {

  void showStuff() async {
    Map data = await getWeather(util.appID, util.defaultCity);
    print(data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Weather App'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.menu),
              onPressed: showStuff
          )
        ],
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: Image.asset('images/umbrellas.jpg',
              width: 490.0,
              height: 1200.0,
              fit: BoxFit.fill,
            ),
          ),
          new Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.fromLTRB(0.0, 10.9, 20.9, 0.0),
            child: Text('Spokane',
              style: cityStyle(),),
          ),
          new Container(
            alignment: Alignment.center,
            child: Image.asset('images/light_rain.png'),
          ),
          new Container(
            margin: const EdgeInsets.fromLTRB(30.0, 20.0, 0.0, 0.0),
            child: Text('67.9F',
                style: tempStyle()),
          )
        ],
      ),
    );
  }

  Future<Map> getWeather(String appId, String city) async {
    String apiUrl = "http://api.openweathermap.org/data/2.5/weather?q=$city&appid=${util.appID}&units=imperial";

    http.Response response = await http.get(apiUrl);

    return json.decode(response.body);
  }
}

TextStyle cityStyle() {
  return new TextStyle(
    color: Colors.black,
    fontSize: 22.9,
    fontStyle: FontStyle.italic
  );
}
TextStyle tempStyle() {
  return new TextStyle(
    color: Colors.black,
    fontSize: 49.9,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
  );
}