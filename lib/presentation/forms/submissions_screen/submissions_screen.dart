import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_test/presentation/resources/values_manager.dart';

class SubmissionsScreen extends StatelessWidget {
  const SubmissionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
          itemBuilder: (context, index) => SubmissionCard(
            onUpdate: (){

            },
          ),
          separatorBuilder: (context, index) =>
              const Padding(padding: EdgeInsets.all(AppPadding.p20)),
          itemCount: 2),
    );
  }
}

class SubmissionCard extends StatelessWidget {

  final  void Function()? onView;
  final  void Function()? onDelete;
  final  void Function()? onUpdate;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppPadding.p20),
      height: 150.h,
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10)),
      child: Card(
        elevation: 10,
        color: Colors.lightBlueAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Form Name',style: Theme.of(context)
                .textTheme
                .overline!,),
            Row(children: [
              Text('field Name'),
              Text('field value'),
            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: onView,
                    icon: Icon(
                      Icons.visibility,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: onUpdate,
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: onDelete,
                    icon: Icon(
                      Icons.delete_rounded,
                      color: Colors.white,
                    )),
              ],
            ),



          ],
        ),
      ),
    );
  }

  const SubmissionCard({
    this.onView,
    this.onDelete,
    this.onUpdate,
  });
}
