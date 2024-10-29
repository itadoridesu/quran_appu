import 'package:flutter/material.dart';
import 'package:pizza_app/components/bookumaaku_item.dart';
import 'package:pizza_app/model/ayah_model.dart';

class BookumaakuProvider extends ChangeNotifier {
  final List<AyahModel> savedAyahs = [];
  final List<BookumaakuItem> bookmarks = [];

  void addBookkuMaaku(BookumaakuItem bookumaakuitem) {
    bookmarks.add(bookumaakuitem);
    notifyListeners();
  }

  void removeBookkuMaaku(BookumaakuItem bookumaakuitem) {
    bookmarks.remove(bookumaakuitem);
    notifyListeners();
  }

  bool isAyahSaved(AyahModel ayah) {
    return savedAyahs.contains(ayah);
  }

  void saveAyah(AyahModel ayah) {
    if (!savedAyahs.contains(ayah)) {
      savedAyahs.add(ayah);
      notifyListeners();
    }
  }

 void saveAyahToBookumaakuItem(AyahModel ayah, String title) {
    final item = bookmarks.firstWhere((item) => item.title == title);
    if (!savedAyahs.contains(ayah)) {
      savedAyahs.add(ayah);
      item.ayahList.add(ayah);
      notifyListeners();
    }
  }


  void removeAyah(AyahModel ayah) {
    savedAyahs.remove(ayah);
    notifyListeners();
  }
}
