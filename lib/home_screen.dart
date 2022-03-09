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
      floatingActionButton: FloatingActionButton(onPressed: () {
        showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  title: Text('person add'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Name'
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                            hintText: 'Age'
                        ),
                      ),
                      Row(children: [Text('Ismarried'), Checkbox(value: false,onChanged: (value){

                      })],)
                    ],
                  ),
                  actions: <Widget>[
                    Center(
                      child: ElevatedButton(
                        child: Text('Add New Person'),
                        onPressed: () {
                          Navigator.of(dialogContext)
                              .pop(); // Dismiss alert dialog
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },

      ),
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
