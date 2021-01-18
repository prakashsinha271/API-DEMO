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

//ADD_CONTACT

//UPDATE CONTACT BY NUMBER

//DELETE CONTACT BY NUMBER
