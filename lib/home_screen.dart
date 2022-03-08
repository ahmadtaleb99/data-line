import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_test/FormBuilder.dart';
import 'package:form_builder_test/constants.dart';

import 'dynamic form/IFormDropList.dart';
import 'dynamic form/IFormTextField.dart';
import 'dynamic form/formable.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  var list = FormBuilder().jsonSeilize();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
            child: Column(children: [
          ElevatedButton(
              onPressed: () {
                print(list[2].drawFormElement());
              },
              child: Text('hit me ')),
          Expanded(
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      list[index].drawFormElement(),
                      Text(index.toString(),style: TextStyle(
                        color: Colors.black
                      ),)
                    ],
                  );
                }),
          ),
        ])));
  }
}
