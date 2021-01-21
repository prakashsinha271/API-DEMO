import 'package:flutter/material.dart';
import 'package:flutter_api_demo/model/contact_model.dart';
import 'package:flutter_api_demo/services/rest_api_services.dart';
import 'new.dart';

enum ViewDataBy { name, number, all }

class ViewData extends StatefulWidget {
  ViewData({Key key}) : super(key: key);
  @override
  _ViewDataState createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  ViewDataBy _mode = ViewDataBy.name; //Initializing radio variable for default value
  final _formKey = GlobalKey<FormState>();
  TextEditingController _inputType;
  String _radioVal;
  var contactData = [];
  var newDataList = [];

  @override
  void initState() {
    super.initState();
    _fetchAPI();
    _inputType = TextEditingController();
    _radioVal = "name";
  }

   onItemChanged(String value){
   setState(() {
     newDataList = contactData
         .where((string) => string['name'].toLowerCase().contains(value.toLowerCase()))
         .toList();
   });
    for(int pos = 0;pos<contactData.length;pos++){
      if(contactData[pos][_radioVal].toString().toLowerCase().contains(_inputType.text.toLowerCase())){
        print(contactData[pos]['name']);
        print(contactData[pos]['number']);
      }
    }
  }
  onNumberChanged(String value){
    setState(() {
      newDataList = contactData
          .where((object) => object['number'].contains(value))
          .toList();
    });
    for(int pos = 0;pos<contactData.length;pos++){
      if(contactData[pos][_radioVal].toString().toLowerCase().contains(_inputType.text.toLowerCase())){
        print(contactData[pos]['name']);
        print(contactData[pos]['number']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('View API Data'),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            padding: EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                          value: ViewDataBy.name,
                          groupValue: _mode,
                          onChanged: (ViewDataBy value) {
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            setState(() {
                              _mode = value;
                              _radioVal = "name";
                              _inputType.clear();
                              newDataList = contactData;
                            });
                          },
                        ),
                        Text("Name"),
                        SizedBox(
                          width: 30,
                        ),
                        Radio(
                          value: ViewDataBy.number,
                          groupValue: _mode,
                          onChanged: (ViewDataBy value) {
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            setState(() {
                              _mode = value;
                              _radioVal = "number";
                              _inputType.clear();
                              newDataList = contactData;
                            });
                          },
                        ),
                        Text("Number"),
                        SizedBox(
                          width: 30,
                        ),
                        Radio(
                          value: ViewDataBy.all,
                          groupValue: _mode,
                          onChanged: (ViewDataBy value) {
                            setState(() {
                              _mode = value;
                              _radioVal = "all";
                              _inputType.clear();
                              newDataList = contactData;
                            });
                          },
                        ),
                        Text("All Data"),
                      ],
                    ),
                  ),
                  _radioVal == "name"
                      ? Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Column(
                            children: [
                              TextFormField(
                                // obscureText: true,
                                controller: _inputType,
                                keyboardType: TextInputType.text,
                                onChanged: onItemChanged,
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
                            ],
                          ),
                        )
                      : _radioVal == "number"
                          ? Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Column(
                                children: [
                                  TextFormField(
                                    // obscureText: true,
                                    controller: _inputType,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == "") {
                                        return "Valid Mobile Number Required";
                                      }
                                      return null;
                                    },
                                    onChanged: onNumberChanged,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Mobile Number',
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Text(""),
                ],
              ),
            ),
          ),

        Container(child:
             Expanded(child: _getContactListView(),),
        )
        ],

      ),
    );
  }

  void _fetchAPI() {
    var contactDataFromApi = getAllContacts();
    print("init fetchAPI method");
    contactDataFromApi.then((value) {
      print(value);
      contactData.clear();
      newDataList.clear();
      for (var data in value) {
        var name = data.name;
        var number = data.number;
        var d = {"name": name, "number": number};
        setState(() {
          contactData.add(d);
        });
      }
      print("Printing newDataList");
      newDataList = contactData;
      print(newDataList.toString());
      print(contactData.runtimeType);
    });
  }

  ListView _getContactListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: newDataList.length,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.redAccent[200],
              child: Icon(Icons.person),
            ),
            title: Row(
              children: [
                Text(
                  newDataList[position]['name'],
                  style: TextStyle(color: Colors.red[800], backgroundColor: Colors.white),
                ),
                Spacer(),
                Text(
                  newDataList[position]['number'],
                  style: TextStyle(color: Colors.red[800], backgroundColor: Colors.white),
                ),
              ],
            ),
            onTap: () {
              print("onTap number- ");
              print(newDataList[position]['number']);
            },
            onLongPress: (){
              print("onTap name- ");
              asyncConfirmDialog(context, newDataList[position]['name'], newDataList[position]['number'], "Delete Action", "This record will be permanently delete from data base, do you want to delete?").then((value) {
                _fetchAPI();
              });
              print(newDataList[position]['name']);
            },
          ),

          //Text(this.noteList[position].address),
        );
      },
    );
  }
}


class ContactList extends StatelessWidget {
  final List<ContactModel> contacts;
  ContactList({Key key, @required this.contacts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contacts.length,
    );
  }
}
