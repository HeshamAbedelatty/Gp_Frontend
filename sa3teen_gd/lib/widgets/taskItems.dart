import 'package:flutter/material.dart';
import 'package:sa3teen_gd/widgets/constants.dart';

class taskItem extends StatelessWidget {
  const taskItem({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 16),
        child: Row(
          children: [
            const Text(
              "vedios for knn",
              style: TextStyle(fontSize: 15),
            ),
            const Spacer(),
            const Text(
              "4:59 pm 2/2/2024",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            Padding(
              padding: EdgeInsets.all(0.0), // Set padding to zero
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  color: KPrimaryColourBrown,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(0.0), // Set padding to zero
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete,
                  color: KPrimaryColourBrown,
                ),
              ),
            ),
          ],
        ));
  }
}
