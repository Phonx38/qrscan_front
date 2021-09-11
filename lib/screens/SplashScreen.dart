import 'package:flutter/material.dart';
import 'package:qr_scan/screens/HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  String url =
      'https://i.pinimg.com/originals/e4/af/9f/e4af9f0025a8ce68bee2cf5a1360a501.gif';
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 8), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/qr.gif'),
              SizedBox(height: 20),
              Text('Product QR Scanner',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),)
            ],
          ),
        ));
  }
}
