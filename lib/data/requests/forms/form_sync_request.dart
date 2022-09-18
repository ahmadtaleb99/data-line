
import 'dart:developer';

import 'package:datalines/data/requests/requests.dart';
import 'package:datalines/domain/model/form_model.dart';

class FormSyncRequest extends BaseRequest{


  final String formId;
    final List<Submission> submissions;

     FormSyncRequest({
    required this.formId,
    required this.submissions,
  });



    Future<Map<String, dynamic>> toMultiPartMapRequest() async {
      //     'updated_at': submission.updatedAt.toString(),
      // 'submitted_at': submission.submittedAt.toString(),
      List submissions = [];
      for(var s in this.submissions){
        submissions.add(await s.entriesToRequest()..['node'] =s.node.id,
        );
      }

     var map =  {
      'formId': this.formId,
      'submissions': submissions
    };

     return map;
  }

    FormSyncRequest copyWith({
    String? formId,
    List<Submission>? submissions,
    String? nodeId,
  }) {
    return FormSyncRequest(
      formId: formId ?? this.formId,
      submissions: submissions ?? this.submissions,
    );
  }

}


