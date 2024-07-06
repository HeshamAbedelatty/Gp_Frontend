import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'audioplayerstate.dart';

class FavoriteListScreen extends StatefulWidget {
  @override
  _FavoriteListScreenState createState() => _FavoriteListScreenState();
}

class _FavoriteListScreenState extends State<FavoriteListScreen> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final playerState = Provider.of<AudioPlayerState>(context);

    final filteredFavorites = playerState.favorites
        .where((audio) =>
            audio.fileName.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Audios', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
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
          Expanded(
            child: ListView.builder(
              itemCount: filteredFavorites.length,
              itemBuilder: (context, index) {
                final audio = filteredFavorites[index];
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Text('${index + 1}.'),
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
    );
  }
}
