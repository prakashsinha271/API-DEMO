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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('API Demo'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'API Creation and Hosting\nNodeJS',
                      style:
                      TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Name can be updated via this form by entering existing number',
                      style: TextStyle(fontSize: 20),
                    )),
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
                          //debugPrint("Save button clicked");
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
    //debugPrint("Save button clicked");
    saveDataAPI(nameController.text, mobileController.text).then((value) {
      if(value == "Saved"){
        nameController.clear();
        mobileController.clear();
        showAlertDialog(context, value);
      }else if(value == "Exist"){
        //show alert
        asyncConfirmDialog(context, nameController.text, mobileController.text, "Number Exist", "You can update old name with new, or delete record.").then((value) {
          //print(value);
          if(value.toString() == "ConfirmAction.Accept"){
            nameController.clear();
            mobileController.clear();
            showAlertDialog(context, "Updated");
          }
          if(value.toString() == "ConfirmAction.Delete"){
            nameController.clear();
            mobileController.clear();
            showAlertDialog(context, "Deleted");
          }
        });
      }

    }).catchError((onError) {
      print("Error While Adding Contact");
      print(onError);
    });
  }
}

/*
===============================
Update/Delete/Cancel Alert Dialog Box
===============================
 */
enum ConfirmAction {Cancel, Accept, Delete}
Future<ConfirmAction> asyncConfirmDialog(BuildContext context, String name, String number, String titleConfirm, String message) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('$titleConfirm'),
        content: Text(message),
        actions: <Widget>[
          titleConfirm == "Delete Action" ? Text("") :
          FlatButton(
            child: const Text('Update'),
            onPressed: () {
              //Update code here
              //print("Update");
              updateContact(name, number).then((value) {
                // if(value == "Updated"){
                //   print("Contact");
                //   print(value);
                // }
              }).catchError((onError) {
                print("Error While Adding Contact");
                print(onError);
              });
              Navigator.of(context).pop(ConfirmAction.Accept);
            },
          ),
          FlatButton(
            child: const Text('Delete'),
            onPressed: () {
              //Delete code here
              //print("Delete");
              deleteOneContact(number).then((value) {
                // if(value == "Deleted"){
                //   print("Contact");
                //   print(value);
                // }else{
                //   //show error message
                // }
              }).catchError((onError) {
                print("Error While Adding Contact");
                print(onError);
              });
              Navigator.of(context).pop(ConfirmAction.Delete);
            },
          ),
          FlatButton(
            child: const Text('Cancel'),
            onPressed: () {
              // print("Cancel");
              Navigator.of(context).pop(ConfirmAction.Cancel);
            },
          ),
        ],
      );
    },
  );
}

/*
==============================
Status Dialog Box
==============================
 */
showAlertDialog(BuildContext context, String message) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(message),
    content: Text("Record has been $message"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}