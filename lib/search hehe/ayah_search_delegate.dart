import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_app/model/ayah_model.dart';
import 'package:pizza_app/screens/globals.dart';

class AyahSearchDelegate extends SearchDelegate<AyahModel?> {
  final List<AyahModel> ayahs;

  AyahSearchDelegate(this.ayahs);

  @override
  String get searchFieldLabel => 'Search Ayah by Text';

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
    final results = ayahs
        .where((ayah) =>
            ayah.english.toLowerCase().contains(query.toLowerCase()) ||
            ayah.arabic1.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Container(
      color: background,
      child: results.isEmpty
          ? Center(
              child: Text('No results found.',
                  style: GoogleFonts.poppins(fontSize: 18)))
          : ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
              itemCount: results.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    close(context, results[index]); // Return the selected Ayah
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
                        // Arabic text aligned to the right
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            results[index].arabic1,
                            style: GoogleFonts.amiri(
                              color: Colors.white.withOpacity(.9),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        // English text aligned to the left

                        SizedBox(
                          height: 15,
                        ),

                        Text(
                          results[index].english,
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

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? []
        : ayahs
            .where((ayah) => (RegExp(r'[\u0600-\u06FF]')
                    .hasMatch(query) // Check if the query is Arabic
                ? ayah.arabic2.toLowerCase().contains(query.toLowerCase())
                : ayah.english.toLowerCase().contains(query.toLowerCase())))
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
                final ayah = suggestions[index];
                bool isArabic = RegExp(r'[\u0600-\u06FF]')
                    .hasMatch(query); // Check if query is Arabic

                return GestureDetector(
                  onTap: () {
                    query = isArabic
                        ? ayah.arabic1
                        : ayah.english; // Set Arabic if query is Arabic
                    showResults(
                        context); // Show results for the selected suggestion
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: background.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isArabic) // Circle icon on the left for English
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(color: primary),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Stack(
                              children: [ 
                                Icon(
                                Icons.circle,
                                color: primary,
                                size: 18,
                              ),
                              Positioned(
                                right: 5.1,
                                bottom: -2.5,
                                child: Text(
                                ayah.ayahNo.toString(), 
                                style: GoogleFonts.amiri(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                                  ),
                                  )
                                )
                              ]
                            ),
                          ),
                        if (!isArabic)
                          SizedBox(
                              width:
                                  9), // Small padding between the icon and Ayah translation

                        Expanded(
                          child: Text(
                            isArabic
                                ? ayah.arabic1
                                : ayah
                                    .english, // Show Arabic if query is Arabic
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: isArabic
                                ? TextAlign.end
                                : TextAlign
                                    .start, // Align text based on language
                          ),
                        ),
                        if (isArabic) // Circle icon on the right for Arabic
                          SizedBox(width: 10), // Space before the icon
                        if (isArabic) // Only show if the query is Arabic
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(color: primary),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Stack(
                              children: [ 
                                Icon(
                                Icons.circle,
                                color: primary,
                                size: 18,
                              ),
                              Positioned(
                                right: 5.1,
                                bottom: -2.3,
                                child: Text(
                                ayah.ayahNo.toString(), 
                                style: GoogleFonts.amiri(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                                  ),
                                  )
                                )
                              ]
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
