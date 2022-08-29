// ignore_for_file: unused_import

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_test/app/dependency_injection.dart';
import 'package:form_builder_test/domain/model/form_model.dart';
import 'package:form_builder_test/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';
import 'package:form_builder_test/presentation/forms/submission_details_screen/view/submission_details_screen.dart';
import 'package:form_builder_test/presentation/forms/submissions_screen/bloc/submissions_bloc.dart';
import 'package:form_builder_test/presentation/forms/update_submisson/view/update_submisson_screen.dart';
import 'package:form_builder_test/presentation/resources/values_manager.dart';
import 'package:form_builder_test/presentation/state_renderer_bloc/state_renderer_bloc.dart';

class SubmissionsScreen extends StatelessWidget {
  const SubmissionsScreen({Key? key,required this.formModel}) : super(key: key);
  final FormModel formModel;


  @override
  Widget build(BuildContext context) {

   return Scaffold(
     appBar: AppBar(),
    // body : BlocBuilder<SubmissionsBloc, SubmissionsState>(
    //   buildWhen: (p,c) {
    //     return p.flowState != c.flowState;
    //   },
    //     builder: (context, state) {
    //
    //       if (state.flowState != null) {
    //         var widget =
    //         state.flowState.getWidget(context,  NewWidget(formModel: formModel), () {
    //         });
    //         return widget;
    //       } else {
    //         return NewWidget(formModel: formModel);
    //       }
    //     },
    //   ),
    body : NewWidget(formModel: formModel,),
   );

  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
    required this.formModel,
  }) : super(key: key);

  final FormModel formModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubmissionsBloc, SubmissionsState>(
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => SubmissionCard(
              formModel: formModel,
              onUpdate: (){
                var formsBloc = context.read<FormsBloc>();
                formsBloc.add(SubmissionUpdateRequested(formModel,state.submissions[index]));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: formsBloc,
                          child:  UpdateSubmissionScreen(formModel: formModel,submission:state.submissions[index]),
                        ))).then((value) =>  context.read<SubmissionsBloc>().add(SubmissionsRequested(formModel)));
              },
              onDelete: (){

                context.read<SubmissionsBloc>().add(SubmissionDeleted(state.submissions[index]));
              },
              onView: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SubmissionDetailsScreen(fields: formModel.fields,submission: state.submissions[index])));
              }, entries: state.submissions[index].fieldEntries,
            ),
            separatorBuilder: (context, index) =>
            const Padding(padding: EdgeInsets.all(AppPadding.p20)),
            itemCount: state.submissions.length);
      },
    );
  }
}

class SubmissionCard extends StatelessWidget {
  final List<FieldEntry> entries;
  final FormModel  formModel;
  final  void Function()? onView;
  final  void Function()? onDelete;
  final  void Function()? onUpdate;
  @override
  Widget build(BuildContext context) {
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              Row(
                children: [
                Expanded(child: Align(alignment:Alignment.center,child: Text(getFieldLabel(_getNonNullEntries().first.name),style: Theme.of(context).textTheme.subtitle2!.copyWith(color:Colors.white,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis
                ),))),
                  Expanded(child: Align(alignment:Alignment.center,child: Text(_getNonNullEntries().first.value,style: Theme.of(context).textTheme.subtitle2!.copyWith(color:Colors.white,fontWeight: FontWeight.bold),))),

                ],),
              if(_getNonNullEntries().length > 1) Opacity(
                opacity: 0.6,
                child: Row(
                  children: [
                  Expanded(child: Align(alignment:Alignment.center,child: Text(getFieldLabel(_getNonNullEntries()[1].name),style: Theme.of(context).textTheme.subtitle2!.copyWith(color:Colors.white,fontWeight: FontWeight.bold),))),
                    Expanded(child: Align(alignment:Alignment.center,child: Text(_getNonNullEntries()[1].value.toString(),style: Theme.of(context).textTheme.subtitle2!.copyWith(color:Colors.white,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),))),

                  ],),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,

                children: [
                  IconButton(
                      onPressed: onView,
                      icon: Icon(
                        Icons.visibility,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: onUpdate,
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: onDelete,
                      icon: Icon(
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
        log(entries.toString()+'asdsad');
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
