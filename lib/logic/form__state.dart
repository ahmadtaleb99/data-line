// ignore_for_file: must_be_immutable

part of 'form__bloc.dart';

@immutable
abstract class BlocFormState  extends Equatable{}

class FormInitial extends BlocFormState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class FormLoading extends BlocFormState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}


class FormLoaded extends BlocFormState {
  DrawCheckboxGroup ?  drawCheckboxGroup;
  DrawDropDown ?  drawDropDownButton;
  DrawRadioGroup  ? radioGroup;
  List<DropDownItem>  childItems ;
  List<DrawChildList> ?   childLists ;
  List ? formElements;
  Map<String,DrawChildList>  childsMap;

  FormLoaded({
    this.drawCheckboxGroup,
    this.formElements,
    this.drawDropDownButton,
    this.radioGroup,
    required this.childsMap ,
    this.childLists  = const [],
    this.childItems = const [],
  });

   FormLoaded copyWith({
    List? formElements,

    DrawCheckboxGroup? drawCheckboxGroup,
    DrawDropDown? drawDropDownButton,
    DrawRadioGroup  ? radioGroup,

    List<DropDownItem>? childItems,
    List<DrawChildList>?  childLists,
    DrawChildList? childList,
    Map<String,DrawChildList> ? childsMap

  }) {
    return FormLoaded(
        formElements: formElements ?? this.formElements,
        drawCheckboxGroup: drawCheckboxGroup ?? this.drawCheckboxGroup,
        drawDropDownButton: drawDropDownButton ?? this.drawDropDownButton,
        radioGroup: radioGroup ?? this.radioGroup,
        childItems: childItems ?? this.childItems,
        childLists: childLists ?? this.childLists,
        childsMap: childsMap ?? this.childsMap
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

