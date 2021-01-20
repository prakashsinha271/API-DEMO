import 'package:flutter/material.dart';
import 'package:flutter_api_demo/model/contact_model.dart';
import 'package:flutter_api_demo/services/rest_api_services.dart';

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

  @override
  void initState() {
    super.initState();
    _fetchAPI();
    _inputType = TextEditingController();
    _radioVal = "name";
  }

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('View API Data'),
      ),
      body: Container(
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
                          FloatingActionButton(onPressed: () {
                            if (_formKey.currentState.validate()) {
                              debugPrint("By name");
                            }
                          })
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
                              FloatingActionButton(onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  debugPrint("By number");
                                }
                              })
                            ],
                          ),
                        )
                      : Expanded(child: _getContactListView()),

              //
              // SingleChildScrollView(
              //             child: getContactListView(),
              //           ),
            ],
          ),
        ),
      ),
    );
  }

  void _fetchAPI() {
    var contactDataFromApi = getAllContacts();
    print("init ");
    contactDataFromApi.then((value) {
      // print(value);
      for (var data in value) {
        var name = data.name;
        var number = data.number;
        var d = {"name": name, "number": number};
        setState(() {
          contactData.add(d);
        });
      }
      print(contactData);
    });
  }

  ListView _getContactListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: contactData.length,
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
                  contactData[position]['name'],
                  style: TextStyle(color: Colors.red[800], backgroundColor: Colors.white),
                ),
                Spacer(),
                Text(
                  contactData[position]['number'],
                  style: TextStyle(color: Colors.red[800], backgroundColor: Colors.white),
                ),
              ],
            ),
            onTap: () {},
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
