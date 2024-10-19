import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_app/components/ayat_item.dart';
import 'package:pizza_app/model/ayah_model.dart';
import 'package:pizza_app/model/surah_model.dart';
import 'package:pizza_app/screens/globals.dart';

class DetailsSurah extends StatelessWidget {
  final SurahModel surahModel;
  DetailsSurah({super.key, required this.surahModel});

  Future<List<AyahModel>> _getAllAyahs() async {
  List<AyahModel> ayahList = [];

  // Create a list of futures for fetching each ayah
  List<Future<AyahModel>> futures = [];

  for (int ayahNo = 1; ayahNo <= surahModel.jumlahAyat; ayahNo++) {
    futures.add(
      Dio().get("https://quranapi.pages.dev/api/${surahModel.nomor}/$ayahNo.json")
        .then((data) {
          var decodedJson = json.decode(data.toString());
          return AyahModel.fromJson(decodedJson);
        })
    );
  }

  // Wait for all futures to complete and gather results
  ayahList = await Future.wait(futures);
  
  return ayahList;
}
 

  // Future<SurahDetailsModel> _getDetailSurah() async {
  //   var data = await Dio().get("https://quranapi.pages.dev/api/${surahModel.nomor}.json");
  //   return SurahDetailsModel.fromJson(json.decode(data.toString()));
  // }

//    Future<AyahModel> getAyahAudio() async {
//    // Fetch data from the API
//    var data = await Dio().get("https://quranapi.pages.dev/api/${surahDetailsModel.surahNo}/${surahDetailsModel.}.json")
//    // Decode the data into a JSON format
//    var decodedJson = json.decode(data.toString())
//    // Extract the audio part and ayah number
//    var audioJson = decodedJson['audio'];
//    var ayahNo = decodedJson['ayahNo'];  // Extract the ayah numbe
//    // Wrap both the audio and ayah number into a map and pass to AudioDesu
//    return AyahModel.fromJson({
//      "audio": audioJson,
//      "ayahNo": ayahNo  // Pass the ayah number to the model
//    });
//  }
  


  
// // Function to fetch audio and play it using the Audioplayers package
// Future<void> playAudio(int surahNo, int ayahNo) async {
//   try {
//     // Fetch the audio data for the specific Ayah using the existing getAyahAudio function
//     AudioDesu audioDesu = await getAyahAudio(ayahNo, surahNo);
    
//     // Extract the first reciter's audio URL from the audio data
//     String firstReciterUrl = audioDesu.audio['1']!.url;
    
//     // Initialize the audio player
//     AudioPlayer audioPlayer = AudioPlayer();
  

//     // Load the audio URL into the player

//     await audioPlayer.play(UrlSource(firstReciterUrl));

//      // Once the audio completes, you can recursively call playAudio for the next ayah
//     audioPlayer.onPlayerComplete.listen((event) {
//       playAudio(surahNo, ayahNo + 1); // Move to the next Ayah in the same Surah
//     });

//   } catch (e) {
//     // Catch any errors (e.g., network issues or invalid data) and log them
//     print("Error fetching or playing audio: $e");
//   }
// }



  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AyahModel>>(
      future: _getAllAyahs(), 
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return Scaffold(
            backgroundColor: background,
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            );
        }

          List<AyahModel> ayahList = snapshot.data!;

          return Scaffold(
            backgroundColor: background,
            appBar: _appBar(
              context: context,
              surahModel : surahModel
              ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: NestedScrollView(
                headerSliverBuilder:(context, innerBoxIsScrolled) => [
                  SliverToBoxAdapter(
                    child: _Moraba3(surahModel: surahModel),
                    
                  )
                ],
                body: ListView.separated(
                  itemBuilder: (context, index){
                        return AyatItem(
                          ayahModel: ayahList[index]);
                    }, 
                  separatorBuilder: (context, index) => SizedBox(height: 24,), 
                  itemCount: surahModel.jumlahAyat,)
              ),
            )

          );
          
  });
      }
}



  Column _Moraba3({required SurahModel surahModel}) {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24,),
              Stack(
                children:[  
                Container(
                height: 265, 
                width: double.infinity, // Set the height of the container
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),  // Set the border radius
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFDF98FA),  // First color (DF98FA)
                    Color(0xFF9055FF),  // Second color (9055FF)
                  ],
                  begin: Alignment.topLeft,  // Start of the gradient
                  end: Alignment.bottomRight,  // End of the gradient
                ),
                ),
                
                child: Stack(
                  children: [
                Positioned(
                left: 68,
                bottom: 0,
                child: Opacity(
                  opacity: .1,
                  child: SvgPicture.asset(
                    'assets/svg/qurann.svg', 
                    width: 310,
                    )),
                ),
                  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 28,),
                    Text(
                      surahModel.namaLatin,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: 4,),
                    Text(
                      surahModel.arti,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: 16,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 63),
                      child: Divider(thickness: 1, color: Colors.white.withOpacity(.35),),
                    ),
                    SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                        Text(
                         surahModel.tempatTurun.name.toUpperCase(), // Replace with your subtitle
                         style: GoogleFonts.poppins(
                           color: Colors.white,
                           fontSize: 14,
                           fontWeight: FontWeight.w500
                           ),
                         ),
                         Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          height: 4, 
                          width: 4,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.35),
                            borderRadius: BorderRadius.circular(2) 
                          ),
                          ),
                         Text(
                         surahModel.jumlahAyat.toString() + ' VERSES', // Replace with your subtitle
                         style: GoogleFonts.poppins(
                           color: Colors.white,
                           fontSize: 14,
                           fontWeight: FontWeight.w500
                           ),
                         ),
                       ],
                     ),
                     SizedBox(height: 32,),
                     SvgPicture.asset('assets/svg/bismiAllah.svg',),
                  ],
                  ),
                  ]
                ),
                ),
                ]
              ),
              SizedBox(height: 32,)
            ],
          );
  }

  AppBar _appBar({required BuildContext context, required SurahModel surahModel}) {
    return AppBar(
      elevation: 0,
      backgroundColor: background,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                }, 
                icon: SvgPicture.asset('assets/svg/sahm.svg')),
              SizedBox(width: 20,),
             Text(
            surahModel.namaLatin,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
            ],
          ),
          IconButton(onPressed: () {}, icon: SvgPicture.asset('assets/svg/search_icon.svg')),
        ],
      ),
    );
  }