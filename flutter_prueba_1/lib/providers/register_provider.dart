import 'package:flutter/material.dart';
import 'package:flutter_prueba_1/models/register_model.dart';

class PostProvider with ChangeNotifier {
 final List<Register> _registers = [];

 List<Register> get registers => _registers;

 void addPost(Register register) {
    _registers.add(register);
    notifyListeners(); 
 }
}