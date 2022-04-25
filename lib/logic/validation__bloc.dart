// ignore_for_file: unnecessary_import

import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:form_builder_test/logic/IoService.dart';
import 'package:form_builder_test/testable.dart';
import 'package:open_file/open_file.dart';
import 'package:bloc/bloc.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:form_builder_test/FormService/FormRepository.dart';
import 'package:form_builder_test/FormService/NotificationsService.dart';
import 'package:form_builder_test/Widgets/DrawChecboxGroup.dart';
import 'package:form_builder_test/Widgets/DrawCheckboxGroupItem.dart';
import 'package:form_builder_test/Widgets/DrawChildList.dart';
import 'package:form_builder_test/Widgets/DrawDropDownButton.dart';
import 'package:form_builder_test/Widgets/DrawFilePicker.dart';
import 'package:form_builder_test/Widgets/DrawForm.dart';
import 'package:form_builder_test/Widgets/DrawMultiSelect.dart';
import 'package:form_builder_test/Widgets/DrawRadioGroup.dart';
import 'package:form_builder_test/Widgets/DrawTextField.dart';
import 'package:form_builder_test/constants.dart';
import 'package:form_builder_test/dynamic%20form/DropDownItem.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/FormModel.dart';
import 'package:form_builder_test/dynamic%20form/IFormDrawRadioGroup.dart';
import 'package:form_builder_test/dynamic%20form/IFormDropList.dart';
import 'package:form_builder_test/dynamic%20form/IFormTextField.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../UpdateFormPage.dart';

part 'validation__event.dart';
part 'validation__state.dart';

class ValidationBloc extends Bloc<ValidationEvent, ValidationState> {
  FormRepository _formRepository;
  IoService _ioService = IoService();
  // ReceivePort _receivePort = ReceivePort();

  ValidationBloc(this._formRepository)
        : super(ValidationState(
    filePicking: false,
          childsMap: {},
        )) {

    AwesomeNotifications().actionStream.listen((action) {
      if(action.buttonKeyPressed == 'stopDownload '){
        _ioService.stopCopying();
      }


      else
      OpenFile.open(action.payload!['value']);

    });


    AwesomeNotifications().displayedStream.listen((event) {
      if(event.id == 1){

      }
    });
    on<CheckboxGroupValueChanged>(_onCheckboxGroupValueChanged);
    on<FormsRequested>(_onFormsRequested);
    on<FormRequested>(_onFormRequested);
    on<ParentDropListChanged>(_onParentDropListChanged);
    on<childDropDownChanged>(_onchildDropDownChanged);
    on<RadioGroupValueChanged>(_onRadioGroupValueChanged);
    on<OtherRadioValueChanged>(_onOtherRadioValueChanged);
    on<MultiSelectItemRemoved>(_onMultiSelectItemRemoved);
    on<ServiceRegistered>(_onServiceRegistered);
    on<FormsRequestedFromLocal>(_onFormsRequestedFromLocal);
    on<TextFieldValueChanged>(_onTextFieldValueChanged);
    on<FormSubmitted>(_onFormSubmitted);
    on<MultiSelectChanged>(_onMultiSelectChanged);
    on<FilePickerPressed>(_onFilePickerPressed);
    on<SubmittionsFormsRequested>(_onSubmittionsFormsRequested);
    on<FormUpdatePageRequested>(_onFormUpdatePageRequested);
    on<FormUpdated>(_onFormUpdated);
    on<FormDeleted>(_onFormDeleted);
    on<FormUpdateRequested>(_onFormUpdateRequested);
    on<FilePickerSaved>(_onFilePickerSaved);
    on<FilePreviewRequested>(_onFilePreviewRequested);
    on<FileDownloadedNotification>(_onFileDownloadedNotification);
  }

