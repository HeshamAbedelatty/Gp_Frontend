
class UserModel {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String password;
  String confirmPassword;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
  });
}

List<UserModel> persons = [];

// Function to add a new user
void addUser(String firstName, String lastName, String email,
    String phoneNumber, String password, String confirmPassword) {
  UserModel newUser = UserModel(
    firstName: firstName,
    lastName: lastName,
    email: email,
    phoneNumber: phoneNumber,
    password: password,
    confirmPassword: confirmPassword,
  );
  persons.add(newUser);
}


//check if the user exists
bool checkIfUserExists(List<UserModel> users, String email) {
  for (UserModel user in users) {
    if (user.email == email) {
      return true; // User with the given email exists
    }
  }
  return false; // User with the given email does not exist
}

//check if the password is right
bool checkIfPasswordRight(List<UserModel> users, String password) {
  for (UserModel user in users) {
    if (user.password == password) {
      return true; // User with the given email exists
    }
  }
  return false; // User with the given email does not exist
}






//List<String> existingEmails = ['salma@example.com', 'sara@example.com'];
// bool checkIfUserExists(String email) {
//   return existingEmails.contains(email);
// }


  // // Static method to create a default instance
  // static UserModel empty() {
  //   return UserModel(
  //     firstName: '',
  //     lastName: '',
  //     email: '',
  //     phoneNumber: '',
  //     password: '',
  //     confirmPassword: '',
  //   );
  // }





//   bool checkIfUserExistss(String email) {
//   return persons.contains(email);
// }
//     UserModel user1 = UserModel(
//     firstName: "John",
//     lastName: "Doe",
//     email: "john@example.com",
//     password: "password123",
//     confirmPassword: "password123",
//   );

//   UserModel user2 = UserModel(
//     firstName: "Jane",
//     lastName: "Doe",
//     email: "jane@example.com",
//     password: "password456",
//     confirmPassword: "password456",
//   );
//   UserModel user3 = UserModel(
//     firstName: "salma",
//     lastName: "mourad",
//     email: "salma@example.com",
//     password: "1234",
//     confirmPassword: "1234",
//   );
   //persons.add(user1);

  // Adding a new user at runtime
  // addUser('John', 'Doe', 'john.doe@example.com', 'password123', 'password123');

  // Print the list of users
  // for (UserModel user in users) {
  //   print('User: ${user.firstName} ${user.lastName} (${user.email})');
  // }








// List<UserModel> people =[];


//   UserModel user1 = UserModel(
//     firstName: "John",
//     lastName: "Doe",
//     email: "john@example.com",
//     password: "password123",
//     confirmPassword: "password123",
//   );

//   UserModel user2 = UserModel(
//     firstName: "Jane",
//     lastName: "Doe",
//     email: "jane@example.com",
//     password: "password456",
//     confirmPassword: "password456",
//   );
//   UserModel user3 = UserModel(
//     firstName: "salma",
//     lastName: "mourad",
//     email: "salma@example.com",
//     password: "1234",
//     confirmPassword: "1234",
//   );
// people.add(user1);
// //   people.add(user2);




//  // Now you can access the list of users and their properties
//   for (var user in users) {
//     print("User: ${user.firstName} ${user.lastName}");
//     print("Email: ${user.email}");
//     print("Password: ${user.password}");
//     print("Confirm Password: ${user.confirmPassword}");
//     print("");
//   }


// bool checkIfUserExists(String email) {

  // Here you would perform the actual check against your storage mechanism
  // This could involve querying a database, making an API call, etc.
  // For the sake of example, let's assume a simple list of existing emails
  

//   return existingEmails.contains(email);
// }