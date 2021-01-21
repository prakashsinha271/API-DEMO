import 'package:http/http.dart' as http;

final baseUrl = 'http://10.0.2.2:8000/contacts';

//GET ALL CONTACTS
Future<String>getAllContacts() async{
  final response = await http.get(baseUrl);

  if(response.statusCode == 200){
    print('RESPOSE');
    print(response.body);
    return response.body;
  }
  else{
    throw Exception('Error in getting contact from api');
  }

}

//GET CONTACT BY NUMBER

//GET CONTACT_BY_NAME

//ADD_CONTACT

//UPDATE CONTACT BY NUMBER

//DELETE CONTACT BY NUMBER


