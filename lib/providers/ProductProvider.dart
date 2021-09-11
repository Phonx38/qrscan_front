import 'package:flutter/cupertino.dart';
import 'package:qr_scan/models/Product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  Product _product;
  Product get product => _product;
  String url = "https://qrscangen.herokuapp.com/";

  void fetchProductInfo(productID) async {
    final productURL = Uri.parse(url + 'products/$productID' + '/?format=json');
    final response = await http.get(productURL);
    print(productURL);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      _product = Product.fromJson(data);
      notifyListeners();
    } else {
      _product = null;
      notifyListeners();
    }
  }

  Future<List<Product>> fetchProducts() async {
    final allProductsUrl = Uri.parse(url + 'products' + '/?format=json');
    final response = await http.get(allProductsUrl);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => new Product.fromJson(data)).toList();
      notifyListeners();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<bool> createProduct(String name, String price) async {
    final response = await http.post(
      Uri.parse(url + 'add-product' + '/?format=json'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'product_name': name,
        'price': price,
      }),
    );
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return true;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create product.');
    }
  }
}
