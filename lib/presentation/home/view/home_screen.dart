import 'dart:developer';
import 'package:datalines/app/authtication_bloc/authentication_bloc.dart';
import 'package:datalines/presentation/common/animation/animation_box.dart';
import 'package:datalines/presentation/common/buttons/custom_button_widget.dart';
import 'package:datalines/presentation/common/dialogs/custom_Dialog.dart';
import 'package:datalines/presentation/common/drawer/drawer.dart';
import 'package:datalines/presentation/home/view/widgets/form_card_widget.dart';
import 'package:datalines/presentation/home/view/widgets/inactive_form_card_widget.dart';
import 'package:datalines/presentation/home/view/widgets/sync_dialog.dart';
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
import 'package:lottie/lottie.dart';
import 'package:datalines/presentation/resources/assets_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: const Text(AppStrings.home),
        ),
        body: BlocBuilder<FormsBloc, FormsState>(
          buildWhen: (p, c)  {
            log((p.flowState == c.flowState).toString());
            return p.flowState != c.flowState;
          },
          builder: (context, state) {
            if (state.flowState != null) {

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
    return BlocListener<FormsBloc, FormsState>(
      listenWhen: (p, c) => p.isFormSyncing != c.isFormSyncing,
      listener: (context, state) {
        if (state.isFormSyncing) {
          Future.delayed(
              Duration.zero,
              () => showDialog(
                  context: context,
                  builder: (_) => BlocProvider.value(
                        value: context.read<FormsBloc>(),
                        child: SyncLoadingDialog(),
                      )));
        }
      },
      child: BlocBuilder<FormsBloc, FormsState>(
        builder: (context, state) {
          final inactiveForms = state.inactiveForms;
          return RefreshIndicator(
            onRefresh: () async {
              context.read<FormsBloc>().add(FormsPageRefreshRequested());
            },
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemCount:
                          state.assignedForms.length + inactiveForms.length,
                      itemBuilder: (context, index) {
                        int inactiveFormsIndex = index - state.assignedForms.length;
                        return Padding(
                          padding: const EdgeInsets.all(AppPadding.p20),
                          child: index >= state.assignedForms.length
                              ? InactiveFormCard(
                                  onSync: () {
                                    context.read<FormsBloc>().add(
                                        FormDataSyncRequested(
                                            formId: inactiveForms[inactiveFormsIndex]
                                                .id));
                                  },
                                  viewSubmittedCallBack: () {},
                                  formName: inactiveForms[inactiveFormsIndex].name,
                                  submitNewFormCallBack: () {})
                              : FormCard(
                                  onSync: () {
                                    context.read<FormsBloc>().add(
                                        FormDataSyncRequested(
                                            formId:
                                                state.assignedForms[index].id));
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
                                                      value: context
                                                          .read<FormsBloc>(),
                                                    ),
                                                  ],
                                                  child: SubmissionsScreen(
                                                    formModel: state
                                                        .assignedForms[index],
                                                  ),
                                                )));
                                  },
                                  formName: state.assignedForms[index].name,
                                  submitNewFormCallBack: () {
                                    context.read<FormsBloc>().add(
                                        NewFormRequested(
                                            state.assignedForms[index]));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => BlocProvider.value(
                                                  value:
                                                      context.read<FormsBloc>(),
                                                  child: NewSubmitScreen(
                                                      formModel:
                                                          state.assignedForms[
                                                              index]),
                                                )));
                                  },
                                  showSyncButton: _showSyncButton(state, index),
                                ),
                        );
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  bool _showSyncButton(FormsState state, int index) {
    return state.formHasSubmissions[state.assignedForms[index].id] == true;
  }
}
