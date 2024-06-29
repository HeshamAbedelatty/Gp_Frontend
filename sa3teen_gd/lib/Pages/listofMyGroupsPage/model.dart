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
      required this.type
      ,required this.password,required this.members,});

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
}

//       // "id": id,
//       "title": title,
//       "description": description,
//       "type": "private",
//       "image": null,
//       "password": "hesham2002",
//       "subject": "Computer Science",
//       // "members": 1

class RatingModel {
  final dynamic rate;
  final int count;

  RatingModel({required this.rate, required this.count});

  factory RatingModel.fromJson(jsonData) {
    return RatingModel(rate: jsonData['rate'], count: jsonData['count']);
  }
}
