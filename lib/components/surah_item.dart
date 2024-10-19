
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_app/model/surah_model.dart';
//import 'package:pizza_app/model/surah_model.dart';
import 'package:pizza_app/purobaida/surah_provider.dart';
import 'package:pizza_app/screens/details_surah.dart';
import 'package:pizza_app/screens/globals.dart';
import 'package:provider/provider.dart';

class SurahItem extends StatelessWidget {
  final SurahModel surahModel;
  final BuildContext context;
  SurahItem({super.key, required this.surahModel, required this.context});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {


        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsSurah(surahModel: surahModel)));

        Provider.of<SurahProvider>(context, listen: false)
            .selectSurah(surahModel);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
             Stack(
              children: [
                SvgPicture.asset(
                'assets/svg/njma.svg',),
                SizedBox(
                  height: 36, 
                  width: 36, 
                  child: Center(
                    child: Text(
                    surahModel.nomor.toString(),
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                    ),
                    ),
                  ),
                ) 
              ],
             ),
            SizedBox(width: 16,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                   surahModel.namaLatin, // Replace with your title
                   style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                   ),
                   ),
                   SizedBox(height: 4,),
                   Row(
                     children: [
                      Text(
                       surahModel.tempatTurun.name.toUpperCase(), // Replace with your subtitle
                       style: GoogleFonts.poppins(
                         color: text,
                         fontSize: 12,
                         ),
                       ),
                       Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        height: 4, 
                        width: 4,
                        decoration: BoxDecoration(
                          color: Color(0xffBBC4CE).withOpacity(.35),
                          borderRadius: BorderRadius.circular(2) 
                        ),
                        ),
                       Text(
                       surahModel.jumlahAyat.toString() + ' VERSES', // Replace with your subtitle
                       style: GoogleFonts.poppins(
                         color: text,
                         fontSize: 12,
                         ),
                       ),
                     ],
                   ),
               ],),
              ),
              Text(
              surahModel.nama,
              style: GoogleFonts.amiri(
                color: primary,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
        
      ),
    );
  }
}