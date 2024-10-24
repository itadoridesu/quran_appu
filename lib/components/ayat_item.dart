import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_app/model/ayah_model.dart';
import 'package:pizza_app/purobaida/audio_state_provider.dart';
import 'package:pizza_app/purobaida/surah_provider.dart';
import 'package:pizza_app/screens/globals.dart';
import 'package:provider/provider.dart';

class AyatItem extends StatelessWidget {
  final AyahModel ayahModel;
  const AyatItem({super.key, required this.ayahModel});
  

  @override
  Widget build(BuildContext context) {

    final audioState = Provider.of<AudioStateProvider>(context);
    final surahProvider = Provider.of<SurahProvider>(context);
    
    return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end, 
      children: [
        Container(
          height: 47,
          decoration: BoxDecoration(
            color: secondPrimary,  // Light grey background
            borderRadius: BorderRadius.circular(10),  // Rounded corners
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 13,),
              Container(
                height: 27,
                width: 27,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primary,  // Example color for number background
                ),
                alignment: Alignment.center,
                child: Text(
                  ayahModel.ayahNo.toString(),  // Replace with Ayah number later
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14
                  ),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      
                      surahProvider.updateLastReadAyah(ayahModel.ayahNo);
                      
                      final ayahKey = '${ayahModel.surahNo}_${ayahModel.ayahNo}'; // Create a unique key for this Ayah

                      if (audioState.isPlaying && audioState.activeAyah == ayahKey) {
                        audioState.stopAudio();
                      } else {
                        // Use the key to access the audio URL
                        final audioUrl = ayahModel.audio['1']?.url ?? '';
                   
                        if (audioUrl.isNotEmpty) {
                          audioState.playAudio(audioUrl, ayahKey); // Pass the unique key for this Ayah
                          
                        } else {
                          print("Audio URL is empty");
                        }
                      }
                    },
                    icon: audioState.isPlaying && audioState.activeAyah == '${ayahModel.surahNo}_${ayahModel.ayahNo}'
                        ? Icon(Icons.pause, color: primary, size: 24)
                        : SvgPicture.asset('assets/svg/play.svg'),
                   ),
                  IconButton(onPressed: () {}, icon: SvgPicture.asset('assets/svg/share.svg')),
                  IconButton(onPressed: () {}, icon: SvgPicture.asset('assets/svg/seivu.svg')),
                ],
              ),  // First icon
            ],
          ),
        ),
        const SizedBox(height: 24),  
        Text(
          ayahModel.arabic1,  
          textAlign: TextAlign.right,  
          style: GoogleFonts.amiri(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
        const SizedBox(height: 16), 
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            ayahModel.english,  
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: text, 
              fontWeight: FontWeight.w400 
            ),
          ),
        ),
        SizedBox(height: 16,),
        ayahModel.ayahNo != ayahModel.totalAyah ? Divider(thickness: 1, color: const Color(0xff7B80AD).withOpacity(.35)) : SizedBox(height :20)
      ],
    ),
          );
  }
}