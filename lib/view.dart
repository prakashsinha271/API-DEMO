import 'package:flutter/material.dart';

enum ViewDataBy { name, number, all } //Radio Item

class ViewData extends StatefulWidget {
  ViewData({Key key}) : super(key: key);
  @override
  _ViewDataState createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  ViewDataBy _mode =
      ViewDataBy.name; //Initializing radio variable for default value
  final _formKey = GlobalKey<FormState>();
  TextEditingController _inputType;
  String _radioVal;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      body: Center(
        child: Container(
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
                        child: TextFormField(
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
                      )
                    : _radioVal == "number"
                        ? Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextFormField(
                             // obscureText: true,
                              controller: _inputType,
                              keyboardType: TextInputType.text,
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
                          )
                        : Text(""),
                FloatingActionButton(
                  child: Text('Save'),
                    onPressed: (){
                      if (_formKey.currentState.validate()) {
                        debugPrint("FormValidate");
                        _fetchAPI();
                      }
                    }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _fetchAPI(){
    debugPrint(_inputType.text);
    debugPrint(_radioVal);
    debugPrint("Inside _fetchAPI()");
  }
}
