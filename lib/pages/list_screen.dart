import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview/bloc/list_bloc/list_bloc.dart';
import 'package:flutter_interview/models/list_model.dart';
import 'package:flutter_interview/repository/list_repository.dart';
import 'package:http/http.dart' as http;

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  //initialize object repository
  ListRepository obj = ListRepository();
//remove late object instance
  List<Welcome> listObj = [];
  //initialized an index that we will shuffle in the floating action button
  int currentIndex = -1;
  //initializing a scroll controller
  ScrollController scrollController = ScrollController();
  // created height variable to have container or parent height for the listview
  double width = 800.0;

//removed api fuction and added to bloc

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obj.getListApi();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListBloc(obj),
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: () {
                setState(() {
                  obj.getListApi();
                });
              },
              child: const Icon(
                Icons.list_alt_outlined,
                color: Colors.white,
                size: 24.0,
              ),
            ),
            const SizedBox(width: 20.0)
          ],
          backgroundColor: Colors.green,
          elevation: 0.0,
          title: const Text(
            "List Data",
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
        ),
        //added bloc provider/builder and state
        body: BlocProvider(
          create: (context) => ListBloc(
            ListRepository(),
          )..add(LoadListEvent()),
          child: BlocBuilder<ListBloc, ListState>(
            builder: (context, state) {
              if (state is ListLoadingState) {
                return const Center(
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.green,
                  )),
                );
              } else if (state is ListErrorState) {
                return const Center(
                  child: Text("Error..."),
                );
              } else if (state is ListLoadedState) {
                // loaded list
                listObj = state.list;
                return ListView.builder(
                  controller: scrollController,
                  shrinkWrap: true,
                  itemCount: listObj.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          trailing: currentIndex == index
                              ? Container(
                                  height: 10.0,
                                  width: 10.0,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      //displaying selected tile using selected index
                                      color: Colors.green),
                                )
                              : const SizedBox.shrink(),
                          contentPadding: const EdgeInsets.all(10.0),
                          leading: Container(
                            margin: const EdgeInsets.all(10.0),
                            height: 50.0,
                            width: 50.0,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: Image.network(
                              listObj[index].image!,
                            ),
                          ),
                          title: Text(
                            listObj[index].title!,
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade800),
                          ),
                          subtitle: SizedBox(
                            width: 200.0,
                            child: Text(
                              listObj[index].description!,
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade600),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            setState(() {
              currentIndex = Random().nextInt(listObj.length);
              print("currentIndex floating: $currentIndex");
              // print("current index: ${Random().nextInt(5)}");
            });
            // scrollController.animateTo(
            //   currentIndex.toDouble() * height,
            //   curve: Curves.easeOut,
            //   duration: const Duration(milliseconds: 300),
            // );
          },
          child: const Center(
            child: Icon(
              Icons.ads_click,
              color: Colors.white,
              size: 24.0,
            ),
          ),
        ),
      ),
    );
  }
}
