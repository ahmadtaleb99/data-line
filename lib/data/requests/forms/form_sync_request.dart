
import 'package:datalines/domain/model/form_model.dart';

class FormSyncRequest {
    final String formId;
    final List<Submission> submissions;

    const FormSyncRequest({
    required this.formId,
    required this.submissions,
  });

    Map<String, dynamic> toJson() {

    return {
      'formId': this.formId,
      'submissions': this.submissions.map((submission) => {
        submission.nonNullEntriesAsMap(),
      }..add({'updated_at': submission.updatedAt.toString(),
        'submitted_at': submission.submittedAt.toString(),
        'node': submission.node,
      })).toList(),
    };
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


