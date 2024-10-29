import 'package:flutter/material.dart';
import 'package:pizza_app/screens/globals.dart';

class PurayinguScreen extends StatelessWidget {
  const PurayinguScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(child: Center(child: Text('Purayingu', style: TextStyle(color: Colors.white,),),)),
    );
  }
}