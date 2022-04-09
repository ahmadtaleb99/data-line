import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/UpdateFormPage.dart';

import 'FormService/FormRepository.dart';
import 'Widgets/DrawForm.dart';
import 'logic/validation__bloc.dart';

class SubmittionsPage extends StatelessWidget {
  FormWidget form;

  SubmittionsPage({Key? key, required this.form}) : super(key: key);
  late GlobalKey<FormState> _key;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text(form.name+' submissions'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<ValidationBloc, ValidationState>(
                builder: (context, state) {
                  if(state.subedForms!.isEmpty)
                    return Text('There are no submitted forms yet');
                  return Expanded(
                    child: ListView.builder(
                        itemCount: state.subedForms!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            child: SubmittionCard(
                              onUpdateCallBack: () {
                                context.read<ValidationBloc>()
                                    .add(FormUpdateRequested(formName: state.subedForms![index].name,index: index));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UpdateFormPage(
                                            index: index,
                                            form: state.subedForms![index])));
                              },
                              onViewCallBack: () {
                                _formDetailsDialog(context: context,form: state.subedForms![index]);
                              },
                              onDeleteCallBack: () {

                                _confirmDeleteDialog(context: context,onConfirm: (){
                                  context.read<ValidationBloc>().add(FormDeleted(index: index,
                                      formName: state.subedForms![index].name),);
                                });



                              },
                            ),
                          );
                        }),
                  );
                },
              ),
            ],
          ),
        ));
  }
}

class SubmittionCard extends StatelessWidget {
  const SubmittionCard(
      {Key? key,
      required this.onDeleteCallBack,
      required this.onViewCallBack,
      required this.onUpdateCallBack})
      : super(key: key);
  final void Function()? onDeleteCallBack;
  final void Function()? onViewCallBack;
  final void Function()? onUpdateCallBack;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 155,
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Expanded(
              flex: 5,
              child: Center(
                  child: Text('formName',
                      style: TextStyle(color: Colors.black, fontSize: 18)))),
          Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: onViewCallBack,
                      icon: Icon(
                        Icons.visibility,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: onUpdateCallBack,
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: onDeleteCallBack,
                      icon: Icon(
                        Icons.delete_rounded,
                        color: Colors.white,
                      )),
                ],
              )),
        ],
      ),
    );
  }
}
void _confirmDeleteDialog ({required BuildContext context, void Function()? onConfirm}){
  showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Center(child: const Text('Please Confirm',style: TextStyle(
            fontWeight: FontWeight.bold,color: Colors.redAccent
          ),)),
          content: const Text('Are you sure to remove this submission?'),
          actions: [
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               ElevatedButton(

                   onPressed: () {
                     onConfirm!();
                     // Close the dialog
                     Navigator.of(context).pop();
                   }
                   ,style: ElevatedButton.styleFrom(
                   shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(20)
                   ),
                   primary: Colors.redAccent
               )
                   , child: Text('Yes')),
               SizedBox(width: 20,),
               ElevatedButton(

                   onPressed: () {
                     // Close the dialog
                     Navigator.of(context).pop();
                   },
                   style: ElevatedButton.styleFrom(
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(20)
                       ),
                       primary: Colors.lightBlueAccent
                   )
                   , child: Text('No')),
             ],
           )

          ],
        );
      });
}
void _formDetailsDialog ({required BuildContext context, void Function()? onConfirm,required FormWidget form}){
  showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(

          title: Center(child: const Text('Form Details')),
          content: Container(
            height: 300,
            width: 400,
            child: ListView.builder(shrinkWrap: true,itemCount: form.fields.length,itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(form.fields[index].label),
                    Text(form.fields[index].value.toString(),style: TextStyle(fontWeight: FontWeight.bold),),


                  ],

                ),
              );
            }),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                
            onPressed: (){
                  Navigator.of(context).pop();

              }
              ,style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                    primary: Colors.lightBlueAccent
                  )
              , child: Text('okay')),
            )
          ],
          // actions: [
          //   // The "Yes" button
          //   TextButton(
          //       onPressed: () {
          //             onConfirm!();
          //         // Close the dialog
          //         Navigator.of(context).pop();
          //       },
          //       child: const Text('Yes')),
          //   TextButton(
          //       onPressed: () {
          //         // Close the dialog
          //         Navigator.of(context).pop();
          //       },
          //       child: const Text('No'))
          // ],
        );
      });
}