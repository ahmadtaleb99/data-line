
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:form_builder_test/presentation/home/bloc/home_bloc.dart';
import 'package:form_builder_test/presentation/resources/values_manager.dart';
import 'package:form_builder_test/presentation/state_renderer_bloc/state_renderer_bloc.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body:
    BlocBuilder<StateRendererBloc, StateRendererState>(
      builder: (context, state) {
        if (state.flowState != null) {
          var widget = state.flowState.getWidget(context,const  NewWidget(), () {
            context.read<HomeBloc>().add(AssignedFormsRequested());
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
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return GridView.builder(
            gridDelegate:
          const   SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: state.assignedForms.length,
            itemBuilder: (context, index) {
              log(state.assignedForms.first.name.toString());
              return Padding(
                padding: EdgeInsets.all(AppPadding.p20),
                child: FormCard(viewSubmittedCallBack: () {

                },
                    formName:state.assignedForms[index].name,
                    submitNewFormCallBack: () {}),
              );
            });
      },
    );
  }
}

class FormCard extends StatelessWidget {
  const FormCard({Key? key,
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
                    child: Text(formName,style: Theme.of(context).textTheme.overline!.copyWith(fontWeight: FontWeight.bold,fontSize: 18),))),
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
