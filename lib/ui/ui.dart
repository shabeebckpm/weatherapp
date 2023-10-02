
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/api.dart';
import 'package:weatherapp/sharedpref/nightshared.dart';

import 'grapgh.dart';
// ignore: must_be_immutable
class HomePage extends StatefulWidget {
   HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
 
  bool mylight=true;
  bool mysecondlight=false;

int flag=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final weatherobj = Provider.of<WeatherScreen>(context, listen: false);
    Timer.periodic(
        Duration(seconds: 1), (Timer t) => weatherobj.getCurrentTime(context));
    weatherobj.check(context);
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheigt = MediaQuery.of(context).size.height;
    String mydate=DateFormat('EEE, M/d/y hh:mm a').format(DateTime.now());
    final sharedProvider = Provider.of<DarkThemePreference>(context);
    sharedProvider.startTimerToUpdateTheme();
    // sharedProvider.saveValuesToSharedPreferences(context);
    // sharedProvider.loadValuesFromSharedPreferences();
  //sharedProvider.changetheme(mylight: mylight,mysecondlight: mysecondlight);
final weatherobj = Provider.of<WeatherScreen>(context);
  //String iconcode = weatherobj.data!.weather[0].icon;
 // var iconurl = "http://openweathermap.org/img/w/" + iconcode + ".png";
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: sharedProvider.light==true? Color.fromARGB(255, 154, 203, 239):Colors.black,
      //start appbar
      appBar: AppBar(
        
        backgroundColor:sharedProvider.light==true? Color.fromARGB(255, 154, 203, 239):Colors.black,
        elevation: 0,
        actions: [
          Container(
            
            height: screenheigt * 0.1 ,
            width: screenWidth * 0.27 ,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color:sharedProvider.light==true? Color.fromARGB(255, 154, 203, 239):Colors.black,),
            child: Row( 
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    sharedProvider.theme(mylight);

                  },
                  icon: Icon(
                    Icons.sunny,
                    color: Colors.yellow,size: 16,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      sharedProvider.theme(mysecondlight);
                    // themeChange.darkTheme=true;
                    },
                    icon: Icon(
                      Icons.nightlight_round_outlined,
                      color: Colors.white,size: 16
                    )),
              ],
            ),
          ),
         
         ], 
        // centerTitle: true,
         title:
          Container(
            //alignment: Alignment.center,
            //height: screenheigt * 0.1,
            width: screenWidth * 3.5,
            decoration: BoxDecoration(
              
                borderRadius: BorderRadius.circular(30),
                color:sharedProvider.light==true? Color.fromARGB(255, 154, 203, 239):Colors.black,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               IconButton(
                  onPressed: () async {
                    weatherobj.check(context);
                //  sharedProvider.loadValuesFromSharedPreferences();
                  // sharedProvider.saveValuesToSharedPreferences(context);
                //   await value.fetchWeatherData();
                 
                   
                  },
                  icon:Icon(Icons.location_on_outlined,),
                  color: Colors.white,
                ),
                Consumer<WeatherScreen>(
                  builder: (BuildContext context, value, Widget? child) { 
                    return Row(
                      children: [
                        if(value.data!=null)
                    Text(value.data!.name,
                    //overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  IconButton(
                    onPressed: () {
                          TextEditingController city = TextEditingController();
                     
                              showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('write a city'),
                            content: TextField(controller: city),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); //close Dialog
                                },
                                child: Text('Close'),
                              ),
                              TextButton(
                                  onPressed: () {
                                     value.apicall(name: city.text);
                                   //  sharedProvider.loadValuesFromSharedPreferences();
                                   //  sharedProvider.saveValuesToSharedPreferences(context);

                                  Navigator.pop(context); //close Dialog
          
                                  },
                                  child: Text('ok')),
                            ],
                          );
                        });
          
                       
                    },
                    icon: Icon(
                      Icons.arrow_drop_down_outlined,
                      color: Colors.white,
                      size: 25 ,
                    ))

                      ],
                    );
                   },
                ),
              ],
            ),
          
            //  color: Colors.white,
          ),

      leading:   InkWell(
            onTap: () {

              weatherobj.remove();
            },
            child: CircleAvatar(
                backgroundColor: sharedProvider.light==true? Color.fromARGB(255, 154, 203, 239):Colors.black,
                backgroundImage: AssetImage('assets/v.png',),
                radius: 2,
                ),
          ),  
         
          
  
      ),
      //close appbar;

      body: Column(
        children: [
          SizedBox(
            height: screenheigt * 0.015,
          ),
          Center(
            child: Text(
              'Today',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: screenheigt * 0.01,
          ),
          Center(
            child: Text(
            '$mydate',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w300),
              ),
          ),
          SizedBox(
            height: screenheigt * 0.03,
          ),
          Container(
            height: screenheigt * 0.45,
            width: screenWidth * 0.85,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color:sharedProvider.light==true? Color.fromARGB(255, 154, 203, 239):Color.fromARGB(255, 34, 41,46) ,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: screenheigt * 0.0099,
                ),
              SizedBox(
                height: screenheigt*0.20,
                child: getLeadingWidget(weatherobj.weatherDescription)),
                 Consumer<WeatherScreen>(
              builder: (BuildContext context, value, Widget? child) {
                return Column(
                  children: [
                    if(value.data!=null)
                    Text(
                      '${value.data!.weather[0].description}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                    ),
                  if(value.data!=null)
                     Text(
                  '${value.data!.main.temp}°C',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  'H:23° L:7°',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w200),
                ),
                  ],
                );
              }),
                
                 Consumer<WeatherScreen>(
                        builder: (BuildContext context, value, Widget? child) { 
                          return  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                     Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.air_rounded,
                              color: Colors.white,
                            ),
                            if(value.data!=null)
                             Text(
                               '${value.data!.wind.speed} k/h',
                               style: TextStyle(color: Colors.white),
                             ),
                            Text(
                              'wind',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ), 
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.backup_rounded,
                            color: Colors.white,
                          ),
                            if(value.data!=null)
                          Text(
                            '${value.chanceOfRain} %',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Chance Of Rain',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.water_drop_sharp,
                            color: Colors.white,
                          ),
                            if(value.data!=null)
                         Text(
                           '${value.data!.main.humidity} k/h',
                           style: TextStyle(color: Colors.white),
                         ),
                          Text(
                            'Humidity',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ],
                                 );
   } )
                
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: screenWidth*0.01,
              ),
              Text(
                'Today',
                style: TextStyle(color: Colors.yellow),
              ),
              SizedBox(
                width: screenWidth*0.50 , 
              ),
              Text(
                'Next 7 Days',
                style: TextStyle(color: Colors.white),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder:(context) => GraphScreen(),));
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.white,
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Image(
                    image: AssetImage('assets/r3.png'),
                    height: screenheigt * 0.035,
                  ),
                  SizedBox(
                    height: screenheigt * 0.01,
                  ),
                  Text(
                    '21°',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              Column(
                children: [
                  Image(
                    image: AssetImage('assets/r3.png'),
                    height: screenheigt * 0.035,
                  ),
                  SizedBox(
                    height: screenheigt * 0.01,
                  ),
                  Text(
                    '20°',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              Column(
                children: [
                  Image(
                    image: AssetImage('assets/h2.png'),
                    height: screenheigt * 0.044,
                  ),
                  SizedBox(
                    height: screenheigt * 0.01,
                  ),
                  Text(
                    '22°',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              Column(
                children: [
                  Image(
                    image: AssetImage('assets/s2.webp'),
                    height: screenheigt * 0.035,
                  ),
                  SizedBox(
                    height: screenheigt * 0.01,
                  ),
                  Text(
                    '23°',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ],
          ),


          
        ],
      ),

      
    );
    
  }
  Widget getLeadingWidget(String category) {
  switch (category) {
    case 'overcast clouds':
      return Image.asset('assets/overcast.png',);
    case 'scattered clouds':
      return Image.asset('assets/scattered.png',);
    case 'clear sky':
      return Image.asset('assets/sun.png');
    case 'haze':
      return Image.asset('assets/haze.png');
    case 'few clouds':
      return Image.asset('assets/d.webp');
    case 'broken clouds':
      return Image.asset('assets/d.webp');
    case 'moderate rain':
      return Image.asset('assets/cloudy.png');
    case 'light rain':
      return Image.asset('assets/light.png');
    case 'light intensity shower rain':
      return Image.asset('assets/light.png');
    case 'drizzle':
      return Image.asset('assets/drizzle.png');
    case 'heavy intensity rain':
      return Image.asset('assets/heavy-rain.png');
    default:
      return Image.asset('assets/s2.webp');
}

  }
  }
  