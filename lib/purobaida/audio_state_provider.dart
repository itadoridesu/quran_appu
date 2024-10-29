import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/model/ayah_model.dart';

class AudioStateProvider with ChangeNotifier {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  String? _activeAyah;
  List<AyahModel>? _currentSurahAyahs;

  String? _nextAyahKey;

  String? get nextAyahKey => _nextAyahKey;
  

  bool get isPlaying => _isPlaying;
  String? get activeAyah => _activeAyah;

  AudioStateProvider() {
    audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.completed) {
        _playNextAyah();
      }
    });
  }

  void setCurrentSurahAyahs(List<AyahModel> ayahs) {
    _currentSurahAyahs = ayahs;
  }

  Future<void> playAudio(String url, String ayahKey) async {
    try {
      if (_activeAyah != ayahKey) {
        await stopAudio();
      }
      _isPlaying = true;
      _activeAyah = ayahKey;
      await audioPlayer.setSource(UrlSource(url));
      await audioPlayer.resume();
      notifyListeners();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  Future<void> stopAudio() async {
    _isPlaying = false;
    _activeAyah = null;
    await audioPlayer.stop();
    notifyListeners();
  }

  void _playNextAyah() {
    if (_currentSurahAyahs == null || !_isPlaying) return;

    final currentIndex = _currentSurahAyahs!.indexWhere((element) => element.surahNo == int.parse(_activeAyah!.split('_')[0]) &&
        element.ayahNo == int.parse(_activeAyah!.split('_')[1]));
    
    if (currentIndex >= 0 && currentIndex < _currentSurahAyahs!.length - 1) {
      final nextAyah = _currentSurahAyahs![currentIndex + 1];
      _nextAyahKey = '${nextAyah.surahNo}_${nextAyah.ayahNo}'; // Store next Ayah key

      playAudio(nextAyah.audio['1']?.url ?? '', '${nextAyah.surahNo}_${nextAyah.ayahNo}');
    } else {
      stopAudio();
    }
  }
}
