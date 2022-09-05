import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_test/presentation/resources/values_manager.dart';

class MatrixDialog extends StatelessWidget {
  final List<Widget> widgets;
  @override
  Widget build(BuildContext context) {
   return Container(
      height: 300.0.h,
      width: 300.0.w,
      child: Scrollbar(
        radius: const Radius.circular(AppRadius.r10),
        thickness: 1,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widgets.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(AppPadding.p12),
              child: widgets[index],
            );
          },
        ),
      ),
    );
  }

  const MatrixDialog({
    required this.widgets,
  });
}

