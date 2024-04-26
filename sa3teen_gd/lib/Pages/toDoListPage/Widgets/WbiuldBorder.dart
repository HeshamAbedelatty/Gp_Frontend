import 'package:flutter/material.dart';

OutlineInputBorder biuldBorder([color]) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: color ?? Color.fromARGB(255, 169, 172, 169),
    ),
  );
}
