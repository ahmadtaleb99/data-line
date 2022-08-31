import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:form_builder_test/data/responses/forms/enums.dart';
import 'package:form_builder_test/domain/model/form_model.dart';
import 'package:form_builder_test/presentation/forms/submission_details_screen/bloc/submission_details_bloc.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';

class ValueWidget extends StatelessWidget {
final FormFieldModel field;
  final dynamic value;
  @override
  Widget build(BuildContext context) {
    if (field.type == FieldType.FILE){
      return
        ElevatedButton(
            onPressed: () async {
              context.read<SubmissionDetailsBloc>().add(FilePreviewRequested(filePath: value));
            },
            child: const Text(AppStrings.downloadFile));
    }
    if (field.type == FieldType.STAR_RATING){

      return
        RatingBarIndicator(
          // rating: field.value,
          itemBuilder: (context, index) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          itemCount: 5,
          itemSize: 25.0,
          direction: Axis.horizontal,
        );
    }



      return Text(value.toString() ,
          overflow: TextOverflow.fade,
          softWrap: true,
        style: Theme.of(context).textTheme.subtitle1,
       );
    }

 const ValueWidget({
   required this.field,
   required this.value,
 });

}


