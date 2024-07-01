// import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/groups/joinGroup/a.dart';

// class JoinGroupPage extends StatelessWidget {
//   final int groupId;
//   final String accessToken;
//   final bool isPrivate;

//   JoinGroupPage({
//     required this.groupId,
//     required this.accessToken,
//     this.isPrivate = false,
//   });

//   Future<void> _joinGroup(BuildContext context, {String? password}) async {
//     await joinGroup(
//       groupId: groupId,
//       accessToken: accessToken,
//       password: password,
//     );

//     // Show a dialog or a message after the request
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Join Group'),
//           content: Text('Successfully joined the group!'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showPasswordDialog(BuildContext context) {
//     final TextEditingController _passwordController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Enter Password'),
//           content: TextField(
//             controller: _passwordController,
//             decoration: InputDecoration(hintText: 'Password'),
//             obscureText: true,
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _joinGroup(context, password: _passwordController.text);
//               },
//               child: Text('Join'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Join Group'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             if (isPrivate) {
//               _showPasswordDialog(context);
//             } else {
//               _joinGroup(context);
//             }
//           },
//           child: Text('Join Group'),
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: JoinGroupPage(
//       groupId: 7,
//       accessToken: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw',
//       isPrivate: true, // Set to false if the group is public
//     ),
//   ));
// }
