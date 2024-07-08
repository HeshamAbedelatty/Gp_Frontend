import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/APIsSalma/listGroup/ModellistGroups.dart';

class GroupProvider with ChangeNotifier {
  List<listGroupsModel> _groups = [];
  bool _isLoading = false;

  List<listGroupsModel> get groups => _groups;
  bool get isLoading => _isLoading;

  final getAllGroups _apiService = getAllGroups();

  Future<void> searchGroupsByTitle(String title, String accessToken) async {
    _isLoading = true;
    notifyListeners();

    try {
      _groups = await _apiService.searchGroupsByTitle(title, accessToken);
    } catch (error) {
      print(error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
