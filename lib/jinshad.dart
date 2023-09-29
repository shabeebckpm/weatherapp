// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// // import 'package:weatherapp/api.dart';
// // import 'package:weatherapp/sharedpref/nightshared.dart';

// import 'api.dart';
// import 'grapgh.dart';
// import 'nightshared.dart';

// // ignore: must_be_immutable
// class HomePage extends StatefulWidget {
//   HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   bool mylight = true;
//   bool mysecondlight = false;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     final weatherobj = Provider.of<Fech>(context, listen: false);
//     Timer.periodic(
//         Duration(seconds: 1), (Timer t) => weatherobj.getCurrentTime());
//     weatherobj.check();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenheigt = MediaQuery.of(context).size.height;

//     final sharedProvider = Provider.of<ThemeProvider>(
//       context,
//     );

//     final weatherobj = Provider.of<Fech>(
//       context,
//     );

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: sharedProvider.light1 == true
//           ? Color.fromARGB(255, 21, 51, 121)
//           : Colors.black,
//       //start appbar
//       appBar: AppBar(
//         backgroundColor: sharedProvider.light1 == true
//             ? Color.fromARGB(255, 21, 51, 121)
//             : Colors.black,
//         elevation: 0,
//         actions: [
//           Switch(
//             thumbIcon: MaterialStatePropertyAll(sharedProvider.light1 == true
//                 ? Icon(
//                     Icons.nightlight,
//                     color: Colors.amber,
//                   )
//                 : Icon(
//                     Icons.sunny,
//                     color: Colors.amber,
//                   )),
//             activeTrackColor: Colors.blue,
//             inactiveTrackColor: const Color.fromARGB(255, 16, 25, 37),
//             value: sharedProvider.light1,
//             onChanged: (bool value) {
//               sharedProvider.theme(value);
//             },
//           ),
//         ],
//         // centerTitle: true,
//         title: Container(
//           //alignment: Alignment.center,
//           //height: screenheigt * 0.1,
//           width: screenWidth * 3.5,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             color: sharedProvider.light1 == true
//                 ? Color.fromARGB(255, 21, 51, 121)
//                 : Colors.black,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   final locationProvider =
//                       Provider.of<Fech>(context, listen: false);
//                   locationProvider.getCurrentLocation();
//                 },
//                 icon: Icon(
//                   Icons.location_on_outlined,
//                 ),
//                 color: Colors.white,
//               ),
//               Consumer<Fech>(
//                 builder: (BuildContext context, value, Widget? child) {
//                   return Text(
//                     '${value.data?.name}',
//                     //overflow: TextOverflow.ellipsis,
//                     style: TextStyle(color: Colors.white, fontSize: 14),
//                   );
//                 },
//               ),
//             ],
//           ),

//           //  color: Colors.white,
//         ),
//         leading: CircleAvatar(
//           backgroundColor: Colors.transparent,
//           backgroundImage: AssetImage(
//             'assets/v.png',
//           ),
//         ),
//       ),
//       //close appbar;

