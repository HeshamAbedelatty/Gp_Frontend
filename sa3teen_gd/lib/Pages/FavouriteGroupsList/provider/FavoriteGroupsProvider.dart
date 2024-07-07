// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/GroupPostAndCommentPage/Pages/FinalGroupPostsPage.dart';

class FavoriteGroupsProvider extends ChangeNotifier {
  List<GroupPage> _favoriteGroups = [];

  List<GroupPage> get favoriteGroups => _favoriteGroups;

  void toggleFavorite(GroupPage group) {
    if (_favoriteGroups.contains(group)) {
      _favoriteGroups.remove(group);
    } else {
      _favoriteGroups.add(group);
    }
    notifyListeners();
  }

  bool isFavorite(GroupPage group) {
    return _favoriteGroups.contains(group);
  }
}
