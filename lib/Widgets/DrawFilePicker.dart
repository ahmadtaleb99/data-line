import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/Expression.dart';
import 'package:form_builder_test/Widgets/FormFieldWidget.dart';
import 'package:form_builder_test/dynamic%20form/FileTypeEnum.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';
import 'IDrawable.dart';
import 'package:path/path.dart';
class DrawFilePicker extends  FormElementWidget {


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
  void setStateFile(File file) {
    _fieldState.didChange(file);
  }

  @override
  Widget build(BuildContext context) {
    String ?  fileName;

      return FormFieldWidget(
        required: required,
        widget: BlocBuilder<ValidationBloc, ValidationState>(

          builder: (context, state) {
            return FormField<File>(
              onSaved: (file){

                if(file != null){
                  log('on saved file');
                  context.read<ValidationBloc>().add(FilePickerSaved(file : file,filePicker: this));

                }
                else
                  log('no saved  file');


              },
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (file)  {
                if(file==null && required)
                  return 'required';

                if( file != null &&   file.lengthSync() /1000000 > maxFileSize  )
                  return 'file can\'t be larger than $maxFileSize MB';
                else return null;

              },
              initialValue: value == null ? null : File(value),
             builder: (FormFieldState<File> fieldState) {
                _fieldState = fieldState;

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
                   if(state.filePicking)
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Column(
                         children: [
                           CircularProgressIndicator(),
                           SizedBox(height: 5,),
                           Text('file is beign picked ...',style: TextStyle(
                               fontWeight: FontWeight.bold
                           ),),
                         ],
                       ),
                     ),
               if ( value != null )
                     Text('Picked File:  ${basename(value)}',style: TextStyle(
                         fontWeight: FontWeight.bold
                     ),),

                   if (fieldState.hasError)
                     Padding(
                       padding: const EdgeInsets.only(left: 8, top: 10),
                       child: Text(
                         _fieldState.errorText!,
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
            );
          },
        ), visible: visible,
      );
  }


  void _mapFileType(String fileType){

  }

  @override
  String valueToString() {
    return this.value.toString();
  }
}
