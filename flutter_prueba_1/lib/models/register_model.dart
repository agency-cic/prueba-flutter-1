import 'dart:io';

class Register { 

  final String text;
  final String timestamp;
  final File? image;
  final File? camera;
  final String ubication;
  final String email;
  final int cellphone;
 

  Register({required this.text, required this.timestamp, required this.image, required this.camera, required this. ubication, required this.email, required this.cellphone});
  

  Map<String, dynamic> toMap() {
    return {
      "text": text,
      "time": timestamp,
      "image": image,
      "camera": camera,
      "ubication": ubication,
      "email": email,
      "cellphone": cellphone,
   
    };
  }
}