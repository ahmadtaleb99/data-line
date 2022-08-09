import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_test/app/dependency_injection.dart';
import 'package:form_builder_test/domain/model/form_model.dart';
import 'package:form_builder_test/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';
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
    body : BlocBuilder<FormsBloc, FormsState>(
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
    return BlocBuilder<FormsBloc, FormsState>(
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => SubmissionCard(
              onUpdate: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: getIT<FormsBloc>()..add(SubmissionUpdateRequested(this.formModel,state.submissions[index])),
                          child:  UpdateSubmissionScreen(formModel: formModel,submission:state.submissions[index]),
                        )));
              },
              onDelete: (){
                context.read<FormsBloc>().add(SubmissionDeleted(state.submissions[index]));
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
