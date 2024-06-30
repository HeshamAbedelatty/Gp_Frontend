import 'package:gp_screen/Pages/listofMyGroupsPage/getAPI.dart';
class listGroupsModel {
  final dynamic id;
  final String title;
  final String description;
  final String type;
  final String? image;
  final String? password;
  final String subject;
  final int members;

  listGroupsModel(
      {required this.id,
      required this.title,
      required this.subject,
      required this.description,
      required this.image,
      required this.type,
      required this.password,
      required this.members,});

  factory listGroupsModel.fromJson(jsonData) {
    return listGroupsModel(
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

class getAllGroups {
  Future<List<listGroupsModel>> getAllProducts(String accessToken) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
    };

    List<dynamic> data = await Api().get(
      url: 'http://10.0.2.2:8000/groups/',
      headers: headers,
    );

    List<listGroupsModel> productsList = [];
    for (int i = 0; i < data.length; i++) {
      productsList.add(
        listGroupsModel.fromJson(data[i]),
      );
    }
    
    // Print each object using the overridden toString method
    for (var product in productsList) {
      print(product);
    }

    return productsList;
  }
}