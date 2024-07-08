import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/groups/Materialsscreen/Model/ModelMaterial.dart';
import 'package:gp_screen/Services/API_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class MaterialProvider with ChangeNotifier {
  List<MaterialModel> _materials = [];
  String? _errorMessage;
  Timer? _debounce;

  List<MaterialModel> get materials => _materials;
  String? get errorMessage => _errorMessage;

  void fetchMaterials(int groupId, String title, String token) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      final url = Uri.parse(
          '$finalurlforall/groups/$groupId/materials/search/$title/');
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $accesstokenfinal',
      });

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        if (response.headers['content-type']?.contains('application/json') ==
            true) {
          final List<dynamic> data = json.decode(response.body);
          _materials =
              data.map((json) => MaterialModel.fromJson(json)).toList();
          _errorMessage = null;
        } else {
          _materials = [];
          _errorMessage = 'Invalid response format';
        }
      } else if (response.statusCode == 403) {
        _materials = [];
        _errorMessage = response.body;
      }
      notifyListeners();
    });
  }
}
