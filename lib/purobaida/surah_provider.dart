import 'package:flutter/material.dart';
import 'package:pizza_app/model/surah_model.dart';

class SurahProvider extends ChangeNotifier {
  SurahModel? _selectedSurah;
  int _lastReadAyah = 0;

  SurahModel? get selectedSurah => _selectedSurah;
  int get lastReadAyah => _lastReadAyah;

  void selectSurah(SurahModel surahDetails) {
    _selectedSurah = surahDetails;
    notifyListeners();
  }

  void updateLastReadAyah(int ayah) {
    _lastReadAyah = ayah;
    notifyListeners();
  }
}
