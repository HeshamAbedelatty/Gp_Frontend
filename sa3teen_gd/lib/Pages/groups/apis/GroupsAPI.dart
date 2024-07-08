import 'package:gp_screen/Pages/listofMyGroupsPage/getAPI.dart';
import 'package:gp_screen/Services/API_services.dart';

class ListGroupsModel {
  final dynamic id;
  final String title;
  final String description;
  final String type;
  final String? image;
  final String? password;
  final String subject;
  final int members;

  ListGroupsModel({
    required this.id,
    required this.title,
    required this.subject,
    required this.description,
    required this.image,
    required this.type,
    required this.password,
    required this.members,
  });

  factory ListGroupsModel.fromJson(jsonData) {
    return ListGroupsModel(
      id: jsonData['id'],
      title: jsonData['title'],
      subject: jsonData['subject'],
      type: jsonData['type'],
      description: jsonData['description'],
      image: jsonData['image'],
      password: jsonData['password'],
      members: jsonData['members'],
    );
  }

  @override
  String toString() {
    return "id='$id', title='$title', subject='$subject', description='$description', image='$image', type='$type', password='$password', members='$members'";
  }
}

class GroupService {
  Future<List<ListGroupsModel>> getAllGroups(String accessToken) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $accesstokenfinal',
    };

    List<dynamic> data = await Api().get(
      url: 'http://10.0.2.2:8000/groups/',
      headers: headers,
    );

    List<ListGroupsModel> groupsList = [];
    for (int i = 0; i < data.length; i++) {
      groupsList.add(
        ListGroupsModel.fromJson(data[i]),
      );
    }

    // Print each object using the overridden toString method
    for (var group in groupsList) {
      print(group);
    }

    return groupsList;
  }

  // Future<ListGroupsModel> getGroupById(String accessToken, int id) async {
  //   Map<String, String> headers = {
  //     'Authorization': 'Bearer $accessToken',
  //   };

  //   dynamic data = await Api().get(
  //     url: 'http://127.0.0.1:8000/groups/$id/',
  //     headers: headers,
  //   );

  //   ListGroupsModel group = ListGroupsModel.fromJson(data);

  //   // Print the retrieved object using the overridden toString method
  //   print(group);

  //   return group;
  // }
  Future<ListGroupsModel> getGroupById(String accessToken, int id) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $accesstokenfinal',
    };

    dynamic data = await Api().anotherget(
      url: 'http://10.0.2.2:8000/groups/$id/',
      headers: headers,
    );

    ListGroupsModel group = ListGroupsModel.fromJson(data);

    // Print the retrieved object using the overridden toString method
    print(group);

    return group;
  }
}


