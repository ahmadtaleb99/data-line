import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/Expression.dart';
import 'package:form_builder_test/dynamic%20form/FileTypeEnum.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';
import 'IDrawable.dart';
class DrawFilePicker extends  FormElement {


  DrawFilePicker( {
    Key ? key,
    required this.label,
     this.visible,
    this.validator,
    this.value,
    required this.required,
    required this.name,
    required this.deactivate,
    required this.isHidden,
    required this.isReadOnly,
    required this.maxFileSize,
    required this.fileType,
    required this.showIfValueSelected,
    required this.showIfFieldValue,
    required this.showIfIsRequired,
  }) : super(label: label,key: key,
      name: name,
      visible: visible, required: required,
      showIfValueSelected: showIfValueSelected,
      showIfFieldValue: showIfFieldValue,
      showIfIsRequired: showIfIsRequired) ;

  final String label;
  final String name;
  final bool required;
  bool?  visible;
  final bool showIfValueSelected;
  final bool deactivate;
  final bool isReadOnly;
  final bool isHidden;
  final String ? showIfFieldValue;
  final bool ? showIfIsRequired;
  final int maxFileSize;
  final FileTypeEnum fileType;
  String? Function(File?)? validator;
  PlatformFile ?  pickedFile;
  dynamic  value;
  late FormFieldState<File> _fieldState;
  void change(){

  }

  @override
  Widget build(BuildContext context) {
    String ?  fileName;

    return Padding(
      padding: this.visible == true ?   const EdgeInsets.only(top: 10) :  const EdgeInsets.only(top: 10),
      child: BlocBuilder<ValidationBloc, ValidationState>(

        builder: (context, state) {
          return Visibility(
            visible:   visible!,
            maintainState: false,
            maintainSize: false,

            child: FormField<File>(
              onSaved: (file){

              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (file)  {
                print('file size : : : ${file!.lengthSync() /1000000}');
                if(file==null && required)
                  return 'required';

                if( file != null &&   file.lengthSync() /1000000 > maxFileSize  )
                  return 'file can\'t be larger than $maxFileSize MB';
                else return null;

              },
              initialValue: value == null ? null : File(value),
             builder: (FormFieldState<File> fieldState) {

               return Column(
                 children: [
                   Container(

                     width: double.infinity,
                     child: ElevatedButton(
                       style: ElevatedButton.styleFrom(
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                       ),

                       onPressed: () async {
                         context.read<ValidationBloc>().add(FilePickerPressed(drawFilePicker: this));
                         fieldState.validate();

                       },
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [
                           Text(label,style: TextStyle(
                               fontSize: 20
                           ),),
                           Icon(Icons.upload)
                         ],
                       ),

                     ),
                   ),
                   SizedBox(height: 5,),
                   if (value != null )
                     Text(value),
                   if (fieldState.hasError)
                     Padding(
                       padding: const EdgeInsets.only(left: 8, top: 10),
                       child: Text(
                         fieldState.errorText!,
                         style: TextStyle(
                             fontStyle: FontStyle.normal,
                             fontSize: 13,
                             color: Colors.red[700],
                             height: 0.5),
                       ),
                     )
                 ],
               );
             },
            )
          );
        },
      ),
    );
  }


  void _mapFileType(String fileType){

  }

  @override
  String valueToString() {
    return this.value.toString();
  }
}
