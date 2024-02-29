import 'package:flutter/material.dart';
import 'package:sa3teen_gd/widgets/constantsAcrossTheApp/constants.dart';

class checkBox extends StatefulWidget {
  const checkBox({super.key});
  @override
  State<checkBox> createState() => _checkBox();
}

class _checkBox extends State<checkBox> {
  @override
  bool checked = false;
  Widget build(BuildContext context) {
    return Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.padded, // Increase tap target size

      
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),//side: BorderSide(color: Colors.cyan,width: 100
     // shape: CircleBorder(side: BorderSide(width: 27),),
      splashRadius: BorderSide.strokeAlignInside,
      value: checked,
      tristate: true,
      onChanged: (bool? value) {
        setState(() {
          checked = value ?? false;
        });
      },
      activeColor: KPrimaryColourGreen,
    );
  }
}
// CheckboxListTile(
    //     title: Text("watch knn vedios"),
    //     secondary: Icon(Icons.edit),
    //     controlAffinity: ListTileControlAffinity.platform,
    //     value: checked,
    //     onChanged: (bool? value) {
    //       setState(() {
    //         checked = value ??false;
    //       });
    //     },activeColor: KPrimaryColourGreen,);
