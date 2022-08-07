import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_test/presentation/resources/values_manager.dart';

class SubmissionsScreen extends StatelessWidget {
  const SubmissionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(itemBuilder: (context, index) => SubmissionCard(),
          separatorBuilder: (context, index) => const Padding(padding: EdgeInsets.all(AppPadding.p20)),
          itemCount: 2),
    );
  }
}



class SubmissionCard extends StatelessWidget {
  const SubmissionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
