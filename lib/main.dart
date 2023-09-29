import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/api.dart';
import 'package:weatherapp/sharedpref/nightshared.dart';
import 'package:weatherapp/ui/ui.dart';


Future<void> main() async {
    await dotenv.load();

  runApp( MyApp());
}
class MyApp extends StatefulWidget {
   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
//  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

//   @override
//   void initState() {
//     super.initState();
//     getCurrentAppTheme();
//   }

  // void getCurrentAppTheme() async {
  //   themeChangeProvider.darkTheme =
  //       await themeChangeProvider.darkThemePreference.getTheme();
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (context) => WeatherScreen(),),
         ChangeNotifierProvider(create: (context) => DarkThemePreference())
      ],
     child: MaterialApp(
       debugShowCheckedModeBanner: false,
       //theme: Styles.themeData(themeChangeProvider.darkTheme, context),
       home: HomePage(),
     ),
  );
  }}