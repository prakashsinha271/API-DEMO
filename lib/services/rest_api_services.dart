import 'dart:convert';
import 'package:flutter_api_demo/model/contact_model.dart';
import 'package:http/http.dart' as http;




final baseUrl = 'http://10.0.2.2:8000/contacts';

//GET ALL CONTACTS
Future<List<ContactModel>> getAllContacts() async {
  print("error");
  final response = await http.get(baseUrl);

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final data = jsonData['contacts'];
    List<ContactModel> contactList = [];
    for (var a in data) {
      final contactModelData = ContactModel.fromJson(a);
      contactList.add(contactModelData);
    }
    return contactList;
  } else {
    throw Exception('Error in getting contact from api');
  }
}

//GET CONTACT BY NUMBER

//GET CONTACT_BY_NAME


//ADD_CONTACT INTO API
Future<String> saveDataAPI(String name, String number) async {

  final response = await http.get(baseUrl+'/$number');
  if(response.contentLength > 14){
    //data exist, show alert and ask user for update/delete/cancel
    return "Exist";
  }else{
    //Save data code here
    final url = baseUrl;

    ContactModel c = new ContactModel(name: name, number: number);

    var bodyJson = c.toJson();

    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(bodyJson));

    if (response.statusCode == 200) {
      return "Saved";
    } else {
      throw Exception(
          'Something Went Wrong');
    }
  }
}

//UPDATE CONTACT BY NUMBER
Future<String> updateContact(String name, String number) async {
  final url = baseUrl+'/$number';

  ContactModel c = new ContactModel(name: name, number: number);

  var bodyJson = c.toJson();

  final response = await http.put(
    url,
    body: jsonEncode(bodyJson),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return "Updated";
  } else {
    throw Exception(
        'Error while UPDATING contact details');
  }
}

//DELETE CONTACT BY NUMBER
Future<String> deleteOneContact(String number) async {
  final url = baseUrl+'/$number';
  final response = await http.delete(url);

  if (response.statusCode == 200) {
    return "Deleted";
  } else {
    throw Exception(
        'Error while deleting contact');
  }
}
