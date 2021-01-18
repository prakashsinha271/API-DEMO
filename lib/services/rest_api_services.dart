import 'dart:convert';

import 'package:flutter_api_demo/model/contact_model.dart';
import 'package:http/http.dart' as http;

final baseUrl = 'http://10.0.2.2:3005/contacts';

//GET ALL CONTACTS
getAllContacts() async {
 // print("error");
  final response = await http.get(baseUrl);
  print(response);

  if (response.statusCode == 200) {
    print('RESPOnSE');
    final jsonData = jsonDecode(response.body);
    final data = jsonData['contacts'];
    print(jsonData['contacts']);
    final a = ContactModel.fromJson(jsonData);
    print(a.name);
    }
  else {
    throw Exception('Error in getting contact from api');
      }
}

//GET CONTACT BY NUMBER

//GET CONTACT_BY_NAME

//ADD_CONTACT

//UPDATE CONTACT BY NUMBER

//DELETE CONTACT BY NUMBER
