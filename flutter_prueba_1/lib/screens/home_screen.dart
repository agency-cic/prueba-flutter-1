import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 0,
        toolbarHeight: 50,
        title: const Text('Registro de Comercio', style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 241, 111, 90),
         leading: Container(
       
            width: 150, // Ancho del contenedor
            height: 150, // Altura del contenedor
            decoration: BoxDecoration(
              shape: BoxShape.circle, // Establece la forma como círculo
              border: Border.all(
                // Agrega un borde al contenedor
                color: Colors.white, // Color del borde
                width: 1.0, // Ancho del borde
              ),
              //Programación de la imagen del logo
              image: const DecorationImage(
                fit: BoxFit
                    .scaleDown, // Ajusta la imagen para cubrir el contenedor
                image: AssetImage('assets/healthcare.png'), // Ruta de la imagen
              ),
            ),
          ),
        

      ),
      body: const Center(
         child: Text('HomeScreen'),
      ),
    );
  }
}