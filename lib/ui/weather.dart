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
            child: updateTempWidget("Manhattan"),
                //style: tempStyle()),
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
  Widget updateTempWidget(String city) {
    return FutureBuilder(
      future: getWeather(util.appID, city),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        //below is the stuff from the response.body we got above.
        if (snapshot.hasData){
          Map content = snapshot.data;
        return Container(
          child: Column(
            children: <Widget>[
              new ListTile(
                title: new Text(content['main']['temp'].toString(),
                  style: new TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 49.9,
                  color: Colors.black,
                  fontWeight: FontWeight.w500
                ),),
              )
            ],
          )
        );
    }else {
          return Container();
        }
  });
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
//END
}