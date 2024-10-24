import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_app/purobaida/surah_provider.dart';
import 'package:pizza_app/screens/globals.dart';
import 'package:pizza_app/search%20hehe/surah_search_delegate.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    
    final surahProvider = Provider.of<SurahProvider>(context);

    return AppBar(
      elevation: 0,
      backgroundColor: background,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/svg/durawa.svg')),
              SizedBox(
                width: 20,
              ),
              Text(
                title,
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          IconButton(
              onPressed: () {
                 if (title == 'Quran App') {
                // Perform Surah search when the title matches
                showSearch(
                  context: context,
                  delegate: SurahSearchDelegate(surahProvider.allSurahs), // Pass the list of Surahs
                );
              }
              },
              icon: SvgPicture.asset('assets/svg/search_icon.svg')),
        ],
      ),
    );
  }

  // Implement the preferredSize getter as required by PreferredSizeWidget
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
