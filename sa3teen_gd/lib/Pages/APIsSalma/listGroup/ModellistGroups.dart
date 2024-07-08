// import 'package:gp_screen/Pages/APIsSalma/listGroup/getAPIListGroups.dart';
// import 'package:gp_screen/Services/API_services.dart';
// class listGroupsModel {
//   final dynamic id;
//   final String title;
//   final String description;
//   final String type;
//   final String? image;
//   final String? password;
//   final String subject;
//   final int members;
//   final bool has_joined;
//
//   listGroupsModel(
//       {required this.id,
//       required this.title,
//       required this.subject,
//       required this.description,
//       required this.image,
//       required this.type,
//       required this.password,
//       required this.members,
//       required this.has_joined,
//       });
//
//   factory listGroupsModel.fromJson(jsonData) {
//     return listGroupsModel(
//       id: jsonData['id'],
//       title: jsonData['title'],
//       subject: jsonData['subject'],
//       type: jsonData['type'],
//       description: jsonData['description'],
//       image: jsonData['image'],
//       password: jsonData['password'],
//       members: jsonData['members'],
//       has_joined:jsonData['has_joined'],
//     );
//   }
//
//   @override
//   String toString() {
//     return "id='$id', title='$title', subject='$subject', description='$description', image='$image', type='$type', password='$password', members='$members',has_joined='$has_joined'";
//   }
// }
//
// class getAllGroups {
//   Future<List<listGroupsModel>> getAllGroupsList_recommendation(String url,String accessToken) async {
//     Map<String, String> headers = {
//       'Authorization': 'Bearer $accesstokenfinal',
//     };
//
//     List<dynamic> data = await Api().get(
//       url: '$finalurlforall/$url',
//       headers: headers,
//     );
//
//     List<listGroupsModel> productsList = [];
//     for (int i = 0; i < data.length; i++) {
//       productsList.add(
//         listGroupsModel.fromJson(data[i]),
//       );
//     }
//
//     // Print each object using the overridden toString method
//     for (var product in productsList) {
//       print(product);
//     }
//
//     return productsList;
//   }
//   Future<List<listGroupsModel>> searchGroupsByTitle(String title,String accessToken) async {
//     Map<String, String> headers = {
//       'Authorization': 'Bearer $accesstokenfinal',
//     };
//
//     List<dynamic> data = await Api().get(
//       url: '$finalurlforall/groups/search/${title}/',
//       headers: headers,
//     );
//
//     List<listGroupsModel> productsList = [];
//     for (int i = 0; i < data.length; i++) {
//       productsList.add(
//         listGroupsModel.fromJson(data[i]),
//       );
//     }
//
//     // Print each object using the overridden toString method
//     for (var product in productsList) {
//       print(product);
//     }
//
//     return productsList;
//   }
// }