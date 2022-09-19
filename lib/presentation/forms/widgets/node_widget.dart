import 'package:datalines/presentation/forms/bloc/forms_bloc.dart';
import 'package:datalines/presentation/resources/color_manager.dart';
import 'package:datalines/presentation/resources/strings_manager.dart';
import 'package:datalines/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/model/node/node.dart';

class NodeWidget extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    return BlocBuilder<FormsBloc, FormsState>(
      builder: (context, state) {
        return
          Container(

            foregroundDecoration: ShapeDecoration(

            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1.0,color: ColorManager.white),
              borderRadius: const BorderRadius.all(Radius.circular(AppRadius.r20)),
            ),
          ),
          margin: EdgeInsets.only(right: 11.w,left: 18.0.w,top: 10.h,bottom: 10.h),
          child: DropdownButton<String>(

            borderRadius: BorderRadius.circular(AppRadius.r20),


            hint:Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: Text(AppStrings.node,
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontStyle: FontStyle.italic,
                      color: ColorManager.white.withOpacity(0.8)
                  )),
            ),
            underline: Container(),
            value:  state.currentNode?.id,
            items: state.nodes
                .map((e) => DropdownMenuItem<String>(
              child: Text(e.name,
                  style: Theme.of(context).textTheme.subtitle1),
              value: e.id,
            ))
                .toList(),
            onChanged: (id) {
              context.read<FormsBloc>().add(CurrentNodeChanged(newNode: state.nodes.firstWhere((node) => node.id == id)));
            },
            selectedItemBuilder: (context){
              return state.nodes
                  .map((e) => DropdownMenuItem<String>(
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: Text(e.name,
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontStyle: FontStyle.italic,
                          color: ColorManager.white
                      )),
                ),
                value: e.id,
              )).toList();
            },

            icon:  Icon(Icons.arrow_drop_down,color: ColorManager.white,),
          ),
          )
        ;
      },
    );
  }

  const NodeWidget();
}
