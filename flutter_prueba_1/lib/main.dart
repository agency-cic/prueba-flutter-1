import 'package:flutter/material.dart';
import 'package:flutter_prueba_1/providers/register_provider.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';




void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  // Este widget es la raíz de la aplicación

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [

      
        ChangeNotifierProvider(create: (_) => RegisterProvider(),lazy: false),

  
      ],
      child: const MyApp(),
      );
      }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 241, 111, 90)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
