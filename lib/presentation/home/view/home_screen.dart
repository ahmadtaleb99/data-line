import 'dart:developer';
import 'package:datalines/app/authtication_bloc/authentication_bloc.dart';
import 'package:datalines/presentation/common/buttons/custom_button_widget.dart';
import 'package:datalines/presentation/home/view/widgets/form_card_widget.dart';
import 'package:datalines/presentation/home/view/widgets/inactive_form_card_widget.dart';
import 'package:datalines/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:datalines/app/dependency_injection.dart';
import 'package:datalines/domain/repository/form_repository.dart';
import 'package:datalines/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:datalines/presentation/forms/bloc/forms_bloc.dart';
import 'package:datalines/presentation/forms/new_submission/bloc/new_form_bloc.dart';
import 'package:datalines/presentation/forms/new_submission/view/new_submit_screen.dart';
import 'package:datalines/presentation/forms/submissions_screen/bloc/submissions_bloc.dart';
import 'package:datalines/presentation/forms/submissions_screen/submissions_screen.dart';
import 'package:datalines/presentation/home/bloc/home_bloc.dart';
import 'package:datalines/presentation/resources/strings_manager.dart';
import 'package:datalines/presentation/resources/values_manager.dart';
import 'package:datalines/presentation/state_renderer_bloc/state_renderer_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.home),
        ),
        body: BlocBuilder<FormsBloc, FormsState>(
          buildWhen: (p, c) => p.flowState != c.flowState,
          builder: (context, state) {
            if (state.flowState != null) {

            log('☺0');
              log(state.flowState.toString());
              var widget =
              state.flowState.getWidget(context, const NewWidget(), () {
                context.read<FormsBloc>().add(AssignedFormsRequested());
              });
              return widget;
            } else {
              return const NewWidget();
            }


          },
        )
        // body: const NewWidget()

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
        final inactiveForms = state.inactiveForms ?? [];
        return RefreshIndicator(
          onRefresh: () async {
            context.read<FormsBloc>().add(FormsPageRefreshRequested());
          },
          child: Column(
            children: [
              SizedBox(
                height:   MediaQuery.of(context).size.height / 1.5,
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: state.assignedForms.length + inactiveForms.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(AppPadding.p20),
                        child: index >=
                                state.assignedForms.length
                            ? InactiveFormCard(
                          onSync: (){},
                                viewSubmittedCallBack: () {},
                                formName: 'formName',
                                submitNewFormCallBack: () {})
                            : FormCard(
                          onSync: (){
                            context.read<FormsBloc>().add(FormDataSyncRequested(formId: state.assignedForms[index].id));
                          },
                                viewSubmittedCallBack: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => MultiBlocProvider(
                                                providers: [
                                                  BlocProvider(
                                                    create: (context) =>
                                                        SubmissionsBloc(getIt<
                                                            AssignedFormRepository>())
                                                          ..add(SubmissionsRequested(
                                                              state.assignedForms[
                                                                  index])),
                                                  ),
                                                  BlocProvider.value(
                                                    value: context.read<FormsBloc>(),
                                                  ),
                                                ],
                                                child: SubmissionsScreen(
                                                  formModel:
                                                      state.assignedForms[index],
                                                ),
                                              )));
                                },
                                formName: state.assignedForms[index].name,
                                submitNewFormCallBack: () {
                                  context.read<FormsBloc>().add(
                                      NewFormRequested(state.assignedForms[index]));
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
              ),
              CustomButtonWidget(
                text: AppStrings.logout,
                onPressed: (){
                  context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
                },
              )
            ],
          ),
        );
      },
    );
  }
}
