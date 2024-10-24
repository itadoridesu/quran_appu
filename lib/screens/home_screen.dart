import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_app/components/bottom_navigeishun_no_baaru.dart';
import 'package:pizza_app/components/appu_baa.dart';
import 'package:pizza_app/purobaida/nabigeishun_provider.dart';
import 'package:pizza_app/purobaida/surah_provider.dart';
import 'package:pizza_app/screens/details_surah.dart';
import 'package:pizza_app/screens/duaa_screen.dart';
import 'package:pizza_app/screens/globals.dart';
import 'package:pizza_app/screens/lomba_screen.dart';
import 'package:pizza_app/screens/purayingu_screen.dart';
import 'package:pizza_app/screens/seivu_screen.dart';
import 'package:pizza_app/tabs/hijb_tab.dart';
import 'package:pizza_app/tabs/page_tab.dart';
import 'package:pizza_app/tabs/para_tab.dart';
import 'package:pizza_app/tabs/surah_tab.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NabigeishunProvider>(context);
    final connutexto = Provider.of<SurahProvider>(context);

    connutexto.getContext(context);

    return Scaffold(
      backgroundColor: background,
      appBar: CustomAppBar(title: 'Quran App'),
      bottomNavigationBar: BottomNavigeishunNoBaaru(
        currentIndex: navigationProvider.currentIndex,
        onTap: (index) {
          navigationProvider.setIndex(index);
        },
      ),
      body: _getScreen(navigationProvider.currentIndex),
    );
  }

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return Consumer<SurahProvider>(
            builder: (context, connutexto, child) =>
                _body_desu(connutexto.context!)); // Current screen
      case 1:
        return LombaScreen(); // Lomba screen
      case 2:
        return PurayinguScreen(); // Praying screen
      case 3:
        return DuaaScreen(); // Duaa screen
      case 4:
        return SeivuScreen(); // Save screen
      default:
        return HomeScreen(); // Default to HomeScreen
    }
  }

  SafeArea _body_desu(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: _greeting(context),
              ),
              SliverAppBar(
                pinned: true,
                elevation: 0.0,
                shape: Border(
                  bottom: BorderSide(
                    color: Color(0xffaaaaaa).withOpacity(.1),
                    width: 3,
                  ),
                ),
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        background,
                        background.withOpacity(0.8), // Slightly transparent
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                backgroundColor: background,
                automaticallyImplyLeading: false,
                bottom: PreferredSize(
                    preferredSize: Size.fromHeight(0), child: _tab()),
              )
            ],
            body: TabBarView(
              children: [SurahTab(), ParaTab(), PageTab(), HijbTab()],
            ), // Ensure this matches your app's background
          ),
        ),
      ),
    );
  }

  TabBar _tab() {
    return TabBar(
        dividerColor: Colors.transparent,
        unselectedLabelColor: text,
        labelColor: Colors.white,
        indicatorColor: primary,
        indicatorWeight: 3,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          _tabItem(tabbu: 'Surah'),
          _tabItem(tabbu: 'Para'),
          _tabItem(tabbu: 'Page'),
          _tabItem(tabbu: 'Hijb'),
        ]);
  }

  Tab _tabItem({required String tabbu}) {
    return Tab(
      child: Text(
        tabbu,
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  Column _greeting(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
        ),
        Text(
          'Assalamualaikum',
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: text,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          'Adem Hamizi',
          style: GoogleFonts.poppins(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 24,
        ),
        Stack(
          children: [
            homeNoBox(context),
            Positioned(
              left: 202.5, // Position from the left
              bottom: 0, // Position from the bottom
              child: SvgPicture.asset(
                'assets/svg/qurann.svg',
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        )
      ],
    );
  }

  Consumer<SurahProvider> homeNoBox(BuildContext context) {
    return Consumer<SurahProvider>(builder: (context, surahProvider, child) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (surahProvider.selectedSurah != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) =>
                      DetailsSurah(surahModel: surahProvider.selectedSurah!)),
            );
          } else {
            // Show message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Material(
                  borderRadius: BorderRadius.circular(20), // Circular border
                  color: secondPrimary, // Background color of the SnackBar
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 16), // Padding for the content
                    child: Center(
                      child: Text(
                        "RECITE SOME QURAN FIRST !!!",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w400
                            ), // Text style
                      ),
                    ),
                  ),
                ),
                //behavior: SnackBarBehavior.floating, // Floating behavior
                backgroundColor:
                    Colors.transparent, // Set background to transparent
                duration: Duration(seconds: 3), // Duration before it disappears
              ),
            );
          }
        },
        child: Container(
          height: 131, // Set the height of the container
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), // Set the border radius
            gradient: LinearGradient(
              colors: [
                Color(0xFFDF98FA), // First color (DF98FA)
                Color(0xFF9055FF), // Second color (9055FF)
              ],
              begin: Alignment.topLeft, // Start of the gradient
              end: Alignment.bottomRight, // End of the gradient
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 19, bottom: 19, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/svg/last.svg'),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Last Read',
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  surahProvider.selectedSurah?.namaLatin ?? 'RECITE QURAN',
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 4,
                ),
                Consumer<SurahProvider>(
                  builder: (context, surahProvider, child) => Text(
                    'Ayah No: ' + surahProvider.lastReadAyah.toString(),
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

//   AppBar _appBar() {
//     return AppBar(
//       elevation: 0,
//       backgroundColor: background,
//       automaticallyImplyLeading: false,
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               IconButton(
//                   onPressed: () {},
//                   icon: SvgPicture.asset('assets/svg/durawa.svg')),
//               SizedBox(
//                 width: 20,
//               ),
//               Text(
//                 'Quran App',
//                 style: GoogleFonts.poppins(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           IconButton(
//               onPressed: () {},
//               icon: SvgPicture.asset('assets/svg/search_icon.svg')),
//         ],
//       ),
//     );
//   }
}
