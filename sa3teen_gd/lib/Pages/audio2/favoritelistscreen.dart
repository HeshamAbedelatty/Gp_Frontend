
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import 'package:file_picker/file_picker.dart';

class FavoriteListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final playerState = Provider.of<AudioPlayerState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Audios'),
      ),
      body: ListView.builder(
        itemCount: playerState.favoriteList.length,
        itemBuilder: (context, index) {
          final audio = playerState.favoriteList[index];
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
                playerState.playAudio(playerState.favoriteList.indexOf(audio));
              },
            ),
          );
        },
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
              isFavorite: true,
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
}
