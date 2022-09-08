import 'dart:developer';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:datalines/Widgets/checkbox_group_widget.dart';
import 'package:datalines/Widgets/child_dropdown_widget.dart';
import 'package:datalines/Widgets/dropdown_widget.dart';
import 'package:datalines/Widgets/multi_select_widget.dart';
import 'package:datalines/Widgets/number_field_widget.dart';
import 'package:datalines/Widgets/radio_group_widget.dart';
import 'package:datalines/Widgets/form_element_widget.dart';
import 'package:datalines/Widgets/star_rating_widget.dart';

import '../../../validation/bloc/validation__bloc.dart';
import 'package:flutter/material.dart';
import 'package:datalines/Widgets/file_picker_widget.dart';
import 'package:datalines/Widgets/form_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubmittionsDetailsPage extends StatelessWidget {
  final FormWidget formWidget;
  const SubmittionsDetailsPage({Key? key, required this.formWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rows = _buildRows(formWidget);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Details'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        itemCount: rows.length+1,
        itemBuilder: (context, index) {
          return index == 0
              ? const Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 30),
                  child: LabelWidget(),
                )
              :  rows[index-1];
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
          thickness: 2,
        ),
      ),
    );
  }
}

class LabelWidget extends StatelessWidget {
  const LabelWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text('Field',
            style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold)),
        Text('Value',
            style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}

Widget _getFormElementThumbnail(FormElementWidget field) {
  if (field is CheckboxGroupWidgetOld) {
    return const FieldHintWidget(text: '(Checkbox Group)');
  }
  if (field is RadioGroupWidget) {
    return const FieldHintWidget(text: '(Radio Group)');
  }
  if (field is MultiSelectWidget ||
      field is ChildDropDownWidget ||
      field is OldDropDownWidget) {
    return const FieldHintWidget(text: '(Select)');
  }

  if (field is oldFilePicker) {
    return Container();
  }
  if (field is oldStarRatingWidget) {
    return const FieldHintWidget(text: '(Star Rating)');
  }
  if (field is NumberFieldWidget) {
    return const FieldHintWidget(text: '(Number)');
  } else
    return const FieldHintWidget(text: '(Text)');
}

class FieldHintWidget extends StatelessWidget {
  final String text;
  const FieldHintWidget({
    Key? key,
    required  this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Text(text, style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.lightBlueAccent,fontStyle: FontStyle.italic));

  }
}

List<Widget> _buildRows(FormWidget formWidget) {
  List<Widget> rows = [];
  for (var field in formWidget.fields) {
    if (field.value != null) {
      rows.add(

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: FieldWidget(field: field),flex: 3,),
                Expanded(child: ValueWidget(field: field),flex: 2,)
              ],
            ),
          ));
    }
    else       log('value is null ${field.label} ');

  }

  return rows;
}

class ValueWidget extends StatelessWidget {
  FormElementWidget field;

  @override
  Widget build(BuildContext context) {
    if ( field is oldFilePicker){
      log('field is DrawFilePicker :::::::::::::::::::::::::::: ') ;
      return
        ElevatedButton(
            onPressed: () async {
              context
                  .read<ValidationBloc>()
                  .add(oldFilePreviewRequested(path: field.value));
            },
            child: const Text('download file'));
    }
   if ( field is oldStarRatingWidget){
      log('field is DrawFilePicker :::::::::::::::::::::::::::: ') ;
      return
        RatingBarIndicator(
          rating: field.value,
          itemBuilder: (context, index) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          itemCount: 5,
          itemSize: 25.0,
          direction: Axis.horizontal,
        );
    }

    else {
      log('field isnt DrawFilePicker ') ;

      return Text(field.valueToString() ?? 'empty',
          overflow: TextOverflow.fade,
          softWrap: true,
          style: const TextStyle(
              fontSize: 15,
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold));
    };
  }

  ValueWidget({
    required this.field,
  });
}
class FieldWidget extends StatelessWidget {
  FormElementWidget field;

  @override
  Widget build(BuildContext context) {
    return    Row(
      children: [
        Text(field.label, style: Theme.of(context).textTheme.subtitle1),
    SizedBox(
    width: 5.w,
    ),
    _getFormElementThumbnail(field)
      ],
    );

  }

  FieldWidget({
    required this.field,
  });
}

