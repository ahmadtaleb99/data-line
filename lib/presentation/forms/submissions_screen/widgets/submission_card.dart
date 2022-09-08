import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:datalines/data/responses/forms/enums.dart';
import 'package:datalines/domain/model/form_model.dart';
import 'package:datalines/domain/model/matrix_model/matrix_record/matrix_record_model.dart';
import 'package:datalines/presentation/common/value_view_parser.dart';

import '../../../resources/values_manager.dart';

class SubmissionCard extends StatelessWidget {
  final List<FieldEntry> entries;
  final FormModel  formModel;
  final  void Function()? onView;
  final  void Function()? onDelete;
  final  void Function()? onUpdate;
  @override
  Widget build(BuildContext context) {

    var notNullRecords = _getNonNullEntries();


    return Container(
      margin: const EdgeInsets.all(AppPadding.p20),
      height: 150.h,
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10)),
      child: Card(
        elevation: 10,
        color: Colors.lightBlueAccent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              if(!notNullRecords.isEmpty)   Row(
                children: [
                  Expanded(child: Align(alignment:Alignment.center,child: Text(getFieldLabel(notNullRecords.first.name),overflow: TextOverflow.fade,style: Theme.of(context).textTheme.subtitle2!.copyWith(color:Colors.white,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis
                  ),))),
                  Expanded(child: Align(alignment:Alignment.center,child: Text(ValueViewParser.getValue(notNullRecords.first.value),overflow: TextOverflow.fade,softWrap:false,style: Theme.of(context).textTheme.subtitle2!.copyWith(color:Colors.white,fontWeight: FontWeight.bold),))),

                ],),
              if(notNullRecords.length > 1) Opacity(
                opacity: 0.6,
                child: Row(
                  children: [
                    Expanded(child: Align(alignment:Alignment.center,child: Text(getFieldLabel(notNullRecords[1].name),overflow: TextOverflow.fade,style: Theme.of(context).textTheme.subtitle2!.copyWith(color:Colors.white,fontWeight: FontWeight.bold),))),
                    Expanded(child: Align(alignment:Alignment.center,child: Text(notNullRecords[1].value.toString(),overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.subtitle2!.copyWith(color:Colors.white,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),))),

                  ],),
              ),
              if(notNullRecords.length > 2) Opacity(
                opacity: 0.4,
                child: Text('. . .',style: Theme.of(context).textTheme.subtitle2!.copyWith(color:Colors.white,fontWeight: FontWeight.bold)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,

                children: [
                  IconButton(
                      onPressed: onView,
                      icon: const Icon(
                        Icons.visibility,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: onUpdate,
                      icon:const  Icon(
                        Icons.edit,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: onDelete,
                      icon: const Icon(
                        Icons.delete_rounded,
                        color: Colors.white,
                      )),
                ],
              ),



            ],
          ),
        ),
      ),
    );
  }



  List<FieldEntry> _getNonNullEntries(){

    log(entries.first.value.runtimeType.toString() + '&&&&&&&&');

    List<FieldEntry>  list = [ ];
    for(int i = 0 ; i<entries.length && list.length < 3 ; i++){
      if(entries[i].value != null){

        if(entries[i].type == FieldType.MATRIX) entries[i] = entries[i].copyWith(value: List<MatrixRecordModel>.from(entries[i].value));
        list.add(entries[i] );

        log(list.first.value.runtimeType.toString() + '&&&&&&&&');

      }
    }


    return list;
  }
  String getFieldLabel (String name)  {
    return formModel.fields.firstWhere((element) => element.name== name).label;
  }
  const SubmissionCard({
    this.onView,
    this.onDelete,
    this.onUpdate,
    required this.formModel,
    required this.entries,
  });
}
