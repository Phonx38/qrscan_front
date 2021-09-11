import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/providers/ProductProvider.dart';
import 'package:qr_scan/screens/AddProductScreen.dart';
import 'package:qr_scan/screens/ProductScreen.dart';
import 'package:qr_scan/screens/AllProductsScreen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    Future qrScanner() async {
      var cameraStatus = await Permission.camera.status;
      if (cameraStatus.isGranted) {
        String qrData = await scanner.scan();
        setState(() {
          loading = true;
        });
        await productProvider.fetchProductInfo(qrData);
        setState(() {
          loading = false;
        });
        if (productProvider.product != null) {
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ProductScreen(productData: productProvider.product)));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('No record found '),
            backgroundColor: Colors.black,
            elevation: 2,
            duration: Duration(seconds: 3),
            padding: EdgeInsets.all(2),
          ));
        }
      } else {
        var isGrant = await Permission.camera.request();
        if (isGrant.isGranted) {
          String qrData = await scanner.scan();
          setState(() {
            loading = true;
          });
          await productProvider.fetchProductInfo(qrData);
          setState(() {
            loading = false;
          });
          if (productProvider.product != null) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ProductScreen(productData: productProvider.product)));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('No record found '),
              backgroundColor: Colors.black,
              elevation: 2,
              duration: Duration(seconds: 3),
              padding: EdgeInsets.all(2),
            ));
          }
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Scanner'),
        centerTitle: true,
      ),
      body: Center(
        child: loading
            ? Material(
                elevation: 10,
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black)),
                          SizedBox(height: 10),
                          Text('Searching Database',
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                    )),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          textStyle: TextStyle(
                              fontSize: 15)),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AllProductScreen()));
                      },
                      child: Text('All Products')),
                      SizedBox(height: 10),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          textStyle: TextStyle(
                              fontSize: 15)),
                      onPressed: () {
                                                Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddDataScreen()));
                      },
                      child: Text('Add Product')),
                      SizedBox(height: 10),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          textStyle: TextStyle(
                              fontSize: 15)),
                      onPressed: () async {
                        qrScanner();
                      },
                      child: Text('Scan Product QR Code')),
                ],
              ),
      ),
    );
  }
}
