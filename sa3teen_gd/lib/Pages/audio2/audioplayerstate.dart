

import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/audio2/Audioservice.dart';
import 'package:gp_screen/Pages/audio2/audiomodel.dart';
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
    notifyListeners();
  }

  Future<void> fetchFavorites() async {
    favoriteList = await apiService.fetchFavorites();
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
    apiService.updateAudio(audio);
    notifyListeners();
  }

  void seek(Duration position) {
    audioPlayer.seek(position);
    notifyListeners();
  }

  void removeAudio(int index) {
    final audio = audioList.removeAt(index);
    apiService.updateAudio(audio); // Update the backend on remove
    notifyListeners();
  }

  Future<void> searchAudios(String query) async {
    audioList = await apiService.searchAudios(query);
    notifyListeners();
}
}

// class AudioPlayerState extends ChangeNotifier {
//   final AudioPlayer audioPlayer = AudioPlayer();
//   List<Audio> audioList = [];
//   List<Audio> favoriteList = [];
//   int currentIndex = -1;
//   final AudioApiService apiService = AudioApiService();

//   AudioPlayerState() {
//     fetchAudios();
//     fetchFavorites();
//   }

//   Future<void> fetchAudios() async {
//     audioList = await apiService.fetchAudios();
//     print('Audio list fetched: $audioList'); // Debug statement
//     notifyListeners();
//   }

//   Future<void> fetchFavorites() async {
//     favoriteList = await apiService.fetchFavorites();
//     print('Favorite list fetched: $favoriteList'); // Debug statement
//     notifyListeners();
//   }

//   Future<void> addAudio(Audio audio) async {
//     await apiService.addAudio(audio);
//     fetchAudios();
//   }

//   Future<void> playAudio(int index) async {
//     if (currentIndex != index) {
//       currentIndex = index;
//       await audioPlayer.setFilePath(audioList[index].filePath);
//     }
//     audioPlayer.play();
//     notifyListeners();
//   }

//   void stopAudio() {
//     audioPlayer.stop();
//     notifyListeners();
//   }

//   void playNext() {
//     if (currentIndex < audioList.length - 1) {
//       playAudio(currentIndex + 1);
//     }
//   }

//   void playPrevious() {
//     if (currentIndex > 0) {
//       playAudio(currentIndex - 1);
//     }
//   }

//   void toggleFavorite(Audio audio) {
//     audio.isFavorite = !audio.isFavorite;
//     notifyListeners();
//   }

//   void seek(Duration position) {
//     audioPlayer.seek(position);
//     notifyListeners();
//   }

//   void removeAudio(int index) {
//     audioList.removeAt(index);
//     notifyListeners();
//   }

//   Future<void> searchAudios(String query) async {
//     audioList = await apiService.searchAudios(query);
//     notifyListeners();
//   }
// }
