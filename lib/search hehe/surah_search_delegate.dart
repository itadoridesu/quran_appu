import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_app/model/surah_model.dart';
import 'package:pizza_app/purobaida/surah_provider.dart';
import 'package:pizza_app/screens/details_surah.dart';
import 'package:pizza_app/screens/globals.dart';
import 'package:provider/provider.dart';

class SurahSearchDelegate extends SearchDelegate<SurahModel?> {
  final List<SurahModel> allSurahs;

  SurahSearchDelegate(this.allSurahs);

  @override
  String get searchFieldLabel => 'search surah by name';

   @override
  TextStyle get searchFieldStyle {
    // Check if the query contains any Latin characters
    bool isLatin = RegExp(r'[a-zA-Z]').hasMatch(query);

    return GoogleFonts.getFont(
      isLatin ? 'Poppins' : 'Amiri', // Use Poppins for Latin, Amiri for Arabic
      color: Colors.white,
      fontSize: 18,
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        elevation: 0,
      ),
      scaffoldBackgroundColor: background,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: GoogleFonts.poppins(color: text, fontSize: 17),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        'assets/svg/sahm.svg',
        color: primary,
      ),
      onPressed: () {
        close(context, null); // Close the search screen
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.only(right: 8),
        child: IconButton(
          icon: Icon(
            Icons.clear,
            color: primary,
          ),
          onPressed: () {
            query = ''; // Clear the query
          },
        ),
      ),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = allSurahs
        .where((surah) =>
            surah.nama.contains(query) ||
            surah.namaLatin.toLowerCase().contains(query.toLowerCase()) ||
            surah.tempatTurun.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Container(
      color: background,
      child: results.isEmpty
          ? Center(
              child: Text('No results found.',
                  style: GoogleFonts.poppins(fontSize: 18)))
          : ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final surah = results[index];
                return GestureDetector(
                  onTap: () {
                    Provider.of<SurahProvider>(context, listen: false)
                        .selectSurah(surah);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailsSurah(surahModel: surah),
                    ));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: background.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Surah number inside a star shape
                        Stack(
                          children: [
                            SvgPicture.asset('assets/svg/njma.svg'),
                            SizedBox(
                              height: 36,
                              width: 36,
                              child: Center(
                                child: Text(
                                  surah.nomor.toString(),
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 16),
                        // Surah details (Latin name, verses, revelation place)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                surah.namaLatin,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    surah.tempatTurun.name.toUpperCase(),
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
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  Text(
                                    '${surah.jumlahAyat} VERSES',
                                    style: GoogleFonts.poppins(
                                      color: text,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Arabic name of the Surah
                        Text(
                          surah.nama,
                          style: GoogleFonts.amiri(
                            color: Colors.white.withOpacity(.9),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
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

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? []
        : allSurahs
            .where((surah) =>
                surah.nama.contains(query) ||
                surah.namaLatin.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return Container(
      color: background,
      child: suggestions.isEmpty
          ? Center(
              child: Text('No suggestions found.',
                  style: GoogleFonts.poppins(
                      fontSize: 17, color: text, fontWeight: FontWeight.w400)))
          : ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                final surah = suggestions[index];

                bool isLatin =
                    surah.namaLatin.toLowerCase().contains(query.toLowerCase());

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  elevation: 0,
                  color: background
                      .withOpacity(0.9), // Semi-transparent white card
                  child: ListTile(
                    leading: isLatin
                        ? null // No leading icon for Latin search
                        : Icon(
                            Icons.arrow_circle_up_rounded,
                            color: Colors.white.withOpacity(.8),
                          ),
                    title: Text(
                      isLatin ? surah.namaLatin : surah.nama,
                      style: isLatin
                          ? GoogleFonts.poppins(
                              // Latin name style
                              color: Colors.white.withOpacity(.9),
                              fontSize: 17,
                              fontWeight: FontWeight.w500)
                          : GoogleFonts.amiri(
                              // Arabic name style
                              color: Colors.white.withOpacity(.9),
                              fontSize: 20,
                            ),
                      textAlign: isLatin
                          ? TextAlign.start
                          : TextAlign.end, // Align text based on type
                    ),
                    trailing: isLatin
                        ? Icon(
                            Icons.arrow_circle_up_rounded,
                            color: Colors.white.withOpacity(.8),
                          )
                        : null, // Move the icon to trailing for Latin name
                    onTap: () {
                      query = isLatin ? surah.namaLatin : surah.nama;
                      showResults(
                          context); // Show results for the selected suggestion
                    },
                  ),
                );
              },
            ),
    );
  }
}
