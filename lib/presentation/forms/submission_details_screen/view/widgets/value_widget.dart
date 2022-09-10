import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:datalines/data/responses/forms/enums.dart';
import 'package:datalines/domain/model/form_model.dart';
import 'package:datalines/presentation/forms/value_view_parser.dart';
import 'package:datalines/presentation/forms/submission_details_screen/bloc/submission_details_bloc.dart';
import 'package:datalines/presentation/resources/color_manager.dart';
import 'package:datalines/presentation/resources/strings_manager.dart';
import 'package:datalines/presentation/resources/values_manager.dart';
import 'package:percent_indicator/percent_indicator.dart';
class ValueWidget extends StatelessWidget {
final FormFieldModel field;
  final dynamic value;
  @override
  Widget build(BuildContext context) {
    if (field.type == FieldType.FILE){
      return
        BlocBuilder<SubmissionDetailsBloc, SubmissionDetailsState>(
  builder: (context, state) {
    return Row(
          children: [
             _getPercent(state) != -1 ?
              Expanded(
                child: CircularPercentIndicator(
                  radius: AppRadius.r20,
                  percent:_getPercent(state) / 100 ,
                  center: new Text((_getPercent(state).toInt()).toString()),
                  progressColor: ColorManager.primary,
                ),
              )
            : Expanded(
              child: ElevatedButton(
                  onPressed: () async {
                    context.read<SubmissionDetailsBloc>().add(FilePreviewRequested(filePath: value));
                  },
                  child: const Text(AppStrings.downloadFile)),
            ),
          ],
        );
  },
);
    }
    if (field.type == FieldType.STAR_RATING){

      return
        RatingBarIndicator(
          rating: value,
          itemBuilder: (context, index) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          itemCount: 5,
          itemSize: 25.0.w,
          direction: Axis.horizontal,
        );
    }




      return Text(ValueViewParser.getValue(value) ,
          overflow: TextOverflow.fade,
          softWrap: true,
        style: Theme.of(context).textTheme.subtitle1,
       );
    }

 const ValueWidget({
   required this.field,
   required this.value,
 });


    double _getPercent (SubmissionDetailsState state){
      if (state.fileDownloadProgress[value] == null) return -1;


      return state.fileDownloadProgress[value] ?? -1;
    }



}


