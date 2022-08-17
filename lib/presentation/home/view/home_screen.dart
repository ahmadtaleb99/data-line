import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/app/dependency_injection.dart';
import 'package:form_builder_test/domain/repository/form_repository.dart';
import 'package:form_builder_test/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';
import 'package:form_builder_test/presentation/forms/new_submission/bloc/new_form_bloc.dart';
import 'package:form_builder_test/presentation/forms/new_submission/view/new_submit_screen.dart';
import 'package:form_builder_test/presentation/forms/submissions_screen/submissions_screen.dart';
import 'package:form_builder_test/presentation/home/bloc/home_bloc.dart';
import 'package:form_builder_test/presentation/resources/values_manager.dart';
import 'package:form_builder_test/presentation/state_renderer_bloc/state_renderer_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<FormsBloc, FormsState>(
          buildWhen: (p,c) => p.flowState != c.flowState,
          builder: (context, state) {
            if (state.flowState != null) {
              var widget =
                  state.flowState.getWidget(context, const NewWidget(), () {
                context.read<FormsBloc>().add(AssignedFormsRequested());
              });
              log(widget.hashCode.toString());
              return widget;
            } else {
              return const NewWidget();
            }
          },
        )
//       body: _getWidget(context)
        );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormsBloc, FormsState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<FormsBloc>().add(AssignedFormsRefreshRequested());
          },
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: state.assignedForms.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(AppPadding.p20),
                  child: FormCard(
                      viewSubmittedCallBack: () {

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => BlocProvider(
                                  create:(context) => FormsBloc(context.read<AssignedFormRepository>()),
                                  child: SubmissionsScreen(
                                    formModel: state.assignedForms[index],
                                  ),
                                )));
                        context
                            .read<FormsBloc>()
                            .add(SubmissionsRequested(
                            state.assignedForms[index]));
                      },
                      formName: state.assignedForms[index].name,
                      submitNewFormCallBack: () {
                        context
                            .read<FormsBloc>()
                            .add(NewFormRequested(state.assignedForms[index]));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                      value: context.read<FormsBloc>(),
                                      child: NewSubmitScreen(
                                          formModel:
                                              state.assignedForms[index]),
                                    )));
                      }),
                );
              }),
        );
      },
    );
  }
}

class FormCard extends StatelessWidget {
  const FormCard(
      {Key? key,
      required this.viewSubmittedCallBack,
      required this.formName,
      required this.submitNewFormCallBack})
      : super(key: key);
  final String formName;
  final void Function()? viewSubmittedCallBack;
  final void Function()? submitNewFormCallBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10)),
      child: Card(
        elevation: 10,
        color: Colors.lightBlueAccent,
        child: Column(
          children: [
            Expanded(
                flex: 5,
                child: Center(
                    child: Text(
                  formName,
                  style: Theme.of(context)
                      .textTheme
                      .overline!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                ))),
            Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: submitNewFormCallBack,
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: viewSubmittedCallBack,
                        icon: const Icon(
                          Icons.visibility,
                          color: Colors.white,
                        )),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
