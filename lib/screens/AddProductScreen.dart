import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/providers/ProductProvider.dart';

class AddDataScreen extends StatefulWidget {
  @override
  _AddDataScreenState createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool result;

  Future<void> _showMyDialog(responseTitle,responseText) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title:  Text('$responseTitle'),
        content: SingleChildScrollView(
          child: ListBody(
            children:  <Widget>[
              Text('$responseText'),
            ],
          ),
        ),
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
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add Products'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 30, bottom: 5),
                    child: Text(
                      'Add Product',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 30),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: 20, right: 20, top: 0, bottom: 0),
                          height: 100,
                          child: TextFormField(
                            controller: myController1,
                            validator: (text) {
                              if (!(text.isNotEmpty)) {
                                return "Name should not be empty!";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                filled: true,
                                alignLabelWithHint: true,
                                hintText: 'Product Name',
                                border: InputBorder.none,
                                focusColor: Colors.blueGrey,
                                contentPadding: EdgeInsets.all(10)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 20, right: 20, top: 0, bottom: 0),
                          height: 100,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]'))
                            ],
                            controller: myController2,
                            validator: (text) {
                              if (!(text.isNotEmpty)) {
                                return "Price should not be empty!";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                filled: true,
                                alignLabelWithHint: true,
                                hintText: 'Product Price',
                                border: InputBorder.none,
                                focusColor: Colors.blueGrey,
                                contentPadding: EdgeInsets.all(10)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 20, right: 20, top: 0, bottom: 10),
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: loading
                              ? Center(
                                  child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white)))
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                  ),
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        loading = true;
                                      });
                                       result = await productProvider.createProduct(myController1.text, myController2.text);
                                      setState(() {
                                        loading = false;
                                      });
                                      if(result == true){
                                        _showMyDialog('Product Created!!', 'Product added to database.');
                                      }
                                    } else {
                                      _showMyDialog('Error!!', 'Something went wrong');
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      'Add Product',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
