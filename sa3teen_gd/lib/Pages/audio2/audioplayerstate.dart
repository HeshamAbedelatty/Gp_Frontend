import 'package:final_profile/audio2/Audioservice.dart';
import 'package:final_profile/audio2/audiomodel.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerState extends ChangeNotifier {
  final AudioPlayer audioPlayer = AudioPlayer();
  List<Audio> audioList = [];
  List<Audio> favoriteList = [];
  int currentIndex = -1;
  final AudioApiService apiService = AudioApiService();

  AudioPlayerState() {
    fetchAudios();
    fetchFavorites();
  }

  Future<void> fetchAudios() async {
    audioList = await apiService.fetchAudios();
    print('Audio list fetched: $audioList'); // Debug statement
    notifyListeners();
  }

  Future<void> fetchFavorites() async {
    favoriteList = await apiService.fetchFavorites();
    print('Favorite list fetched: $favoriteList'); // Debug statement
    notifyListeners();
  }

  Future<void> addAudio(Audio audio) async {
    await apiService.addAudio(audio);
    fetchAudios();
  }

  Future<void> playAudio(int index) async {
    if (currentIndex != index) {
      currentIndex = index;
      await audioPlayer.setFilePath(audioList[index].filePath);
    }
    audioPlayer.play();
    notifyListeners();
  }

  void stopAudio() {
    audioPlayer.stop();
    notifyListeners();
  }

  void playNext() {
    if (currentIndex < audioList.length - 1) {
      playAudio(currentIndex + 1);
    }
  }

  void playPrevious() {
    if (currentIndex > 0) {
      playAudio(currentIndex - 1);
    }
  }

  void toggleFavorite(Audio audio) {
    audio.isFavorite = !audio.isFavorite;
    notifyListeners();
  }

  void seek(Duration position) {
    audioPlayer.seek(position);
    notifyListeners();
  }

  void removeAudio(int index) {
    audioList.removeAt(index);
    notifyListeners();
  }

  Future<void> searchAudios(String query) async {
    audioList = await apiService.searchAudios(query);
    notifyListeners();
  }
}
