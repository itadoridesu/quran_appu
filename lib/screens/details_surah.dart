import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_app/components/ayat_item.dart';
import 'package:pizza_app/model/ayah_model.dart';
import 'package:pizza_app/model/surah_model.dart';
import 'package:pizza_app/purobaida/audio_state_provider.dart';
import 'package:pizza_app/screens/globals.dart';
import 'package:pizza_app/search%20hehe/ayah_search_delegate.dart';
import 'package:provider/provider.dart';

class DetailsSurah extends StatelessWidget {
  final SurahModel surahModel;
  DetailsSurah({super.key, required this.surahModel});


Future<List<AyahModel>> _getAllAyahs() async {
    List<AyahModel> ayahList = [];
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

    ayahList = await Future.wait(futures);
    print("Fetched ${ayahList.length} Ayahs for Surah ${surahModel.namaLatin}");
    return ayahList;
  }
 

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
          Provider.of<AudioStateProvider>(context).setCurrentSurahAyahs(ayahList);


          return Scaffold(
            backgroundColor: background,
            appBar: _appBar(
              context: context,
              surahModel : surahModel,
              ayahList: ayahList
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

  AppBar _appBar({required BuildContext context, required SurahModel surahModel, required List<AyahModel> ayahList}) {


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
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: AyahSearchDelegate(ayahList),
              );  
          }, icon: SvgPicture.asset('assets/svg/search_icon.svg')),
        ],
      ),
    );
  }