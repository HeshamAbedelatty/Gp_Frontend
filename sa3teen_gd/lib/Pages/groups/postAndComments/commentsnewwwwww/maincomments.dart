import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/groups/postAndComments/commentsnewwwwww/CommentsProvider.dart';
import 'package:gp_screen/Pages/groups/postAndComments/commentsnewwwwww/uicomments.dart';
import 'package:provider/provider.dart';
// import 'comments_provider.dart';
// import 'comments_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CommentsProvider('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'),
      child: MaterialApp(
        home: CommentsScreen(groupId: 7, postId: 4),
      ),
    );
  }
}
