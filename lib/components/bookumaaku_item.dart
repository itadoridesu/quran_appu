import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_app/components/ayah_list_screen.dart';
import 'package:pizza_app/model/ayah_model.dart';
import 'package:pizza_app/screens/globals.dart';

class BookumaakuItem extends StatelessWidget {
  final String title;
  final List<AyahModel> ayahList;

  const BookumaakuItem({super.key, required this.title, required this.ayahList});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AyahListScreen(ayahList, title),
        ));
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 22),
                  child: SvgPicture.asset('assets/svg/folder.svg'),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      ayahList.length.toString() + ' items',
                      style: GoogleFonts.poppins(
                        color: text,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SvgPicture.asset('assets/svg/suree_points.svg')
          ],
        ),
      ),
    );
  }
}

