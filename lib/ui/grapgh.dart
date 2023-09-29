import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/api.dart';

class GraphScreen extends StatefulWidget {
  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  final List<Feature> features = [
    Feature(
      title: "Temperature",
      color: Colors.blue,
      data: [0.2, 0.3, 0.4, 0.4, 0.3, 0.3,0.4],
    ),
   
  ];

  @override
  Widget build(BuildContext context) {
    final weatherobj = Provider.of<WeatherScreen>(context);
  String iconcode = weatherobj.data!.weather[0].icon;
  String iconurl = "http://openweathermap.org/img/w/" + iconcode + ".png";
    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: AppBar(
        title: Text("Flutter Draw Graph Demo"),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Image.network(iconurl),

           // NetworkImage(),


          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 64.0),
                child: Text(
                  "Weather Forecast",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
              
              LineGraph(
                features: features,
                size: Size(420, 450),
                labelX: ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6','Day 7'],
                labelY: ['20', '25', '30', '35', '40', '45','50'],
                showDescription: true,
                graphColor: Colors.black87,
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ],
      ),
    );
  }
}