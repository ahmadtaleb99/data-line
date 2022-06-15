import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/dynamic%20form/matrix/fields/matrix_record.dart';

import '../../dynamic form/IFormModel.dart';
import '../../logic/validation__bloc.dart';
import '../IDrawable.dart';

class MatrixRecord extends FormElementWidget {

  Widget setupAlertDialoadContainer(List children) {
    GlobalKey<FormState> _key = GlobalKey<FormState>();

    return BlocBuilder<ValidationBloc, ValidationState>(
      builder: (context, state) {
        return Container(
          height: 300.0, // Change as per your requirement
          width: 300.0, // Change as per your requirement
          child: Form(
            key: state.key,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: children.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:  EdgeInsets.all(10),
                  child: children[index],
                );
              },
            ),
          ),
        );
      },
    );
  }

  MatrixRecord({Key? key,  this.isLast = true, required this.children}) : super(key: key,name: 'sad',label: '');
  bool  isLast;
  List<FormElementWidget> children;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidationBloc, ValidationState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 0, top: 4),
                child: Container(
                  height: 50,
                  width: 50,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    elevation: 10,
                    child: ListTile(
                      onTap: (){
                        showRecordDialog(context, state.key);
                      },

                      trailing: Text('asd'),
                      leading: Text('children.first.name'),
                    ),
                  ),
                ),
              ),
            ),
            if (isLast)
              IconButton(
                  onPressed: () {
                    context
                        .read<ValidationBloc>()
                        .add(RecordAdded(matrixName: 'matrix_1655016823189',context: context));


                  },
                  icon: Icon(Icons.add_circle))
            else
              IconButton(
                  onPressed: () {
                    context
                        .read<ValidationBloc>()
                        .add(RecordRemoved(matrixName: 'matrix_1655016823189',matrixRecord: this));
                  },
                  icon: Icon(Icons.remove))
          ],
        );
      },
    );
  }

  @override
  String valueToString() {
    // TODO: implement valueToString
    throw UnimplementedError();
  }
  MatrixRecordModel toModel(){
    return MatrixRecordModel(fields: this.children.map((dynamic e) => e.toModel()).toList().cast());
  }



  void showRecordDialog(BuildContext context,GlobalKey<FormState> key){
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add'),
            content: setupAlertDialoadContainer(children),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  Expanded(
                    child: ElevatedButton(
          style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
          )
          ),
                        onPressed: (){
                      if(key.currentState!.validate())
                      {
                        Navigator.pop(context);
                      }
                    }, child: Text('submit')),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: ElevatedButton(style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
          )
          ),onPressed: () {
                      this.children.forEach((element) {element.value = null;});
                      Navigator.pop(context);


                    }, child: Text('clear'),

                 ),
                  )
                ],
                ),
              )
            ],
          );
        });
  }
}
