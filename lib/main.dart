import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/providers/ProductProvider.dart';
import 'package:qr_scan/screens/HomeScreen.dart';
import 'package:qr_scan/screens/SplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return ChangeNotifierProvider<ProductProvider>(
      create: (context)=>ProductProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          
          primaryColor: Colors.black,
        ),
        home: SplashScreen()
      ),
    );
  }
}
