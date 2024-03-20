import 'package:flutter/material.dart';
import 'package:flutter_prueba_1/screens/input_screen.dart';
import 'package:flutter_prueba_1/ui/input_decorations.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:collection/collection.dart';



class HomeScreen extends StatefulWidget {
   
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

  final TextEditingController nameController = TextEditingController();
  final TextEditingController nitController = TextEditingController();
  DateTime today = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  final List<DateTime> unavailableDates = [
    DateTime.utc(2024, 3, 14),
    DateTime.utc(2024, 3, 30),
  ];

  final List<Map<String, dynamic>> companiesWithAppointments = [
 {
    'name': 'Empresa A',
    'nit': '123456789',
    'appointmentDate': DateTime.utc(2024, 3, 14),
 },
 {
    'name': 'Empresa B',
    'nit': '12345',
    'appointmentDate': DateTime.utc(2024, 3, 19),
 }
    
];

  

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    void _onDaySelected(DateTime day, DateTime focusedDay){
    setState((){
      today = day;
    });
  }
   

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
      body:  SingleChildScrollView(
         child: Form(
         // key: _formKey,
          child: Column(
          children: [
            _commentsForm(),
            const SizedBox(height: 50),
            _calendar(),

            ElevatedButton(
              style: ButtonStyle(
                 backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 241, 111, 90)),
                ),
              onPressed:(){

                if (_formKey.currentState!.validate()){
                  if(unavailableDates.contains(today)){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        key: UniqueKey(),
                        content: const Text('Las fechas seleccionadas no están disponibles.'),
                        backgroundColor: Colors.red,
                      ),
                    );  
                  }else{
                    final String enteredName = nameController.text;
                    final String enteredNit = nitController.text;
                    final Map<String, dynamic>? companyWithAppointment = companiesWithAppointments.firstWhereOrNull(
                      (company) => company['name'] == enteredName && company['nit'] == enteredNit,
                    );

                    if (companyWithAppointment != null) {
                     showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        final String formattedDate = DateFormat('dd/MM/yyyy').format(companyWithAppointment['appointmentDate']);
                        return AlertDialog(
                          title: Text('Información importante'),
                          content: Text('Ya tienes una cita agendada para el $formattedDate'),
                          actions: <Widget>[
                            TextButton(child: Text('Aceptar'),
                            onPressed: () {
                              Navigator.of(context).pop(); // Cierra el AlertDialog
                            },
                            ),
                          ],
                        );
                      },
                      );
                    }else{
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const InputScreen()));
                    }
                  }
                }

              }, 
              child: const Padding(
                    padding: EdgeInsets.only(left: 50, right: 50, bottom: 10, top: 10),
                    child:  Text('Enviar', style: TextStyle(fontSize: 15, color: Colors.white)),
                  )
          )
          ]

          
         ),
          ),
      ),
    );
  }
}

class _commentsForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: double.infinity,
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                controller: nameController,
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Solo texto',
                  labelText: 'Nombre del comercio'
                ),
                validator: (value){
                  if (value == null || value.isEmpty){
                    return 'Este campo es requerido';
                  }
                  return null;
                }

              ),

              const SizedBox(height: 10),
              TextFormField(
                controller: nitController,
                
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                  hintText: '',
                  labelText: 'NIT'
                ),
                validator: (value){
                  if (value == null || value.isEmpty){
                    
                    return 'Este campo es requerido';
                    
                  }
                  return null;
                }
              ),
            ],
          )),
      ),
    );
  }
    

}

class _calendar extends StatefulWidget {

  @override
  State<_calendar> createState() => _calendarState();
}

class _calendarState extends State<_calendar> {
  void _onDaySelected(DateTime day, DateTime focusedDay){
    setState((){
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    
    return Column(
      children: [
        const Text("Agendamiento de cita"),
        const SizedBox(height: 10),
        Container(
          child: TableCalendar(
            rowHeight: 50,
            headerStyle: const HeaderStyle(formatButtonVisible: false),
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day)=> isSameDay(day, today),
            focusedDay: today,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            //locale: 'es_CO',
            onDaySelected: _onDaySelected,
            calendarStyle:   const CalendarStyle(
              
              todayDecoration:  BoxDecoration(
                color: Color.fromARGB(255, 241, 111, 90), // Cambia este color según tus preferencias
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Color.fromARGB(255, 251, 44, 44),
                shape: BoxShape.circle, // Asegúrate de que esta línea está presente
                
               
              )
            ),
            ),
        )
        ],
    );

  }
}
