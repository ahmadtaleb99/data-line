import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_test/presentation/resources/values_manager.dart';

class BuildRecords extends StatefulWidget {
  const BuildRecords({Key? key}) : super(key: key);

  @override
  State<BuildRecords> createState() => _BuildRecordsState();
}

class _BuildRecordsState extends State<BuildRecords> {

  bool _isExpanded = false;
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

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.r20),
                        child: ExpansionPanelList(
                          animationDuration: const  Duration(milliseconds: 600),
                          expansionCallback: (index, isOpen) {
                            setState(() {
                              _isExpanded = !_isExpanded  ;
                            });
                          },
                          children: [
                            ExpansionPanel(
                                canTapOnHeader: false,
                                body: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
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
                                ),
                                isExpanded: _isExpanded,
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
                                }),
                          ],
                        ),
                      )),
                ),
              )),
          Expanded(
            child: IconButton(
              splashRadius: 15,
              onPressed: () {

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
