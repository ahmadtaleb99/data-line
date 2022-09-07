import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_model.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_record/matrix_record_model.dart';
import 'package:form_builder_test/presentation/common/dialogs/warning_dialog.dart';
import 'package:form_builder_test/presentation/common/value_view_parser.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';
import 'package:form_builder_test/presentation/resources/values_manager.dart';

class MatrixRecordWidget extends StatefulWidget {
  final void Function()? onEdit;
  final void Function()? onDelete;
  final List<MatrixFieldModel> fields;
  final MatrixRecordModel record;
  @override
  State<MatrixRecordWidget> createState() => _MatrixRecordWidgetState();

  MatrixRecordWidget({
    this.onEdit,
    this.onDelete,
    required this.fields,
    required this.record,
  });
}

class _MatrixRecordWidgetState extends State<MatrixRecordWidget> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
              flex: 6,
              child: Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.r20)),
                  elevation: 5,
                  child: InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.r20),
                      ),
                      onTap: widget.onEdit,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.r20),
                        child: BlocBuilder<FormsBloc, FormsState>(
  builder: (context, state) {
    return ExpansionPanelList(
                          animationDuration: const Duration(milliseconds: 600),
                          expansionCallback: (index, isOpen) {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                          children: [
                            ExpansionPanel(
                              canTapOnHeader: false,
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: AppPadding.p13),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              child: Text(
                                                widget.fields[0].label,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1,
                                              )),
                                          BlocBuilder<FormsBloc,
                                              FormsState>(
                                            builder: (context, state) {
                                              return Expanded(
                                                  child: Text(
                                                    _getFieldValue(0) ?? '',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1,
                                                    overflow: TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                  ));
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              },
                              body: Column(
                                children: [
                                  ...List.generate(
                                      widget.fields.length - 1,
                                          (index) => Padding(
                                        padding:
                                        EdgeInsets.all(AppPadding.p13),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Expanded(
                                                child: Text(
                                                    widget.fields[index + 1]
                                                        .label,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1)),
                                            Expanded(
                                                child: Text(
                                                  _getFieldValue(index+1),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                )),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                              isExpanded: _isExpanded,
                            )
                          ],
                        );
  },
),
                      )),
                ),
              )),
          Expanded(
            child: IconButton(
              onPressed: widget.onDelete,
              splashRadius: 15,
              icon: const Icon(Icons.delete),
            ),
          )
          // else  Container(),
        ],
      ),
    );
  }

  _getFieldValue(int index){
    var value =  widget.record.valuesMap[widget.fields[index].fieldName] ;
    return ValueViewParser.getValue(value);
  }
}
