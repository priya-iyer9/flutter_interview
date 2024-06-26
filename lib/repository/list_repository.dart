import 'dart:convert';

import 'package:flutter_interview/models/list_model.dart';
import 'package:http/http.dart' as http;

class ListRepository {
  Future<List<Welcome>> getListApi() async {
    try {
      var url = Uri.parse('https://fakestoreapi.com/products');
      var response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      var res = jsonDecode(response.body);

      //assigned values to list:
      return ((res as List).map((data) => Welcome.fromJson(data)).toList());
    } catch (e) {
      print("e: $e");
      return [];
    }
  }
}
