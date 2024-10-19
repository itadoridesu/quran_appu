import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pizza_app/purobaida/audio_state_provider.dart';
import 'package:pizza_app/purobaida/surah_provider.dart';
import 'package:pizza_app/screens/home_screen.dart';
import 'package:pizza_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SurahProvider()),
        ChangeNotifierProvider(create: (_) => AudioStateProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: {
          '/splash_screen' : (context) => SplashScreen(),
          '/home_screen' : (context) => HomeScreen(),
        },
        
        ),
    );
  }
}
