import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';

import 'audio.dart';

class AudioPlayerState with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<Audio> _audioList = [];
  List<Audio> _favorites = [];
  int _currentIndex = -1;
  final Box<Audio> _audioBox = Hive.box<Audio>('audios');

  AudioPlayerState() {
    _audioList = _audioBox.values.toList();
  }

  AudioPlayer get audioPlayer => _audioPlayer;
  List<Audio> get audioList => _audioList;
  List<Audio> get favorites => _favorites;
  int get currentIndex => _currentIndex;

  Future<void> addAudio(Audio audio) async {
    _audioList.add(audio);
    await _audioBox.add(audio);
    notifyListeners();
  }

  void removeAudio(int index) {
    final audio = _audioList[index];
    _audioBox.deleteAt(index); // Use deleteAt to remove item by index
    _audioList.removeAt(index);
    if (_currentIndex == index) {
      _audioPlayer.stop();
      _currentIndex = -1;
    }
    notifyListeners();
  }

  void toggleFavorite(Audio audio) {
    audio.isFavorite = !audio.isFavorite;
    if (audio.isFavorite) {
      _favorites.add(audio);
    } else {
      _favorites.remove(audio);
    }
    notifyListeners();
  }

  Future<void> playAudio(int index) async {
    if (_currentIndex != index) {
      _currentIndex = index;
      await _audioPlayer.setFilePath(_audioList[index].filePath);
    }
    _audioPlayer.play();
    notifyListeners();
  }

  void stopAudio() {
    _audioPlayer.stop();
    notifyListeners();
  }

  void playNext() {
    if (_currentIndex < _audioList.length - 1) {
      playAudio(_currentIndex + 1);
    }
  }

  void playPrevious() {
    if (_currentIndex > 0) {
      playAudio(_currentIndex - 1);
    }
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
    _audioList[_currentIndex].currentPosition = position;
    notifyListeners();
  }
}
