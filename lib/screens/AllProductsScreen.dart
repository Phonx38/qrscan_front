import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/models/Product.dart';
import 'package:qr_scan/providers/ProductProvider.dart';
import 'package:qr_scan/screens/ProductScreen.dart';

class AllProductScreen extends StatefulWidget {
  @override
  _AllProductScreenState createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products'),
      ),
      body: Center(
        child: FutureBuilder<List<Product>>(
          future: productProvider.fetchProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> data = snapshot.data;
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){
                         Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ProductScreen(productData: data[index])));
                      },
                      child: ListTile(
                        leading: Container(
                          width:MediaQuery.of(context).size.width * 0.2,
                          child: Image.network(
                            data[index].qrImage,
                            fit: BoxFit.fill,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Product Name :',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10),
                            Text('${data[index].name}')
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Product Name :',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10),
                            Text('${data[index].price}')
                          ],
                        ),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
