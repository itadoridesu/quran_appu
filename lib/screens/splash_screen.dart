import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_app/screens/globals.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 86,),
              Text(
                'Quran App',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                )
              ),
              SizedBox(height: 16,),
              Text(
                'Learn Quran\n and Recite once everyday',
                style: GoogleFonts.poppins(
                  color: text,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 48,),
              Stack(
                clipBehavior: Clip.none,
                children: [
                Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                height: 500,
                decoration: BoxDecoration(
                  color: Color(0xff672CBC),
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: SvgPicture.asset(
                    'assets/svg/spurashu.svg',
                    width: double.infinity,
                    fit: BoxFit.fill,
                    ),
                )
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: -23,
                  child: Center(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pushNamed(context, '/home_screen');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        decoration: BoxDecoration(
                          color: orange,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: Text(
                          'Get Started',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                          ),
                          ),
                      ),
                    ),
                  ),
                )
        
                ],
              )      
          ],),
        ),
      ),
    );
  }
}