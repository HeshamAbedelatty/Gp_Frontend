class Group {
  final int id;
  final String title;
  final String description;
  final String type;
  final String image;
  final String? password;
  final String subject;
  final int members;

  Group({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.image,
    this.password,
    required this.subject,
    required this.members,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      image: json['image'],
      password: json['password'],
      subject: json['subject'],
      members: json['members'],
    );
  }
}

class UserGroup {
  final Group group;
  final bool isOwner;
  final bool isAdmin;

  UserGroup({
    required this.group,
    required this.isOwner,
    required this.isAdmin,
  });

  factory UserGroup.fromJson(Map<String, dynamic> json) {
    return UserGroup(
      group: Group.fromJson(json['group']),
      isOwner: json['is_owner'],
      isAdmin: json['is_admin'],
    );
  }
}
