import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import 'audio.dart';
import 'audioplayerstate.dart';
import 'favoritelistscreen.dart';

class AudioPlayerScreen extends StatefulWidget {
  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final playerState = Provider.of<AudioPlayerState>(context);

    final filteredAudioList = playerState.audioList
        .where((audio) =>
            audio.fileName.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Player'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoriteListScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = '';
                    });
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/back1.jpeg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                if (playerState.currentIndex != -1)
                  Column(
                    children: [
                      Text(
                        playerState
                            .audioList[playerState.currentIndex].fileName,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      StreamBuilder<Duration>(
                        stream: playerState.audioPlayer.positionStream,
                        builder: (context, snapshot) {
                          final position = snapshot.data ?? Duration.zero;
                          final audio =
                              playerState.audioList[playerState.currentIndex];
                          return Column(
                            children: [
                              Slider(
                                activeColor: Colors.white,
                                value: position.inSeconds.toDouble(),
                                max: audio.duration.inSeconds.toDouble(),
                                onChanged: (value) {
                                  playerState
                                      .seek(Duration(seconds: value.toInt()));
                                },
                              ),
                              Text(
                                '${_formatDuration(position)} / ${_formatDuration(audio.duration)}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildControlButton(
                        Icons.skip_previous, playerState.playPrevious),
                    _buildControlButton(
                      playerState.audioPlayer.playing
                          ? Icons.pause
                          : Icons.play_arrow,
                      playerState.audioPlayer.playing
                          ? playerState.stopAudio
                          : () {
                              playerState.playAudio(playerState.currentIndex);
                            },
                    ),
                    _buildControlButton(Icons.skip_next, playerState.playNext),
                    _buildControlButton(Icons.replay, () {
                      playerState.seek(Duration.zero);
                      playerState.playAudio(playerState.currentIndex);
                    }),
                    _buildControlButton(Icons.autorenew, () {
                      // Add your autoplay functionality here if needed
                    }),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredAudioList.length,
              itemBuilder: (context, index) {
                final audio = filteredAudioList[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Text('${index + 1}'), // Numbering the audios
                    title: Text(audio.fileName),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            audio.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                          onPressed: () {
                            playerState.toggleFavorite(audio);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            playerState.removeAudio(index);
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      playerState.playAudio(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.audio,
          );

          if (result != null) {
            PlatformFile file = result.files.first;

            final audio = Audio(
              id: DateTime.now().millisecondsSinceEpoch,
              user: 'CurrentUser', // Replace with actual user if needed
              fileName: file.name,
              filePath: file.path!,
              duration: await _getDuration(file.path!),
              uploadedDate: DateTime.now(),
            );

            playerState.addAudio(audio);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  IconButton _buildControlButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon, color: Colors.white),
      iconSize: 40.0,
      onPressed: onPressed,
    );
  }

  Future<Duration> _getDuration(String filePath) async {
    final audioPlayer = AudioPlayer();
    await audioPlayer.setFilePath(filePath);
    final duration = audioPlayer.duration ?? Duration.zero;
    await audioPlayer.dispose();
    return duration;
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }
}
