import 'package:flutter/material.dart';
import 'package:sa3teen_gd/widgets/constants.dart';

class taskItem extends StatelessWidget {
  const taskItem({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("vedios for knn",style: TextStyle(fontSize: 15),),
        Spacer(),
        Text("4:59 pm 2/2/2024",style: TextStyle(color: Colors.grey),),
        IconButton(onPressed: (){}, icon:  Icon(
          Icons.edit,
          color: KPrimaryColourBrown,
        ),
          ),
  IconButton(onPressed: (){}, icon:  Icon(
          Icons.delete,
          color: KPrimaryColourBrown,
        ),
          ),


      
      ],
    );
  }
}
