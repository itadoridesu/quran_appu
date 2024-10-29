import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_app/components/bookumaaku_item.dart';
import 'package:pizza_app/components/seivu_mini_scureennu.dart';
import 'package:pizza_app/purobaida/bookumaaku_provider.dart';
import 'package:pizza_app/screens/globals.dart';
import 'package:provider/provider.dart';

class SeivuScreen extends StatelessWidget {
  const SeivuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookumaakuProvider>(
      builder: (context, bookumaakuProvider, child) {
        return Scaffold(
          backgroundColor: background,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SeivuMiniScreenBody(showAddFolderDialog: _showAddFolderDialog),
          ),

        );
      }
    );
  }


void _showAddFolderDialog(BuildContext context, BookumaakuProvider bookumaakuProvider, bool whatToDo) {
  final TextEditingController folderController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: secondPrimary,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Add New Collection',
                  style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: TextField(
                  controller: folderController,
                  decoration: InputDecoration(
                    hintText: 'Enter folder title',
                    hintStyle: GoogleFonts.poppins(color: text),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primary),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primary),
                    ),
                  ),
                  style: GoogleFonts.poppins(color: text),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Text('Cancel', style: GoogleFonts.poppins(color: text)),
                    ),
                    TextButton(
                      onPressed: () {
                        String title = folderController.text.trim();
                        if (title.isNotEmpty) {
                          bookumaakuProvider.addBookkuMaaku(BookumaakuItem(title: title, ayahList: []));
                          Navigator.of(context).pop(); // Close the dialog
                        }
                      },
                      child: Text('Add', style: GoogleFonts.poppins(color: primary)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// Call this method in SeivuScreen
//_showAddFolderDialog(context, bookumaakuProvider, false);


}