  Future<void> _onFormsRequested(
      FormsRequested event, Emitter<ValidationState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      var forms = await _formRepository.LoadFormsModel();

      emit(state.copyWith(
          status: Status.success,
          forms: forms.map((e) => e.toWidget() as FormWidget).toList()));
    } on SocketException {
      emit(state.copyWith(islocallyWorking: true));
      add(FormsRequestedFromLocal());
    }
  }

  void _onMultiSelectChanged(
      MultiSelectChanged event, Emitter<ValidationState> emit) {
    var select = event.select as DrawMultiSelect;

    select.selectedValues = event.value;
    select.value = event.value;

    emit(state.copyWith());
  }

  void _onFileDownloadedNotification(
      FileDownloadedNotification event, Emitter<ValidationState> emit) {
    // NotificationService.showNotification(title: 'title', body: 'body', payload: event.path);
  }

  Future<void> _onFormsRequestedFromLocal(
      FormsRequestedFromLocal event, Emitter<ValidationState> emit) async {
    var forms = await _formRepository.getAvailableFormsFromLocal();

    emit(state.copyWith(
        status: Status.success,
        forms: forms.map((e) => e.toWidget() as FormWidget).toList()));
  }

  Future<void> _onServiceRegistered(
      ServiceRegistered event, Emitter<ValidationState> emit) async {
    print('service  inited');

    await _formRepository.initLocal();
    await _ioService.init();
  }
