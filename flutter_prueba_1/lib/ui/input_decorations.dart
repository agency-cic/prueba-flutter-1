import 'package:flutter/material.dart';


class InputDecorations { //clase definida para el diseño e implementación de entradas de texto.

  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon
  }){
    return InputDecoration(
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color:  Color.fromARGB(255, 241, 111, 90)
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color:  Color.fromARGB(255, 241, 111, 90),
          width: 2
        ),
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.grey
      ),
      prefixIcon: prefixIcon != null
      ? const Icon(Icons.alternate_email_sharp, color: Colors.deepPurple,)
      : null
    );
  }



}