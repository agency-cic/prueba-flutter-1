import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_prueba_1/providers/login_form_provider.dart';
import 'package:flutter_prueba_1/ui/input_decorations.dart';
import 'package:flutter_prueba_1/widgets/screen_wrapper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class InputScreen extends StatefulWidget {
   
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  
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
      body: const ScreenWrapper(
          headerColor:  Color.fromARGB(255, 255, 255, 255),
          headerWidget: HeaderText(),
          bodyWidget: Formulario(),
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

        Text('Ingrese datos adicionales', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
      ],
    );
  }
}

class Formulario extends StatefulWidget {
  

  const Formulario({Key? key}) : super(key: key);

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
 XFile? _image; // Variable para almacenar la imagen seleccionada
 Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    setState(() {
      _image = image;
    });
 }

 
Future<dynamic> options(BuildContext context) {
 return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        contentPadding: const EdgeInsets.all(0),
        content: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                 await _pickImage(ImageSource.camera);
                 // ignore: use_build_context_synchronously
                 Navigator.of(context).pop();
                },
                child: Container(
                 padding: const EdgeInsets.all(20),
                 decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: Color.fromARGB(255, 241, 111, 90)),
                    ),
                 ),
                 child: const Row(
                    children: [
                      Expanded(child: Text('Tomar una foto')),
                      Icon(Icons.camera_alt_outlined, color: Color.fromARGB(255, 241, 111, 90)),
                    ],
                 ),
                ),
              ),
              InkWell(
                onTap: () async {
                 await _pickImage(ImageSource.gallery);
                 // ignore: use_build_context_synchronously
                 Navigator.of(context).pop();
                },
                child: Container(
                 padding: const EdgeInsets.all(20),
                 decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: Color.fromARGB(255, 241, 111, 90)),
                    ),
                 ),
                 child: const Row(
                    children: [
                      Expanded(child: Text('Seleccionar desde galería')),
                      Icon(Icons.image, color: Color.fromARGB(255, 241, 111, 90)),
                    ],
                 ),
                ),
              ),
              InkWell(
                onTap: () {
                 Navigator.of(context).pop();
                },
                child: Container(
                 padding: const EdgeInsets.all(20),
                 child: const Row(
                    children: [
                      Expanded(child: Text('Cancelar')),
                      Icon(Icons.cancel_outlined, color: Colors.red),
                    ],
                 ),
                ),
              ),
            ],
          ),
        ),
      );
    },
 );
}

  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<FormProvider>(context);
    
    return SingleChildScrollView(
      child: Column(
      children: [

        const SizedBox(height: 15),

        const Text('Foto del comercio', style: TextStyle(color: Color.fromARGB(255, 241, 111, 90) ),),


        const SizedBox(height: 15),
        
        Container(
          height: 300,
          width: 300, // Ajusta el tamaño según sea necesario
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 241, 111, 90),
              width: 1
            )
          ),
          child:  _image == null
              ? const Center(child: Text('No hay imagen seleccionada', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey),))
              : Image.file(
                 File(_image!.path),
                 fit: BoxFit.cover,
                ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0), // Ajusta el padding según sea necesario
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                 onPressed: () {
                    options(context);
                 },
                 child: const Text('Seleccionar imagen'),
                ),
                const SizedBox(width: 10), // Espacio entre los botones
                ElevatedButton(
                  onPressed: _image != null ? () {
                  setState(() {
                  _image = null; // Esto borra la imagen seleccionada
                   });
                   } : null,
                 child: const Text('Borrar'),
                ),

                
              ],
            ),
          ),
        ),

      const SizedBox( height: 20),


       Form(
      key: registerForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [

          // El primer campo de ingreso de texto del formulario será el correo electrónico 

          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'example@gmail.com',
              labelText: 'Correo electrónico',
              prefixIcon: Icons.alternate_email_rounded
            ),
            // Realizamos la validación para que solo sean aceptados datos que luzcan como correo electrónicos

            onChanged: (value) => registerForm.email =value,
            validator: (value) {
              String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp  = RegExp(pattern);

              return regExp.hasMatch(value ?? '')
              ? null
              : 'El valor ingresado no luce como un correo';

            },
          ),

          const SizedBox( height: 20),

            TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.phone,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'Sólo números',
              labelText: 'Número de teléfono',
              prefixIcon: Icons.call
            ),
            // Realizamos la validación para que solo sean aceptados datos que luzcan como correo electrónicos

            onChanged: (value) => registerForm.cellphone =value,
              validator: (value) {
                if (value != null && value.length == 10) return null;
                return 'El número de teléfono debe tener 10 digitos'; 
       
            },
          ),
                      
                    ],
                  )
                
                ),


              
            const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                style: ButtonStyle(
                 backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 241, 111, 90)), 
                 
                ),
                 
                  
                  onPressed: (){

                   
                  },
                
                  child: const Padding(
                    padding: EdgeInsets.only(left: 50, right: 50, bottom: 10, top: 10),
                    child:  Text('Enviar', style: TextStyle(fontSize: 15, color: Colors.white)),
                  )
                 
                  
                )
              ),

                   const SizedBox(height: 30),

    

      ]
      )
    );
  }
}