/////////////////////////////////////////////////////
  /////////////////////////////
  /////////////////////////////
  /////////////////////////////
  /////////////////////////////
  Future<void> _onFilePreviewRequested(
      FilePreviewRequested event, Emitter<ValidationState> emit) async {
    File cachedFile = File(event.path);
    String fileName = basename(cachedFile.path);

    String ?  newFilePath = await _ioService.copyToDownloads(cachedFile);
int progress  = 0 ;
    _ioService.copyProgress.listen((event) {
      progress = event.toInt();
      AwesomeNotifications().createNotification(
                actionButtons: [
                  NotificationActionButton(key: 'stopDownload', label: 'Stop Download')
                ],
          content: NotificationContent(

              id:  1,
              channelKey: 'second',
              title: 'downloading: $fileName',
              body: '$progress',
              progress: progress,
              notificationLayout: NotificationLayout.ProgressBar,
              category: NotificationCategory.Progress,payload:{'value' : newFilePath!} ));
    },
       onDone: () async {
         print('done ');
         print(newFilePath);
        var file = File(newFilePath!);
         print( file.existsSync());
         AwesomeNotifications().createNotification(
          content: NotificationContent(
              id:  1,
              channelKey: 'second',
              title: ' download complete for file $fileName',
              body: ' tap to preview',
              bigPicture: 'file://$newFilePath',
              notificationLayout: NotificationLayout.BigPicture,
              category: NotificationCategory.Event,payload:{'value' : newFilePath} ));
    }
    );

    print(progress);


  }

  Future<void> _onSubmittionsFormsRequested(
      SubmittionsFormsRequested event, Emitter<ValidationState> emit) async {
    var forms = _formRepository.getAllSubmissionByName(event.formName);
    emit(state.copyWith(
        subedForms: forms.map((e) => e.toWidget() as FormWidget).toList()));
  }

  Future<void> _onFormUpdatePageRequested(
      FormUpdatePageRequested event, Emitter<ValidationState> emit) async {
    print('fast');

    var formModel = _formRepository.submittedForms[event.index];
    var formWidget = formModel.toWidget() as FormWidget;
    emit(state.copyWith(
      submitted: false,
        form: formWidget, status: Status.success, formModel: formModel));
  }

  Future<void> _onFormUpdated(
      FormUpdated event, Emitter<ValidationState> emit) async {
    var formModel = _formRepository.submittedForms[event.index];

    _mapWidgetValuesToModel(formModel, state.form!);

    _formRepository.updateSubmission(formModel);

    emit(state.copyWith(
      submitted: true,
      subedForms: _formRepository.submittedForms
          .map((e) => e.toWidget() as FormWidget)
          .toList(),
      form: formModel.toWidget() as FormWidget,
    ));
  }



  Future<void> _onFormDeleted(
      FormDeleted event, Emitter<ValidationState> emit) async {
    var formModel = _formRepository.submittedForms[event.index];
    print(formModel.key.toString() + 'asdasdasdasd');
    await _ioService.deleteSubmissionCache(formModel.key, formModel);

    _formRepository.deleteForm(formModel);
    var forms = _formRepository.submittedForms;
    emit(state.copyWith(
        subedForms: forms.map((e) => e.toWidget() as FormWidget).toList()));
  }

  void _onCheckboxGroupValueChanged(
      CheckboxGroupValueChanged event, Emitter<ValidationState> emit) {
    var group = state.form!.fields.firstWhere((element) =>
            (element is DrawCheckboxGroup) && element.name == event.groupName)
        as DrawCheckboxGroup;

    List<String> valuesList = group.value;

    if (event.newIsChecked == true) {
      valuesList.add(event.value);
      group.checksNumber++;
    } else {
      valuesList.remove(event.value);
      group.checksNumber--;
    }

    var child =
        group.children.firstWhere((element) => element.value == event.id);
    child.isChecked = event.newIsChecked;

    emit(state.copyWith(drawCheckboxGroup: group));
  }

  void _onParentDropListChanged(
      ParentDropListChanged event, Emitter<ValidationState> emit) {
    dynamic childLists = state.form!.fields
        .where((dynamic element) =>
            ((element is DrawChildList) || (element is DrawMultiSelect)) &&
            (element.parentName == event.drawDropDownButton.name))
        .toList();
    event.drawDropDownButton.value = event.parent;

    for (var childList in childLists) {
      List<DropDownItem> items = (_formRepository.availableForms
              .firstWhere((element) => element.name == state.form!.name)
              .fields
              .firstWhere((element) =>
                  element is IFormDropList &&
                  childList.name == element.name) as IFormDropList)
          .items;

      childList.items =
          items.where((element) => element.parent == event.parent).toList();
      childList.value = null;
      if (childList is DrawMultiSelect) childList.selectedValues = [];
    }

    emit(state.copyWith());
  }

  void _onchildDropDownChanged(
      childDropDownChanged event, Emitter<ValidationState> emit) {
    var ch = event.childList;
    if (ch is DrawChildList) {
      ch.value = event.value;
    }

    emit(state.copyWith());
  }

  void _onOtherRadioValueChanged(
      OtherRadioValueChanged event, Emitter<ValidationState> emit) {
    //
    // var radioWidget = state.form!.fields.firstWhere((element) =>
    // (element is DrawRadioGroup) && element.name == event.groupName);
    //
    // IFormDrawRadioGroup radioModel = state.formModel!.fields.firstWhere((element) => element is IFormDrawRadioGroup && element.name == event.groupName) as IFormDrawRadioGroup;
    //
    //
    // radioModel.otherValue = event.value;
    // emit(state.copyWith());
  }

  void _onRadioGroupValueChanged(
      RadioGroupValueChanged event, Emitter<ValidationState> emit) {
    var radioGroup = state.form!.fields.firstWhere((element) =>
            (element is DrawRadioGroup) && element.name == event.groupName)
        as DrawRadioGroup;

    radioGroup.value = event.value;
    for (var child in radioGroup.children) {
      child.groupValue = event.value;
    }
    if (event.value == 'other') {
      radioGroup.isOtherSelected = true;
    } else
      radioGroup.isOtherSelected = false;

    var newForm = _checkRelatedFields(event.value);
    emit(state.copyWith(form: newForm, status: Status.success));
  }

  FormWidget _checkRelatedFields(String fieldValue) {
    var form = state.form!;
    for (var formElement in form.fields) {
      if (formElement.showIfValueSelected! &&
          formElement.showIfFieldValue == fieldValue)
        formElement.visible = true;
      else
        formElement.visible = false;
    }

    return form;
  }

  void _onMultiSelectItemRemoved(
      MultiSelectItemRemoved event, Emitter<ValidationState> emit) {
    var select = state.form!.fields
            .firstWhere((element) => element.name == event.selectName)
        as DrawMultiSelect;
    select.selectedValues!.remove(event.item);
    emit(state.copyWith(initialMulti: select.selectedValues));
  }

  void _onTextFieldValueChanged(
      TextFieldValueChanged event, Emitter<ValidationState> emit) {
    var textField = state.form!.fields
            .firstWhere((element) => element.name == event.textFieldName)
        as DrawTextField;

    textField.value = event.value;
  }

  Future<void> _onFormRequested(
      FormRequested event, Emitter<ValidationState> emit) async {
    var formModel = _formRepository.availableForms
        .firstWhere((element) => element.name == event.formName);
    var form = formModel.toWidget() as FormWidget;

    emit(state.copyWith(form: form, formModel: formModel,submitted: false));
  }

  Future<void> _onFormUpdateRequested(
      FormUpdateRequested event, Emitter<ValidationState> emit) async {
    var formModel = _formRepository.submittedForms[event.index];
    var form = formModel.toWidget() as FormWidget;

    emit(state.copyWith(form: form, formModel: formModel,      submitted: false,
    ));
  }

  void _onFormSubmitted(FormSubmitted event, Emitter<ValidationState> emit) {
    var formModel = _formRepository.availableForms
        .firstWhere((element) => element.name == event.formName)
        .copyWith();
    var stateForm = state.form!;
    _mapWidgetValuesToModel(formModel, stateForm);

    _formRepository.addSubmittedForm(formModel);
    emit(state.copyWith(submitted: true));
  }

  void _mapWidgetValuesToModel(FormModel formModel, FormWidget formWidget) {
    for (int i = 0; i < formModel.fields.length; i++) {
      var widgetFields = formWidget.fields[i];
      var formModelField = formModel.fields[i];
      if (widgetFields is DrawRadioGroup && widgetFields.isOtherSelected!) {
        var radio = formModelField as IFormDrawRadioGroup;
        radio.isOtherSelected = true;
      }

      formModelField.value = widgetFields.value;
    }
  }

  void _onFilePickerSaved(
      FilePickerSaved event, Emitter<ValidationState> emit) async {
    emit(state.copyWith(status: Status.loading));
    File fileToCopy = event.file;
    int? submissionKey = state.formModel!.key;
    String formName = state.formModel!.name;


    if (submissionKey == null) {
      // form has no submission
      submissionKey = _formRepository.getLastSubmissionID() + 1;
    }


   var newPath =  await _ioService.cacheFile(submissionKey, formName, fileToCopy);

    event.filePicker.value = newPath;
    emit(state.copyWith(status: Status.success));
  }

  void _onFilePickerPressed(

  FilePickerPressed event, Emitter<ValidationState> emit) async {
    emit(state.copyWith(submitted: false));


    var filePicker = event.drawFilePicker;
    PlatformFile? pickedFile;
    FilePickerResult? result = await FilePicker.platform

        .pickFiles(allowMultiple: false, type: FileType.any,onFileLoading: (fileStatus){
          if (fileStatus == FilePickerStatus.picking)
            emit(state.copyWith(filePicking: true  )   );
      else
          if (fileStatus == FilePickerStatus.done)
            {
              print ('done picking ; : : : : : ');
              emit(state.copyWith(filePicking: false  ));


              }
    });

    if (result != null) {
      pickedFile = result.files.single;
      print('asdasdas');

      filePicker.pickedFile = pickedFile;
      filePicker.value = pickedFile.path;
      filePicker.setStateFile(File(filePicker.value));
    } else {
      // User canceled the picker
    }

    emit(state.copyWith());

  }

  @override
  Future<void> close() {
    AwesomeNotifications().actionSink.close();

    return super.close();
  }
}
