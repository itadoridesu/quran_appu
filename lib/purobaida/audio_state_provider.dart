import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioStateProvider with ChangeNotifier {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  String? _activeAyah;

  bool get isPlaying => _isPlaying;
  String? get activeAyah => _activeAyah;

  AudioStateProvider() {
    // Add listener for when audio completes
    audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.completed) {
        _isPlaying = false;
        _activeAyah = null; // Clear active Ayah
        notifyListeners(); // Notify listeners to rebuild the UI
      }
    });
  }

  // Method to play audio
  Future<void> playAudio(String url, String ayahKey) async {
    try {
      if (_activeAyah != ayahKey) {
        // Stop the currently playing audio if a new Ayah is selected
        await stopAudio();
      }
      _isPlaying = true;
      _activeAyah = ayahKey; // Set active Ayah
      await audioPlayer.setSource(UrlSource(url)); // Use setSource with UrlSource
      await audioPlayer.resume(); // Start playback
      notifyListeners();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  // Method to stop audio playback
  Future<void> stopAudio() async {
    _isPlaying = false;
    _activeAyah = null; // Clear active Ayah
    await audioPlayer.stop(); // Ensure this stops the playback
    notifyListeners();
  }
}
