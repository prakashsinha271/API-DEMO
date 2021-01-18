import 'package:flutter/material.dart';
import 'package:flutter_api_demo/services/rest_api_services.dart';
import 'package:flutter_api_demo/view.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _APIDemo createState() => _APIDemo();
}

class _APIDemo extends State<MyApp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('init');
    getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('API Creation and Hosting NodeJS'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                // Container(
                //     alignment: Alignment.center,
                //     padding: EdgeInsets.all(10),
                //     child: Text('',
                //       style: TextStyle(
                //           color: Colors.blue,
                //           fontWeight: FontWeight.w500,
                //           fontSize: 30),
                //     )),
                Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '!!Guided by Ankit Sir!!',
                      style: TextStyle(fontSize: 20),
                    )),
                SizedBox(
                  height: 20.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          maxLines: 1,
                          maxLength: 20,
                          validator: (value) {
                            if (value == null || value == "" || value.isEmpty) {
                              return "Valid Name Required";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Full Name',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextFormField(
                          //obscureText: true,
                          controller: mobileController,
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          maxLength: 10,
                          validator: (value) {
                            if (value.length < 10) {
                              return "Valid Mobile Number Required";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Mobile Number',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Save'),
                      onPressed: () {
                        setState(() {
                          debugPrint("Save button clicked");
                          if (_formKey.currentState.validate()) {
                            _saveData();
                          }
                        });
                      },
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('View Saved Data'),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Click here',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ViewData()),
                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }

  /*
  ============
  Save Data into API
  ============
   */
  void _saveData() {
    debugPrint("Save button clicked");
    debugPrint(nameController.text);
    debugPrint(mobileController.text);
  }
}
