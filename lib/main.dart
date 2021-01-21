import 'package:flutter/material.dart';
import 'package:flutter_api_demo/new.dart';
import 'package:flutter_api_demo/services/rest_api_services.dart';
import 'package:flutter_api_demo/view.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var contactData = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchAPI();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts App'),
      ),
      body:Container(
          child: _getContactListView()),

      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.menu), onPressed: () {}),
            Spacer(),
            IconButton(icon: Icon(Icons.search), onPressed: () {Navigator.push(context,   MaterialPageRoute(builder: (context) => ViewData()));}),
            IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
          ],
        ),
      ),
      floatingActionButton:FloatingActionButton(child: Icon(Icons.add), onPressed: () { Navigator.push(context,   MaterialPageRoute(builder: (context) => NewScreen())).then((value){_fetchAPI();});
      @override
      void dispose() {
        // TODO: implement dispose
        super.dispose();
        Home();
      }}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
            onTap: () {
              print("onTap number- ");
              print(contactData[position]['number']);
            },
            onLongPress: (){
              print("onTap name- ");
              asyncConfirmDialog(context, contactData[position]['name'], contactData[position]['number'], "Delete Action", "This record will be permanently delete from data base, do you want to delete?");
              print(contactData[position]['name']);
            },
          ),

          //Text(this.noteList[position].address),
        );
      },
    );
  }
}



