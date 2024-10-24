//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pizza_app/components/surah_item.dart';
import 'package:pizza_app/model/surah_model.dart';
import 'package:pizza_app/purobaida/surah_provider.dart';
import 'package:provider/provider.dart';

class SurahTab extends StatelessWidget {
  const SurahTab({super.key});
  
Future<List<SurahModel>> _getSurahList() async {
  // Load the JSON file
  String response = await rootBundle.loadString('assets/data/list-surah.json');
  // Decode the JSON into a list of SurahModel objects
  return surahModelFromJson(response);
}


  @override
  Widget build(BuildContext context) {
    
    final surahProvider = Provider.of<SurahProvider>(context);

    return FutureBuilder<List<SurahModel>>(
      future: _getSurahList(), 
      initialData: [],
      builder: ((context, snapshot) {
        if(!snapshot.hasData) {
          return Container();
        }

        if (snapshot.hasData) {
          // Only set the surahs if they haven't been set yet
          if (surahProvider.allSurahs.isEmpty) {
            surahProvider.setAllSurahs(snapshot.data!);
          }
        }


        return ListView.separated(
          itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(
              top: index == 0 ? 8 : 0,
              bottom: index == snapshot.data!.length - 1 ? 24 : 0,
            ),
            child: SurahItem(surahModel: snapshot.data!.elementAt(index), context: context,),
          ), 
          separatorBuilder: (context, index) => Divider(
            thickness: 1, color: Color(0xff7B80AD).withOpacity(0.35),), 
          itemCount: snapshot.data!.length);
      }
      )
      );
  }
 }