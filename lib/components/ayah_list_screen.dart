import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_app/model/ayah_model.dart';
import 'package:pizza_app/screens/globals.dart';

class AyahListScreen extends StatelessWidget {
  final List<AyahModel> storedAyahs;
  final String titre;

  const AyahListScreen(this.storedAyahs, this.titre,{super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GestureDetector(onTap: () => Navigator.pop(context) ,child: SvgPicture.asset('assets/svg/sahm.svg')),
        ),
        title: Text(titre, style: GoogleFonts.poppins(color: text, fontSize: 22)),
        backgroundColor: background, // Customize as needed
      ),
      body: storedAyahs.isEmpty
          ? Center(
              child: Text('No stored Ayahs found.',
                  style: GoogleFonts.poppins(fontSize: 18, color: text)),
            )
          : ListView.separated(
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Divider(thickness: 1, color: primary.withOpacity(.5),),
              ),
              itemCount: storedAyahs.length,
              itemBuilder: (context, index) {
                final ayah = storedAyahs[index];
                return GestureDetector(
                  onTap: () {
                    // Handle the tap if needed, e.g., play audio or show details
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: background.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Display Ayah number and Surah name
                        Text(
                          '${ayah.surahNo}:${ayah.ayahNo}',
                          style: GoogleFonts.poppins(
                            color: primary.withOpacity(.9),
                            fontSize: 14,
                          ),
                        ),
                        // Arabic text aligned to the right
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            ayah.arabic1,
                            style: GoogleFonts.amiri(
                              color: Colors.white.withOpacity(.9),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        SizedBox(height: 15),
                        // English text aligned to the left
                        Text(
                          ayah.english,
                          style: GoogleFonts.poppins(
                            color: text,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
