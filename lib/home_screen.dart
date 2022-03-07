import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_test/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  void exec(Function f) {
    f();
  }
  void jsonSeilize(){
    var data = jsonDecode(rawJson);
    var func  = htmlFormToFlutter[data[0]['type']];
    exec(func);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(

    ),
    body: Container(
      child: Center(child: ElevatedButton(onPressed: () {
        jsonSeilize();
      },
      child: Text('priknt jspn'),),),
    ),);
  }
}
