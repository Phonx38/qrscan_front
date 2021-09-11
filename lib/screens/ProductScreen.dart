import 'package:flutter/material.dart';
import 'package:qr_scan/models/Product.dart';

class ProductScreen extends StatefulWidget {
  Product productData;

  ProductScreen({this.productData});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                widget.productData.qrImage,
                fit: BoxFit.fill,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes
                          : null,
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Product Name :',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text('${widget.productData.name}')
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Product Price :',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text('${widget.productData.price}')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
