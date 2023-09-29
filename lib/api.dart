import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/wheather_model.dart';

class WeatherScreen extends ChangeNotifier {
  String apiKey = dotenv.env['API_KEY'].toString();
  // String cityi = '';
  String weatherDescription = '';
  double temperature = 0.0;
  int? time;
  String country = '';
  double windspeed = 0;
  int humidity = 0;
  double? chanceOfRain = 10;
  String location = '';
  double? latitude;
  double? longitude;
  Welcome? data;
 String mydate = DateFormat('EEE, M/d/y hh:mm a').format(DateTime.now());
 
 String todaydate = DateFormat('EEE, M/d/y').format(DateTime.now());
  bool activeConnection = false;
 //static icon_url = "http://openweathermap.org/img/w/" + jsonDecode["weather"]["icon"] +".png";
  check(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String olddate = prefs.getString('date') ?? '';
    String olddataString = prefs.getString('weatherData') ?? '';
    if (olddate == todaydate || olddataString.isNotEmpty) {
      data = welcomeFromMap(((json.decode(olddataString))));
     // print(olddataString);
      notifyListeners();
    } else {
      await CheckUserConnection();
      if (activeConnection == true) {
        print('called');
        getCurrentLocation(context);
        print('object');
        notifyListeners();
      }
    }
  }
  Future CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        activeConnection = true;
      }
    } on SocketException catch (_) {
      activeConnection = false;
    }
    notifyListeners();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  getCurrentTime(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mydate = DateFormat('EEE, d/M/y hh:mm a').format(DateTime.now());
    String olddate = prefs.getString('date') ?? '';
    if (olddate == todaydate) {
      check(context);
      notifyListeners();
    }

    notifyListeners();
}
  Future<void> handleLocationPermission(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();

    
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location permissions are denied')),
        );
      }
    if (permission == LocationPermission.deniedForever) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Permission Denied'),
          content: Text(
              'Location permissions are permanently denied. You can change this in app settings.'),
          actions: [
            TextButton(
              onPressed: () {
                openAppSettings();
                // Open app settings here
              },
              child: Text('Open Settings'),
            ),
          ],
        ),
      );
    }
    return getCurrentLocation(context);
  }

  Future<void> getCurrentLocation(context) async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    latitude = position.latitude;
    longitude = position.longitude;

    if (latitude != null && longitude != null) {
      await fetchWeather(latitude: latitude!, longitude: longitude!);

      notifyListeners();
    }
  }

  Future<void> fetchWeather(
      {required double latitude, required double longitude}) async {
    final response = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric',
      ),
    );
   SharedPreferences prefs = await SharedPreferences.getInstance();

     if (response.statusCode == 200) {
      data = welcomeFromMap(response.body);
      await prefs.setString('date', todaydate);

      Map<String, dynamic> datastring = jsonDecode(welcomeToMap(data!));
      final weatherEncode = jsonEncode(datastring);
      prefs.setString('weatherData', json.encode(weatherEncode));
      notifyListeners();
    } else {
      print('Failed to fetch weather data');
      notifyListeners();
    }

  }

  Future<void> apicall({required String name}) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$name,&appid=$apiKey&units=metric'));
    print(response.body);
   SharedPreferences prefs = await SharedPreferences.getInstance();

    if (response.statusCode == 200) {
       data = welcomeFromMap(response.body);
       print(data);
      await prefs.setString('date', todaydate);

      Map<String, dynamic> datastring = jsonDecode(welcomeToMap(data!));
      final weatherEncode = jsonEncode(datastring);
      print(weatherEncode);
      prefs.setString('weatherData', weatherEncode);
      notifyListeners();
    } else {
      print('Failed to fetch weather data');
    }
  }
}
