import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AudioPlayerApp extends StatefulWidget {
  @override
  _AudioPlayerAppState createState() => _AudioPlayerAppState();
}

class _AudioPlayerAppState extends State<AudioPlayerApp> {
  List<AudioPlayerItem> _audioFiles = [];
  List<AudioPlayerItem> _favoriteFiles = [];
  int _currentIndex = 0;
  bool _autoplay = false;
  Duration _currentPosition = Duration.zero;
  bool _isSeeking = false;

  void _pickAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        int index = _audioFiles.length + 1;
        for (var file in result.files) {
          _audioFiles.add(AudioPlayerItem(
            "Audio $index: ${file.name}",
            file.path!,
            _playNext,
            _playPrevious,
            _toggleFavorite,
            _updateCurrentPosition,
            _removeAudio,
            _isSeeking,
            _currentPosition,
          ));
          index++;
        }
      });
      if (_autoplay && _audioFiles.isNotEmpty) {
        _audioFiles[_currentIndex].play();
      }
    }
  }

  void _playNext() {
    if (_currentIndex < _audioFiles.length - 1) {
      setState(() {
        _audioFiles[_currentIndex].stop();
        _currentIndex++;
        _audioFiles[_currentIndex].play();
      });
    }
  }

  void _playPrevious() {
    if (_currentIndex > 0) {
      setState(() {
        _audioFiles[_currentIndex].stop();
        _currentIndex--;
        _audioFiles[_currentIndex].play();
      });
    }
  }

  void _toggleFavorite(AudioPlayerItem item) {
    setState(() {
      if (_favoriteFiles.contains(item)) {
        _favoriteFiles.remove(item);
      } else {
        _favoriteFiles.add(item);
      }
    });
  }

  void _removeAudio(AudioPlayerItem item) {
    setState(() {
      if (_audioFiles.contains(item)) {
        _audioFiles.remove(item);
        if (_audioFiles.isEmpty) {
          _currentIndex = 0;
        } else if (_currentIndex >= _audioFiles.length) {
          _currentIndex = _audioFiles.length - 1;
        }
      }
    });
  }

  void _updateCurrentPosition(Duration position, bool isSeeking) {
    setState(() {
      _currentPosition = position;
      _isSeeking = isSeeking;
    });
  }

  @override
  void dispose() {
    for (var audio in _audioFiles) {
      audio.dispose();
    }
    for (var audio in _favoriteFiles) {
      audio.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FavoritePage(_favoriteFiles, _autoplay),
                ),
              );
            },
          ),
          Switch(
            value: _autoplay,
            onChanged: (value) {
              setState(() {
                _autoplay = value;
                if (_autoplay && _audioFiles.isNotEmpty) {
                  _audioFiles[_currentIndex].play();
                }
              });
            },
            activeColor: Colors.white,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          if (_audioFiles.isNotEmpty)
            _audioFiles[_currentIndex].buildNowPlaying(
                _currentPosition, _isSeeking, _updateCurrentPosition),
          Expanded(
            child: ListView.builder(
              itemCount: _audioFiles.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _audioFiles[_currentIndex].stop();
                      _currentIndex = index;
                      _audioFiles[_currentIndex].play();
                    });
                  },
                  child: _audioFiles[index].buildItem(
                    context,
                    index == _currentIndex,
                    _favoriteFiles.contains(_audioFiles[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickAudio,
        child: Icon(Icons.add),
      ),
    );
  }
}

class AudioPlayerItem {
  final String name;
  final String filePath;
  late AudioPlayer _audioPlayer;
  PlayerState _audioPlayerState = PlayerState.stopped;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  final VoidCallback playNext;
  final VoidCallback playPrevious;
  final Function(AudioPlayerItem) toggleFavorite;
  final Function(Duration, bool) updateCurrentPosition;
  final Function(AudioPlayerItem) removeAudio;
  bool _isSeeking = false;

  AudioPlayerItem(
      this.name,
      this.filePath,
      this.playNext,
      this.playPrevious,
      this.toggleFavorite,
      this.updateCurrentPosition,
      this.removeAudio,
      this._isSeeking,
      this._currentPosition) {
    _initAudioPlayer();
  }

