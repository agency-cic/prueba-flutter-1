import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_prueba_1/providers/register_provider.dart';
import 'package:flutter_prueba_1/screens/result_screen.dart';
import 'package:flutter_prueba_1/ui/input_decorations.dart';
import 'package:flutter_prueba_1/widgets/screen_wrapper.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/register_model.dart';


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
                    .scaleDown,
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
late GoogleMapController controller;
LatLng _markerPosition = const LatLng(0, 0);
 XFile? _image;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cellphoneController = TextEditingController();
String _placename = '';
String _locality = '';
String _postalCode = '';
String _country = '';



  // Variable para almacenar la imagen seleccionada
 Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);



    setState(() {
      _image = image;
    });
 }

 final LatLng _center = const LatLng(4.5709, -74.2973); //coordenadas de Colombia

 void _onMapCreated(GoogleMapController controller) {
 }

Future<void> _getPlace(LatLng position) async {
 try {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    Placemark place = placemarks[0];

    setState(() {
      _placename = place.name ?? '';
      _locality = place.locality ?? '';
      _postalCode = place.postalCode ?? '';
      _country = place.country ?? '';
      _markerPosition = position; // Actualiza la ubicación del marcador
    });
 } catch (e) {
    // ignore: avoid_print
    print(e);
 }
}
 void _addRegister() {

      Register newRegister = Register(
        name: "Nombre",
        nit: 123456789,
        visitday: "2023-04-01",
        image: _image,
        address: "Dirección:$_placename, Localidad:$_locality, País:$_country",
        email: _emailController.text,
        cellphone: _cellphoneController.text, 
      );

      Provider.of<RegisterProvider>(context, listen: false).addRegister(newRegister);
    
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

    final formKey = GlobalKey<FormState>();
  
    
    return SingleChildScrollView(
      child: Column(
      children: [

        const SizedBox(height: 15),

        const Text('Foto del comercio:', style: TextStyle(color: Color.fromARGB(255, 241, 111, 90), fontSize: 15),),


        const SizedBox(height: 15),
        
        Container(
          height: 300,
          width: 300, 
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
            padding: const EdgeInsets.only(top: 10.0),
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

      const SizedBox( height: 30),



        const Text('Ubicación:', style: TextStyle(color: Color.fromARGB(255, 241, 111, 90), fontSize: 15),),

        const SizedBox(height: 15),
        

   SizedBox(
 height: 400, 
 width: double.infinity, 
 child: GoogleMap(
    onMapCreated: _onMapCreated,
    initialCameraPosition: CameraPosition(
      target: _center,
      zoom: 11.0,
    ),
    onTap: _getPlace,
    markers: {
      Marker(
        markerId: const MarkerId('selectedLocation'),
        position: _markerPosition,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    },
 ),
),


    const SizedBox(height: 15),

Row(
 children: [
    const Text('Dirección:', style: TextStyle(fontWeight: FontWeight.bold)),
    const SizedBox(width: 20),
    Flexible(
      child: Text(_placename),
    ),
 ],
),
Row(
 children: [
    const Text('Localidad:', style: TextStyle(fontWeight: FontWeight.bold)),
    const SizedBox(width: 20),
    Flexible(
      child: Text(_locality),
    ),
 ],
),
Row(
 children: [
    const Text('Postal:', style: TextStyle(fontWeight: FontWeight.bold)),
    const SizedBox(width: 20),
    Flexible(
      child: Text(_postalCode),
    ),
 ],
),
Row(
 children: [
    const Text('País:', style: TextStyle(fontWeight: FontWeight.bold)),
    const SizedBox(width: 20),
    Flexible(
      child: Text(_country),
    ),
 ],
),

   const SizedBox(height: 30),

       const Text('Información de contacto:', style: TextStyle(color: Color.fromARGB(255, 241, 111, 90), fontSize: 15),),

       Form(
        key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [

          // El primer campo de ingreso de texto del formulario será el correo electrónico 

          TextFormField(
            autocorrect: false,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'example@gmail.com',
              labelText: 'Correo electrónico *',
              prefixIcon: Icons.alternate_email_rounded
            ),
            // Realizamos la validación para que solo sean aceptados datos que luzcan como correo electrónicos
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
            controller: _cellphoneController,
            autocorrect: false,
            keyboardType: TextInputType.phone,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'Sólo números',
              labelText: 'Número de teléfono *',
              prefixIcon: Icons.call
            ),
            // Realizamos la validación para que solo sean aceptados datos que luzcan como correo electrónicos

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


                   if(_image !=null && _placename.isNotEmpty && formKey.currentState!.validate()){

                      _addRegister();

                       
                       Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => const ResultScreen()),
                       );
                   

                   } else {

                    

                      showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Todos los campos son obligatorios, por favor complétalos correctamente.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );



                   }

                   
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
