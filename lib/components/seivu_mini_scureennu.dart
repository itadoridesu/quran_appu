import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_app/components/ayah_list_screen.dart';
import 'package:pizza_app/components/bookumaaku_item.dart';
import 'package:pizza_app/purobaida/bookumaaku_provider.dart';
import 'package:provider/provider.dart';

class SeivuMiniScreenBody extends StatelessWidget {
  final void Function(BuildContext, BookumaakuProvider, bool) showAddFolderDialog;

  const SeivuMiniScreenBody({required this.showAddFolderDialog});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookumaakuProvider>(
      builder: (context, bookumaakuProvider, child) {
        return SafeArea(
          child: Column(
            children: [
              SizedBox(height: 24),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => showAddFolderDialog(context, bookumaakuProvider, false),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/svg/folder_plus.svg'),
                        SizedBox(width: 8),
                        Text(
                          'Add new collection',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SvgPicture.asset('assets/svg/thuree_rainzu.svg'),
                  ],
                ),
              ),
              SizedBox(height: 32),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    BookumaakuItem bookumaakuItem = bookumaakuProvider.bookmarks[index];
                    return GestureDetector(
                      onTap: () =>            // Navigate to AyahListScreen
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AyahListScreen(bookumaakuItem.ayahList, bookumaakuItem.title),)),
                      child: bookumaakuItem
                      );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 16),
                  itemCount: bookumaakuProvider.bookmarks.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
