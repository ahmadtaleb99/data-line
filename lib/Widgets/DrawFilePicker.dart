import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/Expression.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';
import 'IDrawable.dart';
class DrawFilePicker extends  IDrawable {


  DrawFilePicker( {
    Key ? key,
    required this.label,
     this.visible,
    this.validator,
    required this.required,
    required this.name,
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
  final String ? showIfFieldValue;
  final bool ? showIfIsRequired;
  final int maxFileSize;
  final FileTypeEnum fileType;
  String? Function(File?)? validator;
  PlatformFile ?  _pickedFile;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: this.visible == true ?   const EdgeInsets.only(top: 10) :  const EdgeInsets.only(top: 10),
      child: BlocBuilder<ValidationBloc, ValidationState>(
        builder: (context, state) {
          return Visibility(
            visible:   visible!,
            maintainState: true,
            maintainSize: false,
            child: FormField<PlatformFile>(

              validator: (file) {
                if(file==null )
                  return 'required';

                if(_pickedFile!.size /1000000 > maxFileSize )
                  return 'file can\'t be larger than $maxFileSize MB';
                else return null;

              },
             builder: (FormFieldState<PlatformFile> fieldState) {

               return Column(
                 children: [
                   Container(

                     width: double.infinity,
                     child: ElevatedButton(
                       style: ElevatedButton.styleFrom(
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                       ),
                       onPressed: () async {
                         FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false,type: FileType.video);

                         if (result != null) {
                           _pickedFile = result.files.single;
                           print(_pickedFile!.size /1000000);
                           fieldState.didChange(_pickedFile);
                         } else {
                           // User canceled the picker
                         }
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

}
