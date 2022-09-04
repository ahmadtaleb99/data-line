import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_test/presentation/resources/values_manager.dart';

class MatrixRecordWidget extends StatelessWidget {
  const MatrixRecordWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
              flex: 6,
              child: Padding(
                padding:  EdgeInsets.only( top: 5.h),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.r20)),
                  elevation: 5,
                  child: InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.r20),
                      ),
                      onTap: () async {

                      },
                      child: ExpansionPanelList(
                        animationDuration: const  Duration(milliseconds: 600),
                        expansionCallback: (index, isOpen) {

                        },
                        children: [
                          ExpansionPanel(
                              canTapOnHeader: false,
                              body: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                          child: Text('label')),
                                      Expanded(
                                          child: Text(
                                            'value',
                                            overflow:
                                            TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                          )),
                                    ],
                                  )
                                ],
                              ),
                              isExpanded: true,
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
                                             'text')),
                                      Expanded(
                                          child: Text(
                                         'value',
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
          // if (!(state.matrixList.firstWhere((element) => element.name == this.widget.matrixName).records.length == 1) )
          Expanded(
            child: IconButton(
              splashRadius: 15,
              onPressed: () {
                // CoolAlert.show(
                //   context: context,
                //   type: CoolAlertType.warning,
                //   showCancelBtn: true,
                //   confirmBtnText: 'Confirm',
                //   cancelBtnText: 'Cancel',
                //   title: 'Warning',
                //   text: 'Are you sure you want to delete this record?',
                //   onConfirmBtnTap: () {
                //     var record = state.matrixList
                //         .firstWhere((element) =>
                //     element.name == this.widget.matrixName)
                //         .records[widget.index];
                //
                //     if (isExpanded) {
                //       isExpanded = false;
                //     }
                //     context
                //         .read<MatrixRecordCubit>()
                //         .removeRecord(widget.matrixName, record);
                //     Navigator.pop(context);
                //   },
                // );
              },
              icon: const Icon(Icons.delete),
            ),
          )
          // else  Container(),
        ],
      ),
    );
  }
}
