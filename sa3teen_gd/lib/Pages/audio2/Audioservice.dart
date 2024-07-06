import 'dart:convert';

import 'package:gp_screen/Pages/audio2/audiomodel.dart';
import 'package:http/http.dart' as http;
class AudioApiService {
  final String baseUrl = 'http://10.0.2.2:8000/audio/';
  final String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw';

  Future<List<Audio>> fetchAudios() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => Audio.fromJson(item)).toList();
      } else {
        print('Failed to load audios: ${response.statusCode} ${response.body}');
        throw Exception('Failed to load audios');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load audios');
    }
  }

  Future<List<Audio>> fetchFavorites() async {
    final response = await http.get(
      Uri.parse('${baseUrl}favorites/'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Audio.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load favorite audios');
    }
  }

  Future<void> addAudio(Audio audio) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(audio.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add audio');
    }
  }

  Future<void> updateAudio(Audio audio) async {
    final response = await http.put(
      Uri.parse('$baseUrl${audio.id}/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(audio.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update audio');
    }
  }

  Future<List<Audio>> searchAudios(String query) async {
    final response = await http.get(
      Uri.parse('${baseUrl}search/?query=$query'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Audio.fromJson(item)).toList();
    } else {
      throw Exception('Failed to search audios');
}
}
}

// class AudioApiService {
//   final String baseUrl = 'http://10.0.2.2:8000/audio/';
//   final String token =
//       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw';

//   Future<List<Audio>> fetchAudios() async {
//     try {
//       final response = await http.get(
//         Uri.parse(baseUrl),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         List<dynamic> data = json.decode(response.body);
//         print('Fetched audios: $data'); // Debug statement
//         return data.map((item) => Audio.fromJson(item)).toList();
//       } else {
//         print('Failed to load audios: ${response.statusCode} ${response.body}');
//         throw Exception('Failed to load audios');
//       }
//     } catch (e) {
//       print('Error: $e');
//       throw Exception('Failed to load audios');
//     }
//   }

//   Future<List<Audio>> fetchFavorites() async {
//     try {
//       final response = await http.get(
//         Uri.parse('${baseUrl}favorites/'),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         List<dynamic> data = json.decode(response.body);
//         print('Fetched favorite audios: $data'); // Debug statement
//         return data.map((item) => Audio.fromJson(item)).toList();
//       } else {
//         print(
//             'Failed to load favorite audios: ${response.statusCode} ${response.body}');
//         throw Exception('Failed to load favorite audios');
//       }
//     } catch (e) {
//       print('Error: $e');
//       throw Exception('Failed to load favorite audios');
//     }
//   }

//   Future<void> addAudio(Audio audio) async {
//     try {
//       final response = await http.post(
//         Uri.parse(baseUrl),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: json.encode(audio.toJson()),
//       );

//       if (response.statusCode == 201) {
//         print('Audio added successfully'); // Debug statement
//       } else {
//         print('Failed to add audio: ${response.statusCode} ${response.body}');
//         throw Exception('Failed to add audio');
//       }
//     } catch (e) {
//       print('Error: $e');
//       throw Exception('Failed to add audio');
//     }
//   }

//   Future<List<Audio>> searchAudios(String query) async {
//     try {
//       final response = await http.get(
//         Uri.parse('${baseUrl}search/?query=$query'),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         List<dynamic> data = json.decode(response.body);
//         print('Search results: $data'); // Debug statement
//         return data.map((item) => Audio.fromJson(item)).toList();
//       } else {
//         print(
//             'Failed to search audios: ${response.statusCode} ${response.body}');
//         throw Exception('Failed to search audios');
//       }
//     } catch (e) {
//       print('Error: $e');
//       throw Exception('Failed to search audios');
//     }
//   }
// }
