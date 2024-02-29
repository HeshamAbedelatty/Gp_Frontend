import 'package:flutter/material.dart';
import 'package:sa3teen_gd/widgets/constantsAcrossTheApp/constants.dart';
// import 'package:sa3teen_gd/widgets/feild.dart';
// import 'package:sa3teen_gd/Pages/signUpPage.dart';
// import 'package:sa3teen_gd/widgets/UserModel.dart';

class toDoListPageold extends StatelessWidget {
  toDoListPageold();
  static String id = "ToDoList";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: KPrimaryColour,
          appBar: AppBar(
            title: Center(child: Text('ToDoList')),
            backgroundColor: Color(0xFF3C8243),
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                // Add your leading button onPressed functionality here
                print('Menu button pressed');
              },
            ),),
          body: ListView(
            children: [
              SizedBox(height: 20),
              Text('studying:',style: TextStyle(fontSize: 20),),
            
            ],
          )),
    );
  }
}














  // Container(
  //               width: 200, // Set width of the container
  //               height: 150, // Set height of the container
  //               decoration: const BoxDecoration(
  //                 borderRadius: BorderRadius.only(
  //                   bottomLeft: Radius.circular(
  //                       30.0), // Set the bottom-left corner to be rounded
  //                   // bottomRight: Radius.circular(30.0), // Set the bottom-right corner to be rounded
  //                 ),
  //                 color:
  //                     Color(0xFF3C8243), // Set color of the container to green)
  //               ),
  //               child: Text(
  //                 'ToDoList',
  //                 style: TextStyle(
  //                   color: Color.fromARGB(255, 255, 255, 255), // Set text color to white
  //                   fontSize: 20,
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               width: 200, // Set width of the container
  //               height: 500, // Set height of the container
  //               decoration: const BoxDecoration(
  //                 borderRadius: BorderRadius.only(
  //                   topRight: Radius.circular(
  //                       30.0),
  //                   // bottomLeft: Radius.circular(
  //                   //     30.0), // Set the bottom-left corner to be rounded
  //                   // bottomRight: Radius.circular(30.0), // Set the bottom-right corner to be rounded
  //                 ),
  //                 color:
  //                     Color.fromARGB(255, 207, 222, 208), // Set color of the container to green)
  //               ),
  //               child: Text(
  //                 'This is a green container',
  //                 style: TextStyle(
  //                   color: Color(0xFF3C8243), // Set text color to white
  //                   fontSize: 20,
  //                 ),
  //               ),
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 // Text(
  //                 //   'home page',
  //                 //   style: TextStyle(
  //                 //     fontSize: 35,
  //                 //     // fontWeight: FontWeight.bold,
  //                 //     color: Colors.black,
  //                 //   ),
  //                 // ),
  //                 // Text('home page'),
  //               ],
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 // Image.asset(
  //                 //   'lib/assets/icons/treeCupAltered.png',
  //                 //   width: 280,
  //                 //   height: 280,
  //                 // )
  //               ],
  //             ),