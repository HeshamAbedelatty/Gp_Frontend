class ProfileModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String phoneNumber;
  final String faculty;
  final String? dateOfBirth;
  final String image;
  final double rate;

  ProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.faculty,
    this.dateOfBirth,
    required this.image,
    required this.rate,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      username: json['username'],
      phoneNumber: json['phone_number'],
      faculty: json['faculty'],
      dateOfBirth: json['date_of_birth'],
      image: json['image'],
      rate: json['rate'].toDouble(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'username': username,
      'phone_number': phoneNumber,
      'faculty': faculty,
      'date_of_birth': dateOfBirth,
      'image': image,
      'rate': rate,
    };
  }

  @override
  String toString() {
    return "id='$id', firstName='$firstName', lastName='$lastName', email='$email', username='$username', phoneNumber='$phoneNumber', faculty='$faculty', dateOfBirth='$dateOfBirth', image='$image', rate='$rate'";
  }
}
