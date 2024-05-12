import 'dart:convert';
import 'package:flutter_interview/models/list_model.dart';
import 'package:http/http.dart' as http;

class GetListApi {
  Future<List<dynamic>> getList() async {
    try {
      var url = Uri.parse('https://fakestoreapi.com/products');
      var response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      var res = jsonDecode(response.body);
      List<Welcome> getObj = res;
      return getObj;
    } catch (e) {
      print("e: $e");
      return [];
    }
  }
}
