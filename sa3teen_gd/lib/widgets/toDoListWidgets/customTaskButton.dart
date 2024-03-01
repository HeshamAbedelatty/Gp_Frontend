import 'package:flutter/material.dart';
import 'package:sa3teen_gd/widgets/constantsAcrossTheApp/constants.dart';

class CustomTaskButton extends StatelessWidget {
  final VoidCallback? onPressed; // Define onPressed parameter
  const CustomTaskButton({
    super.key,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(320, 48),
        backgroundColor: KPrimaryColourGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),
      child: const Text('Add Task'),
    );
  }
}
