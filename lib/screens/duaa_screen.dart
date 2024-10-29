import 'package:flutter/material.dart';
import 'package:pizza_app/screens/globals.dart';

class DuaaScreen extends StatelessWidget {
  const DuaaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(child: Center(child: Text('Duaa', style: TextStyle(color: Colors.white,), ),)),
    );
  }
}