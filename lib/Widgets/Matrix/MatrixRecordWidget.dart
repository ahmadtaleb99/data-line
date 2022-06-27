import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/Widgets/Matrix/fields/RecordCubit/matrix_record_cubit.dart';
import 'package:form_builder_test/data/FormRepository.dart';
import 'package:form_builder_test/dynamic%20form/matrix/fields/MatrixRadioGroup.dart';
import 'package:form_builder_test/dynamic%20form/matrix/fields/matrix_record.dart';
import 'package:collection/collection.dart';

import '../../dynamic form/IFormModel.dart';
import '../../logic/validation__bloc.dart';
import '../IDrawable.dart';

class MatrixRecordWidget extends FormElementWidget {
  MatrixRecordWidget({
    Key? key,
    this.isFirst = true,
    required this.children,
    required this.index,
    required this.matrixName,
  }) : super(key: key, name: 'sad', label: '');
  final bool isFirst;
  final List<IFormModel> children;
  final String matrixName;
  final int index;

  @override
  Widget build(BuildContext context) {
    log('  matrix record widget build');

    return RecordCard(
      children: children.map((e) => e.toWidget()).toList(),
      isFirst: isFirst,
      index: index,
      matrixName: matrixName,
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
}

class RecordCard extends StatefulWidget {
  final List<FormElementWidget> children;

  int index;
  bool isFirst;
  final matrixName;

  @override
  _RecordCardState createState() => _RecordCardState();

  RecordCard({
    required this.children,
    required this.index,
    required this.isFirst,
    required this.matrixName,
  });
}

class _RecordCardState extends State<RecordCard> {
  var bloc;
  @override
  void initState() {
    super.initState();

    bloc = context.read<MatrixRecordCubit>();
  }

  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatrixRecordCubit, MatrixRecordState>(
      builder: (context, state) {



        return Container(
          child: Row(
            children: [
              Expanded(
                  flex: 6,
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
                            context.read<MatrixRecordCubit>().setCurrentRecord(widget.index, widget.matrixName);

                            showRecordDialog(context, onSubmit: () {
                              log(state.currentRecord!.fields[2].value
                                      .toString() +
                                  state.currentRecord!.fields[2].name);


                              context.read<MatrixRecordCubit>().submited(
                                  state.currentRecord!,
                                  widget.matrixName,
                                  widget.index);

                              Navigator.pop(context);

                            });

                          },
                          child: ExpansionPanelList(
                            expandedHeaderPadding: EdgeInsets.all(0),
                            animationDuration: Duration(milliseconds: 600),
                            expansionCallback: (index, isOpen) {
                              setState(() {
                                isExpanded = !isOpen;
                              });
                            },
                            children: [
                              ExpansionPanel(
                                  canTapOnHeader: false,
                                  body: Padding(
                                    padding: const EdgeInsets.only(bottom: 0),
                                    child: Column(
                                      children: [
                                        ...List<Widget>.generate(
                                            widget.children.length - 1,
                                            (index) {
                                          return Padding(
                                            padding: index == 1
                                                ? const EdgeInsets.only(
                                                    left: 15,
                                                    top: 15,
                                                    right: 15,
                                                    bottom: 15)
                                                : const EdgeInsets.only(
                                                    left: 15,
                                                    top: 15,
                                                    right: 15,
                                                    bottom: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                    child: Text(widget
                                                        .children[index + 1]
                                                        .label)),
                                                Expanded(
                                                    child: Text(
                                                  widget.children[index + 1]
                                                          .valueToString() ??
                                                      '',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                )),
                                              ],
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                  isExpanded: isExpanded,
                                  headerBuilder:
                                      (BuildContext context, bool isExpanded) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  widget.children.first.label)),
                                          Expanded(
                                              child: Text(
                                            widget.children.first.value ?? '',
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                          )),
                                        ],
                                      ),
                                    );
                                  })
                            ],
                          )),
                    ),
                  )),
              if (!widget.isFirst)
                Expanded(
                  child: IconButton(
                      onPressed: () {
                        if (isExpanded) {
                          isExpanded = false;
                        }
                        context
                            .read<MatrixRecordCubit>()
                            .removeRecord(widget.index);
                      },
                      icon: Icon(Icons.remove)),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget setupAlertDialoadContainer(List<Widget> children) {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: Form(
        // key: state.key,
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
  }

  Future<void> showRecordDialog(BuildContext context, {void Function()? onSubmit}) async {
    showDialog(
        useRootNavigator: false,
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return BlocProvider<MatrixRecordCubit>.value(
            value: bloc,
            child: AlertDialog(
              title: Text('Add'),
              content: setupAlertDialoadContainer(widget.children),
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
                            onPressed: onSubmit,
                            child: Text('Submit')),
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
                            // widget.children.forEach((element) {
                            //   element.value = null;
                            // });
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
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
