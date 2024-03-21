import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_prueba_1/models/register_model.dart';
import 'package:flutter_prueba_1/providers/register_provider.dart';
import 'package:flutter_prueba_1/screens/home_screen.dart';
import 'package:flutter_prueba_1/widgets/screen_wrapper_result.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatelessWidget {
   
  const ResultScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
       final registerProvider = Provider.of<RegisterProvider>(context);

    return Scaffold(
      appBar: AppBar(
        
        elevation: 0,
        toolbarHeight: 50,
        title:   const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
             Text('Registro de Comercio', style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),),
             Text('Secretaría de Salud', style: TextStyle(color: Colors.white, fontSize: 16)),
            
            ],
          ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 138, 189),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        },
        heroTag: null,
        backgroundColor: const Color.fromARGB(255, 0, 138, 189),
        child: const Icon(
          Icons.house_rounded, color: Colors.white
        ),
      ),
      body: ScreenWrapperResult(
        headerColor: const Color.fromARGB(255, 0, 138, 189),
        headerWidget: const HeaderText(),
        bodyWidget: Registros(registerProvider: registerProvider) ,
      )
         
    );
  }
}

class HeaderText extends StatelessWidget {

  const HeaderText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 15),

        Text('Lista de registrados', style: TextStyle(fontSize: 20, color: Colors.white))
      ],
    );
  }
}

class Registros extends StatelessWidget {
  final RegisterProvider registerProvider;


  const Registros({Key? key, required this.registerProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
   List<Register> registers = registerProvider.registers;


    if (registers.isEmpty) {
      return const Center(
        child: Text("No hay registros"),
      );
    }


    return  ListView.builder(
      itemCount: registers.length,
      itemBuilder: (_, int index) {
        return ListCard(
            index: index,
            individualRegister: registers[index],
            registerProvider: registerProvider);
      },
    );
    
  
  }
}


class ListCard extends StatelessWidget {
 final int index;
 final Register individualRegister;
 final RegisterProvider registerProvider;

 const ListCard({
    Key? key,
    required this.index,
    required this.individualRegister,
    required this.registerProvider,
 }) : super(key: key);

 @override
 Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      color: index % 2 == 0 ? Colors.white : const Color.fromRGBO(243, 242, 243, 1.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          // Nombre del comercio
          _buildCardItem(
            title: 'Nombre del comercio',
            value: individualRegister.name,
          ),
          // NIT
          _buildCardItem(
            title: 'NIT',
            value: individualRegister.nit.toString(),
          ),
          // Agendamiento de cita
          
          _buildCardItem(
            title: 'Agendamiento de cita',
            value: individualRegister.visitday,
          ),
          // Ubicación
          _buildCardItem(
            title: 'Ubicación',
            value: individualRegister.address,
          ),
          // Correo electrónico
          _buildCardItem(
            title: 'Correo electrónico',
            value: individualRegister.email,
          ),
          // Número celular
          _buildCardItem(
            title: 'Número celular',
            value: individualRegister.cellphone.toString(),
          ),
          // Espacio para la imagen
          if (individualRegister.image != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Image.file(
                File(individualRegister.image!.path),
                fit: BoxFit.cover,
                width: 200,
              ),
            ),
    
        ],
      ),
    );
 }

 Widget _buildCardItem({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color.fromARGB(255, 0, 138, 189)),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
 }
}

