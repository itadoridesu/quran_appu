import 'package:flutter/material.dart';
import 'package:pizza_app/model/surah_model.dart';

class SurahProvider extends ChangeNotifier {
  SurahModel? _selectedSurah;
  int _lastReadAyah = 0;
  BuildContext? _context;
  List<SurahModel> _allSurahs = []; // Add a list to hold all Surahs


  SurahModel? get selectedSurah => _selectedSurah;
  int get lastReadAyah => _lastReadAyah;
  BuildContext? get context => _context;


  void selectSurah(SurahModel surahDetails) {
    _selectedSurah = surahDetails;
    notifyListeners();
  }

  void updateLastReadAyah(int ayah) {
    _lastReadAyah = ayah;
    notifyListeners();
  }

  void getContext(BuildContext context) {
    _context = context;
    notifyListeners();
  }
    void setAllSurahs(List<SurahModel> surahs) {
    _allSurahs = surahs;
    print("All Surahs set: ${_allSurahs.length}");  // Set the list of Surahs
    notifyListeners();
  }

  List<SurahModel> get allSurahs => _allSurahs; // Expose the list of Surahs
}
