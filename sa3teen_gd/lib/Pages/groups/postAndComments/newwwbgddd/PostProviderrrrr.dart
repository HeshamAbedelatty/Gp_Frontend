import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/groups/postAndComments/newwwbgddd/ApiServicepostsssss.dart';
import 'package:gp_screen/Pages/groups/postAndComments/newwwbgddd/PostModellll.dart';
// import 'models/post.dart';
// import 'services/api_service.dart';

class PostProvider with ChangeNotifier {
  List<Post> _posts = [];
  bool _isLoading = false;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;

  Future<void> fetchPosts(int groupId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _posts = await ApiService().getPosts(groupId,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU');
    } catch (e) {
      // Handle the error appropriately
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
