import 'package:flutter/material.dart';
import 'package:pizza_app/screens/globals.dart';

class LombaScreen extends StatelessWidget {
  const LombaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(child: Center(child: Text('Lomba', style: TextStyle(color: Colors.white,),),)),
    );
  }
}