import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

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
                playerState.searchAudios(value);
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'lib/assets/back1.jpeg'), // Replace with your background image
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
                          return Slider(
                            activeColor: Colors.white,
                            value: position.inSeconds.toDouble(),
                            max: playerState.audioList[playerState.currentIndex]
                                .duration.inSeconds
                                .toDouble(),
                            onChanged: (value) {
                              playerState
                                  .seek(Duration(seconds: value.toInt()));
                            },
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
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('${index + 1}. ${audio.fileName}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Duration: ${audio.duration.toString().split('.').first}'),
                        Text('Uploaded: ${audio.uploadedDate.toLocal()}'),
                        Text(
                            'Position: ${audio.currentPosition.toString().split('.').first}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(audio.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border),
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
                      playerState
                          .playAudio(playerState.audioList.indexOf(audio));
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
          final result =
              await FilePicker.platform.pickFiles(type: FileType.audio);
          if (result != null) {
            final file = result.files.first;
            final duration = await _getAudioDuration(file.path!);
            final audio = Audio(
              id: playerState.audioList.length + 1,
              user: 'User', // Update accordingly
              fileName: file.name,
              filePath: file.path!,
              duration: duration,
              uploadedDate: DateTime.now(),
              isFavorite: false,
              currentPosition: Duration.zero,
            );
            playerState.addAudio(audio);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<Duration> _getAudioDuration(String path) async {
    final player = AudioPlayer();
    await player.setFilePath(path);
    final duration = player.duration ?? Duration.zero;
    await player.dispose();
    return duration;
  }

  Widget _buildControlButton(IconData icon, VoidCallback onPressed) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black54,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}
