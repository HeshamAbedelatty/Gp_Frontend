class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String phoneNumber;
  final String faculty;
  final String? dateOfBirth;
  String? image;
  final double rate;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.faculty,
    this.dateOfBirth,
    this.image,
    required this.rate,
  });

  Map<String, dynamic> toMap() {
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
}
