import 'package:flutter/material.dart';
import 'package:sa3teen_gd/widgets/constantsAcrossTheApp/constants.dart';

class customAppBar extends StatelessWidget {
  const customAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration( color: KPrimaryColourGreen,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
      height: 125,
      //width: 50,
      
      padding:const EdgeInsets.symmetric(horizontal: 12),
     
      
      child: Row(
        children: [
          const Icon(Icons.person,color: Colors.white,),
          Spacer(),
          const Text(
            "ToDoList",
            style: TextStyle(fontSize: 20,color: Colors.white),
          ),
          Spacer(),
          Container(
            height: 27,
            width: 27,
            color: KPrimaryColourGreen,
            child:const Center(
              child: Icon(Icons.search,color:Colors.white,),
            ),
          ),
          Container( 
            height: 27,
            width: 27,
            color: KPrimaryColourGreen,
            child:const Center(
              child: Icon(Icons.menu,color: Colors.white,),
            ),
          ),
        ],
      ),
    );
  }
}
