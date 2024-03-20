
import 'package:image_picker/image_picker.dart';

class Register { 

  final String name;
  final String nit;
  final String visitday;
  final XFile? image;
  final String address;
  final String email;
  final String cellphone;
 

  Register({required this.name, required this.nit, required this.visitday, required this.image, required this.address, required this.email, required this.cellphone});
  

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "nit": nit,
      "visitday": visitday,
      "image": image,
      "address": address,
      "email": email,
      "cellphone": cellphone,
   
    };
  }
}