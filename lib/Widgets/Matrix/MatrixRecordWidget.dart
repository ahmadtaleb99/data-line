import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/dynamic%20form/matrix/fields/MatrixRadioGroup.dart';
import 'package:form_builder_test/dynamic%20form/matrix/fields/matrix_record.dart';

import '../../dynamic form/IFormModel.dart';
import '../../logic/validation__bloc.dart';
import '../IDrawable.dart';

class MatrixRecord extends FormElementWidget {

  MatrixRecord({Key? key, this.isLast = true, required this.children})
      : super(key: key, name: 'sad', label: '');
  bool isLast;
  List<FormElementWidget> children;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidationBloc, ValidationState>(
      builder: (context, state) {
        return ExpansionTile(title:   Row(
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 0, top: 5),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 5,
                    child: InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onTap: () {
                        showRecordDialog(context, state.key);
                      },
                      child: Container(

                        child: Column(
                          children: [


                            ...List<Widget>.generate(1, (index) {
                              return  Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(child: Text(children[index].label)),
                                    Expanded(child: Text(children[index].valueToString() ?? '',overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,)),


                                  ],
                                ),
                              );
                            })
                            ,


                          ],
                        ),

                      ),
                    ),
                  ),
                )),
            if (isLast)
              IconButton(
                  onPressed: () {
                    context.read<ValidationBloc>().add(RecordAdded(
                        matrixName: 'matrix_1655016823189', context: context));
                  },
                  icon: Icon(Icons.add_circle))
            else
              IconButton(
                  onPressed: () {
                    context.read<ValidationBloc>().add(RecordRemoved(
                        matrixName: 'matrix_1655016823189',
                        matrixRecord: this));
                  },
                  icon: Icon(Icons.remove))
          ],
        ),children: [
          Row(
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 0, top: 5),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 5,
                    child: InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onTap: () {
                        showRecordDialog(context, state.key);
                      },
                      child: Container(

                        child: Column(
                          children: [


                            ...List<Widget>.generate(children.length, (index) {
                              return  Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(child: Text(children[index].label)),
                                    Expanded(child: Text(children[index].valueToString() ?? '',overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,)),


                                  ],
                                ),
                              );
                            })
                            ,


                          ],
                        ),

                      ),
                    ),
                  ),
                )),
            if (isLast)
              IconButton(
                  onPressed: () {
                    context.read<ValidationBloc>().add(RecordAdded(
                        matrixName: 'matrix_1655016823189', context: context));
                  },
                  icon: Icon(Icons.add_circle))
            else
              IconButton(
                  onPressed: () {
                    context.read<ValidationBloc>().add(RecordRemoved(
                        matrixName: 'matrix_1655016823189',
                        matrixRecord: this));
                  },
                  icon: Icon(Icons.remove))
          ],
        )]);
      },
    );
  }

  @override
  String valueToString() {
    return this.value;
  }

  MatrixRecordModel toModel() {
    return MatrixRecordModel(
        fields: this.children.map((dynamic e) => e.toModel()).toList().cast());
  }
  Widget setupAlertDialoadContainer(List children) {
    GlobalKey<FormState> _key = GlobalKey<FormState>();

    return BlocBuilder<ValidationBloc, ValidationState>(
      builder: (context, state) {
        return Container(
          height: 300.0, // Change as per your requirement
          width: 300.0, // Change as per your requirement
          child: Form(
            key: state.key,
            child: Scrollbar(
              radius: Radius.circular(10),
              thickness: 1,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: children.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: children[index],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void showRecordDialog(BuildContext context, GlobalKey<FormState> key) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async{

              this.children.forEach((element) {
                element.value = null;
              });

              context.read<ValidationBloc>().add(Refresher());
                return true;
            },
            child: AlertDialog(
              title: Text('Add'),
              content: setupAlertDialoadContainer(children),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            onPressed: () {

                              context.read<ValidationBloc>().add(MatrixSubmitted(matrixName: this.name,context: context));

                            },
                            child: Text('submit')),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            this.children.forEach((element) {
                              element.value = null;
                            });
                            Navigator.pop(context);
                          },
                          child: Text('clear'),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }




}
