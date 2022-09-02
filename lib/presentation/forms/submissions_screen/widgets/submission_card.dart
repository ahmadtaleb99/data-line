import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_test/domain/model/form_model.dart';

import '../../../resources/values_manager.dart';

class SubmissionCard extends StatelessWidget {
  final List<FieldEntry> entries;
  final FormModel  formModel;
  final  void Function()? onView;
  final  void Function()? onDelete;
  final  void Function()? onUpdate;
  @override
  Widget build(BuildContext context) {
    log(entries.toString());
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

              Row(
                children: [
                  // Expanded(child: Align(alignment:Alignment.center,child: Text(getFieldLabel(_getNonNullEntries().first.name),style: Theme.of(context).textTheme.subtitle2!.copyWith(color:Colors.white,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis
                  // ),))),
                  // Expanded(child: Align(alignment:Alignment.center,child: Text(_getNonNullEntries().first.value,style: Theme.of(context).textTheme.subtitle2!.copyWith(color:Colors.white,fontWeight: FontWeight.bold),))),

                ],),
              if(_getNonNullEntries().length > 1) Opacity(
                opacity: 0.6,
                child: Row(
                  children: [
                    // Expanded(child: Align(alignment:Alignment.center,child: Text(getFieldLabel(_getNonNullEntries()[1].name),style: Theme.of(context).textTheme.subtitle2!.copyWith(color:Colors.white,fontWeight: FontWeight.bold),))),
                    // Expanded(child: Align(alignment:Alignment.center,child: Text(_getNonNullEntries()[1].value.toString(),style: Theme.of(context).textTheme.subtitle2!.copyWith(color:Colors.white,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),))),

                  ],),
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
    List<FieldEntry>  list = [ ];
    for(int i = 0 ; i<entries.length && list.length < 2 ; i++){
      if(entries[i].value != null){
        list.add(entries[i]);
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
