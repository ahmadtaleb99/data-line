part of 'home_bloc.dart';

@immutable
 class HomeState extends Equatable {



 final  List<FormModel> assignedForms;

  HomeState({
    required this.assignedForms,
  });

 HomeState copyWith({
    List<FormModel>? assignedForms
  }) {
    return HomeState(
      assignedForms: assignedForms ?? this.assignedForms,
    );
  }



 @override
 List<Object> get props => [assignedForms];

}