  void _initAudioPlayer() {
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      _audioPlayerState = state;
      if (state == PlayerState.completed) {
        playNext();
      }
    });
    _audioPlayer.onDurationChanged.listen((Duration duration) {
      _totalDuration = duration;
    });
    _audioPlayer.onPositionChanged.listen((Duration duration) {
      if (!_isSeeking) {
        _currentPosition = duration;
        updateCurrentPosition(_currentPosition, false);
      }
    });
  }

  void play() async {
    if (_audioPlayerState == PlayerState.stopped) {
      await _audioPlayer.play(DeviceFileSource(filePath));
    } else if (_audioPlayerState == PlayerState.paused) {
      await _audioPlayer.resume();
    }
  }

  void pause() async {
    await _audioPlayer.pause();
  }

  void stop() async {
    await _audioPlayer.stop();
    _audioPlayer.release();
  }

  void dispose() {
    _audioPlayer.dispose();
  }

  Widget buildItem(BuildContext context, bool isCurrent, bool isFavorite) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: Offset(0, 2),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.music_note),
        ),
        title: Text(name),
        subtitle: Text(
          "${_currentPosition.inMinutes}:${(_currentPosition.inSeconds % 60).toString().padLeft(2, '0')}"
          " / ${_totalDuration.inMinutes}:${(_totalDuration.inSeconds % 60).toString().padLeft(2, '0')}",
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              onPressed: () => toggleFavorite(this),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => removeAudio(this),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNowPlaying(Duration currentPosition, bool isSeeking,
      Function(Duration, bool) updateCurrentPosition) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: Offset(0, 2),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "Now Playing",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            name,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(),
                ),
                child: IconButton(
                  onPressed: playPrevious,
                  icon: Icon(
                    Icons.skip_previous,
                    size: 32.0,
                  ),
                ),
              ),
              SizedBox(width: 16.0),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(),
                ),
                child: IconButton(
                  onPressed:
                      _audioPlayerState == PlayerState.playing ? pause : play,
                  icon: Icon(
                    _audioPlayerState == PlayerState.playing
                        ? Icons.pause
                        : Icons.play_arrow,
                    size: 32.0,
                  ),
                ),
              ),
              SizedBox(width: 16.0),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(),
                ),
                child: IconButton(
                  onPressed: playNext,
                  icon: Icon(
                    Icons.skip_next,
                    size: 32.0,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Slider(
            value: currentPosition.inSeconds
                .toDouble()
                .clamp(0.0, _totalDuration.inSeconds.toDouble()),
            min: 0.0,
            max: _totalDuration.inSeconds.toDouble(),
            onChanged: (double value) {
              updateCurrentPosition(Duration(seconds: value.toInt()), true);
            },
            onChangeEnd: (double value) {
              _audioPlayer.seek(Duration(seconds: value.toInt()));
              updateCurrentPosition(Duration(seconds: value.toInt()), false);
            },
          ),
        ],
      ),
    );
  }
}

class FavoritePage extends StatefulWidget {
  final List<AudioPlayerItem> favoriteFiles;
  final bool autoplay;

  FavoritePage(this.favoriteFiles, this.autoplay);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  int _currentFavoriteIndex = 0;
  Duration _currentFavoritePosition = Duration.zero;
  bool _isSeekingFavorite = false;

  void _playNextFavorite() {
    if (_currentFavoriteIndex < widget.favoriteFiles.length - 1) {
      setState(() {
        widget.favoriteFiles[_currentFavoriteIndex].stop();
        _currentFavoriteIndex++;
        widget.favoriteFiles[_currentFavoriteIndex].play();
      });
    }
  }

  void _playPreviousFavorite() {
    if (_currentFavoriteIndex > 0) {
      setState(() {
        widget.favoriteFiles[_currentFavoriteIndex].stop();
        _currentFavoriteIndex--;
        widget.favoriteFiles[_currentFavoriteIndex].play();
      });
    }
  }

  void _updateFavoritePosition(Duration position, bool isSeeking) {
    setState(() {
      _currentFavoritePosition = position;
      _isSeekingFavorite = isSeeking;
    });
  }

  @override
  void dispose() {
    for (var audio in widget.favoriteFiles) {
      audio.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        actions: [
          Switch(
            value: widget.autoplay,
            onChanged: (value) {
              setState(() {
                if (value && widget.favoriteFiles.isNotEmpty) {
                  widget.favoriteFiles[_currentFavoriteIndex].play();
                }
              });
            },
            activeColor: Colors.white,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          if (widget.favoriteFiles.isNotEmpty)
            widget.favoriteFiles[_currentFavoriteIndex].buildNowPlaying(
                _currentFavoritePosition,
                _isSeekingFavorite,
                _updateFavoritePosition),
          Expanded(
            child: ListView.builder(
              itemCount: widget.favoriteFiles.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.favoriteFiles[_currentFavoriteIndex].stop();
                      _currentFavoriteIndex = index;
                      widget.favoriteFiles[_currentFavoriteIndex].play();
                    });
                  },
                  child: widget.favoriteFiles[index].buildItem(
                    context,
                    index == _currentFavoriteIndex,
                    true,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