//       body: Column(
//         children: [
//           SizedBox(
//             height: screenheigt * 0.015,
//           ),
//           Center(
//             child: Text(
//               'Today',
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 30,
//                   fontWeight: FontWeight.w600),
//             ),
//           ),
//           SizedBox(
//             height: screenheigt * 0.01,
//           ),
//           Center(
//             child: Text(
//               '${weatherobj.current_time}',
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                   fontWeight: FontWeight.w300),
//             ),
//           ),
//           SizedBox(
//             height: screenheigt * 0.03,
//           ),
//           Container(
//             height: screenheigt * 0.45,
//             width: screenWidth * 0.85,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               color: sharedProvider.light1 == true
//                   ? Color.fromARGB(255, 10, 2, 96)
//                   : Color.fromARGB(255, 34, 41, 46),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 SizedBox(
//                   height: screenheigt * 0.0099,
//                 ),
//                 Consumer<Fech>(
//                     builder: (BuildContext context, value, Widget? child) {
//                   return SizedBox(
//                       height: screenheigt * 0.20,
//                       child: value.data != null
//                           ? getLeadingWidget(
//                               weatherobj.data!.weather[0].description)
//                           : Center(child: CircularProgressIndicator()));
//                 }),
//                 Consumer<Fech>(
//                     builder: (BuildContext context, value, Widget? child) {
//                   return Column(
//                     children: [
//                       if (value.data != null)
//                         Text(
//                           '${value.data!.weather[0].description}',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 15,
//                               fontWeight: FontWeight.w300),
//                         ),
//                       if (value.data != null)
//                         Text(
//                           '${value.data!.main.temp}°C',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 45,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       if (value.data != null)
//                         Consumer<Fech>(
//                           builder:
//                               (BuildContext context, value, Widget? child) {
//                             return Text(
//                               'H:${value.data!.main.tempMax}° L:${value.data!.main.tempMin}°',
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.w200),
//                             );
//                           },
//                         ),
//                     ],
//                   );
//                 }),
//                 Consumer<Fech>(
//                     builder: (BuildContext context, value, Widget? child) {
//                   return Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Column(
//                         children: [
//                           Icon(Icons.air, color: Colors.white),
//                           if (value.data != null)
//                             Text(
//                               '${value.data!.wind.speed} k/h',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           Text(
//                             'wind',
//                             style: TextStyle(color: Colors.white),
//                           )
//                         ],
//                       ),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Icon(
//                             Icons.water_drop_sharp,
//                             color: Colors.white,
//                           ),
//                           if (value.data != null)
//                             Text(
//                               '${value.data!.main.humidity}',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           Text(
//                             'humidity',
//                             style: TextStyle(color: Colors.white),
//                           )
//                         ],
//                       ),
//                     ],
//                   );
//                 })
//               ],
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(
//                   // width: screenWidth * 0.01,
//                   ),
//               Text(
//                 'Today',
//                 style: TextStyle(color: Colors.yellow),
//               ),
//               IconButton(
//                 onPressed: () {
//                   setState(() {
//                     weatherobj.remove();
//                   });
//                 },
//                 icon: Icon(Icons.refresh, color: Colors.amber),
//               ),
//               Row(
//                 children: [
//                   Text(
//                     'Next 7 Days',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   IconButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => GraphScreen(),
//                             ));
//                       },
//                       icon: Icon(
//                         Icons.arrow_forward_ios_outlined,
//                         color: Colors.white,
//                       )),
//                 ],
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Column(
//                 children: [
//                   Image(
//                     image: AssetImage('assets/r3.png'),
//                     height: screenheigt * 0.035,
//                   ),
//                   SizedBox(
//                     height: screenheigt * 0.01,
//                   ),
//                   Text(
//                     '21°',
//                     style: TextStyle(color: Colors.white),
//                   )
//                 ],
//               ),
//               Column(
//                 children: [
//                   Image(
//                     image: AssetImage('assets/r3.png'),
//                     height: screenheigt * 0.035,
//                   ),
//                   SizedBox(
//                     height: screenheigt * 0.01,
//                   ),
//                   Text(
//                     '20°',
//                     style: TextStyle(color: Colors.white),
//                   )
//                 ],
//               ),
//               Column(
//                 children: [
//                   Image(
//                     image: AssetImage('assets/h2.png'),
//                     height: screenheigt * 0.044,
//                   ),
//                   SizedBox(
//                     height: screenheigt * 0.01,
//                   ),
//                   Text(
//                     '22°',
//                     style: TextStyle(color: Colors.white),
//                   )
//                 ],
//               ),
//               Column(
//                 children: [
//                   Image(
//                     image: AssetImage('assets/s2.webp'),
//                     height: screenheigt * 0.035,
//                   ),
//                   SizedBox(
//                     height: screenheigt * 0.01,
//                   ),
//                   Text(
//                     '23°',
//                     style: TextStyle(color: Colors.white),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget getLeadingWidget(String category) {
//     switch (category) {
//       case 'overcast clouds':
//         return Image.asset(
//           'assets/overcast.png',
//         );
//       case 'scattered clouds':
//         return Image.asset(
//           'assets/scattered.png',
//         );
//       case 'clear sky':
//         return Image.asset('assets/sun.png');
//       case 'haze':
//         return Image.asset('assets/haze.png');
//       case 'few clouds':
//         return Image.asset('assets/d.webp');
//       case 'broken clouds':
//         return Image.asset('assets/d.webp');
//       case 'moderate rain':
//         return Image.asset('assets/cloudy.png');
//       case 'light rain':
//         return Image.asset('assets/light.png');
//       case 'light intensity shower rain':
//         return Image.asset('assets/light.png');
//       case 'drizzle':
//         return Image.asset('assets/drizzle.png');
//       case 'heavy intensity rain':
//         return Image.asset('assets/heavy-rain.png');
//       default:
//         return Image.asset('assets/s2.webp');
//     }
//   }
// }