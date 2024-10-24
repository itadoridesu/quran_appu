import 'package:flutter/material.dart';
import 'package:pizza_app/screens/globals.dart';

class SeivuScreen extends StatelessWidget {
  const SeivuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(child: Center(child: Text('data'),)),
    );
  }
}