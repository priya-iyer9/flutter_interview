import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_interview/models/list_model.dart';
import 'package:http/http.dart' as http;

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late Welcome obj;
  List<Welcome> listObj = [];

  Future<List<dynamic>> getListApi() async {
    try {
      var url = Uri.parse('https://fakestoreapi.com/products');
      var response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return jsonDecode(response.body);
    } catch (e) {
      print("e: $e");
      return [];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.0,
        title: const Text(
          "List Data",
          style: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: getListApi(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  contentPadding: const EdgeInsets.all(15.0),
                  shape: Border.all(color: Colors.green),
                  leading: Container(
                    margin: const EdgeInsets.all(10.0),
                    height: 50.0,
                    width: 50.0,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: Image.network(
                      snapshot.data![index]["image"],
                    ),
                  ),
                  title: Text(
                    snapshot.data![index]["title"],
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800),
                  ),
                  subtitle: Text(
                    snapshot.data![index]["description"],
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600),
                  ),
                );
              },
            );
          } else {
            return const Text("Error...");
          }
        },
      ),
    );
  }
}
