// ignore_for_file: unused_import

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
    body : BlocBuilder<SubmissionsBloc, SubmissionsState>(
      buildWhen: (p,c) {
        return p.flowState != c.flowState;
      },
        builder: (context, state) {

          if (state.flowState != null) {
            var widget =
            state.flowState.getWidget(context,  NewWidget(formModel: formModel), () {
            });
            return widget;
          } else {
            return NewWidget(formModel: formModel);
          }
        },
      ),
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
              },
            ),
            separatorBuilder: (context, index) =>
            const Padding(padding: EdgeInsets.all(AppPadding.p20)),
            itemCount: state.submissions.length);
      },
    );
  }
}

class SubmissionCard extends StatelessWidget {

  final  void Function()? onView;
  final  void Function()? onDelete;
  final  void Function()? onUpdate;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppPadding.p20),
      height: 150.h,
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10)),
      child: Card(
        elevation: 10,
        color: Colors.lightBlueAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Form Name',style: Theme.of(context)
                .textTheme
                .overline!,),
            Row(children: [
              Text('field Name'),
              Text('field value'),
            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
    );
  }

  const SubmissionCard({
    this.onView,
    this.onDelete,
    this.onUpdate,
  });
}
