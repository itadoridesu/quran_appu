import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_app/components/bookumaaku_item.dart';
import 'package:pizza_app/model/ayah_model.dart';
import 'package:pizza_app/screens/globals.dart';
import 'package:provider/provider.dart';

import '../purobaida/bookumaaku_provider.dart';

class SeivuSelectionDialog extends StatelessWidget {
  final AyahModel ayahModel;

  const SeivuSelectionDialog({required this.ayahModel});

  @override
  Widget build(BuildContext context) {
    final bookumaakuProvider = Provider.of<BookumaakuProvider>(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: secondPrimary,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 0,
              offset: Offset(0, 4),
              color: Colors.black.withOpacity(0.25),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Collection',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Collections (${bookumaakuProvider.bookmarks.length})',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[200],
                  ),
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/svg/folder_plus.svg',
                    color: Colors.white,
                  ),
                  onPressed: () => _showAddFolderDialog(context, bookumaakuProvider),
                ),
              ],
            ),
            SizedBox(height: 16),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: bookumaakuProvider.bookmarks.length,
                itemBuilder: (context, index) {
                  BookumaakuItem item = bookumaakuProvider.bookmarks[index];
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.of(context).pop();
                      bookumaakuProvider.saveAyahToBookumaakuItem(ayahModel, item.title);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/folder.svg',
                            colorFilter: ColorFilter.mode(primary, BlendMode.srcIn),
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '${item.ayahList.length} items',
                                  style: GoogleFonts.poppins(
                                    color: text,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/svg/suree_points.svg',
                            colorFilter: ColorFilter.mode(primary, BlendMode.srcIn),
                            width: 24,
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddFolderDialog(BuildContext context, BookumaakuProvider bookumaakuProvider) {
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
}
