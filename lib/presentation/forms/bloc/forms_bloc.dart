import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:datalines/data/network/error_handler.dart';
import 'package:datalines/data/requests/forms/form_sync_request.dart';
import 'package:datalines/data/requests/requests.dart';
import 'package:datalines/domain/model/node/node.dart';
import 'package:datalines/app/extenstions.dart';
import 'package:bloc/bloc.dart';
import 'package:datalines/presentation/forms/bloc/view_objects/sync_form_progress.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:datalines/domain/model/email_text_field_model/email_text_field_model.dart';
import 'package:datalines/domain/model/matrix_model/matrix_model.dart';
import 'package:datalines/domain/model/matrix_model/matrix_record/matrix_record_model.dart';
import 'package:datalines/domain/model/text_area_model/text_area_model.dart';
import 'package:datalines/app/dependency_injection.dart';
import 'package:datalines/app/form_validation.dart';
import 'package:datalines/data/database/hive_database.dart';
import 'package:datalines/data/responses/forms/enums.dart';
import 'package:datalines/domain/model/dropdown_item_model/dropdown_item_model.dart';
import 'package:datalines/domain/model/dropdown_model/dropdown_model.dart';
import 'package:datalines/domain/model/file_picker_model/file_picker_model.dart';
import 'package:datalines/domain/model/form_model.dart';
import 'package:datalines/domain/repository/form_repository.dart';
import 'package:datalines/presentation/common/state_renderer/state_renderer.dart';
import 'package:datalines/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:datalines/presentation/resources/strings_manager.dart';
import 'package:datalines/services/io/FileCachingService.dart';
import '../../../domain/model/checkbox_group_model/checkbox_group_model.dart';
import '../../../domain/model/number_text_field_model/number_text_field_model.dart';

part 'forms_event.dart';
part 'forms_state.dart';

class FormsBloc extends Bloc<FormsEvent, FormsState> with FormValidation {
  final _ioService = getIt<FileCachingService>();
  final _hiveDatabase = getIt<HiveDatabase>();

  final AssignedFormRepository _assignedFormRepository;
  FormsBloc(this._assignedFormRepository)
      : super(FormsState(
            isNewSubmit: true,
            matrixValuesMap: {},
            currentNode: null,
            updateFlowState: ContentState(),
            allSaved: true,
            assignedForms: [],
            nodes: [],
            isFilePicking: {},
            valuesMap: {},
            submissions: [],
            flowState: ContentState(),
            newFlowState: ContentState(),
            validationMap: {},
            inactiveForms: [],
            formHasSubmissions: {})) {
    on<MatrixFieldValueChanged>(_onMatrixFieldValueChanged);
    on<MatrixCheckboxGroupValueChanged>(_onMatrixCheckboxGroupValueChanged);
    on<MatrixTextValueChanged>(_onMatrixTextValueChanged);
    on<NewMatrixRecordAddRequested>(_onNewMatrixRecordAddRequested);
    on<MatrixRecordAEditRequested>(_onMatrixRecordAEditRequested);
    on<MatrixNewRecordSubmitted>(_onMatrixNewRecordSubmitted);
    on<MatrixEditRecordSubmitted>(_onMatrixEditRecordSubmitted);
    on<MatrixRecordDeleted>(_onMatrixRecordDeleted);
    on<MatrixEditCanceled>(_onMatrixEditCanceled);
    on<CurrentNodeChanged>(_onCurrentNodeChanged);
    on<ContentStateEvent>(_onContentStateEvent);

    on<AssignedFormsRequested>(_onAssignedFormsRequested);
    on<AssignedFormsRefreshRequested>(_onAssignedFormsRefreshRequested);
    on<FormsPageRequested>(_onFormsPageRequested);
    on<FormsPageRefreshRequested>(_onFormsPageRefreshRequested);

    on<FieldValueChanged>(_onFieldValueChanged);
    on<TextValueChanged>(_onTextValueChanged);
    on<MultiDropDownValueTapped>(_onMultiDropDownValueTapped);
    on<DropDownValueChanged>(_onDropDownValueChanged);
    on<FilePickerPressed>(_onFilePickerPressed);
    on<FilePickerSaved>(_onFilePickerSaved);
    on<MultiDropDownValueChanged>(_onMultiDropDownValueChanged);
    on<CheckboxGroupValueChanged>(_onCheckboxGroupValueChanged);
    on<RadioGroupValueChanged>(_onRadioGroupValueChanged);
    on<NewFormRequested>(_onNewFormRequested);
    on<SubmissionUpdateRequested>(_onSubmissionUpdateRequested);
    on<MatrixSubmitCanceled>(_onMatrixSubmitCanceled);
    on<FormSubmitted>(_onFormSubmitted);
    on<SubmissionUpdated>(_onSubmissionUpdated);
    on<FormSubmissionBecameEmpty>(_onFormSubmissionBecameEmpty);

    on<FormDataSyncRequested>(_onFormDataSyncRequested);
    on<FormSyncRequestCanceled>(_onFormSyncRequestCanceled);
  }
  bool _isRequired(FormFieldModel model) {
    return model.showIfIsRequired || model.required;
  }

  String? validateTextArea(TextAreaModel model) {
    String value = state.valuesMap[model.name] ?? '';
    if (value.length < model.minLength || value.length > model.maxLength) {
      return AppStrings.mustBeBetween +
          model.minLength.toString() +
          ' ' +
          AppStrings.and +
          ' ' +
          model.maxLength.toString() +
          ' ' +
          AppStrings.character;
    }
    return null;
  }

  String? validateEmail(EmailTextFieldModel model) {
    String value = state.valuesMap[model.name] ?? '';
    if (!isValidEmail(value.trim())) {
      return AppStrings.mustBeAValidEmail;
    }
    return null;
  }

  String? validateNumber(String value, NumberFieldModel model) {
    String value = state.valuesMap[model.name] ?? '';

    // if(_isRequired(model) && value.isEmpty) return AppStrings.fieldReqired;
    if (!isNumeric(value)) return AppStrings.mustBeANumber;

    int intValue = int.parse(value);
    switch (model.operator) {
      case Operator.MORE:
        if (intValue <= model.expressionsValue!)
          return AppStrings.mustBeGreater + model.expressionsValue!.toString();
        break;

      case Operator.LESS:
        if (intValue >= model.expressionsValue!)
          return AppStrings.mustBeSmaller + model.expressionsValue!.toString();
        break;

      case Operator.EQUAL:
        if (intValue != model.expressionsValue!)
          return AppStrings.mustBeEqual + model.expressionsValue!.toString();
        break;

      case Operator.BETWEEN:
        if (!(intValue >= model.expressionsValue! &&
            intValue <= model.expressionsValue2!))
          return AppStrings.mustBeBetween +
              model.expressionsValue!.toString() +
              AppStrings.and +
              ' ' +
              model.expressionsValue2.toString();
        break;
    }

    return null;
  }

  bool formHasValues() {
    return state.valuesMap.values.any((element) => element != null);
  }

  String? validateFile(FilePickerModel model) {
    String? path = state.valuesMap[model.name];
    if (_isRequired(model) && path == null)
      return AppStrings.fieldReqired;
    else if (path != null) {
      File? file = File(path);

      if ((file.lengthSync() / 1000000 > model.maxFileSize)) {
        return AppStrings.fileCantBeLarger +
            ' ' +
            model.maxFileSize.toString() +
            ' ' +
            AppStrings.MB;
      }
    }
    return null;
  }

  String? validateDropDown(DropDownModel model) {
    List list = state.valuesMap[model.name] ?? [];
    if (list.isEmpty && model.required) return AppStrings.fieldReqired;

    return null;
  }

  String? validateCheckboxGroup(CheckboxGroupModel model) {
    List list = state.valuesMap[model.name] ?? [];
    if (list.isEmpty && model.required) return AppStrings.fieldReqired;
    if (model.minMaxCheckbox) {
      if (!((list.length >= model.checkboxMinValue) &&
          (list.length <= model.checkboxMaxValue))) {
        return AppStrings.checkboxMustBeBetween(
            model.checkboxMinValue.toString(),
            model.checkboxMaxValue.toString());
      }
    }
    return null;
  }

  Future<void> _onFormSubmissionBecameEmpty(
      FormSubmissionBecameEmpty event, Emitter<FormsState> emit) async {
    emit(state.copyWith(
        formHasSubmissions: _changeFormHasSubmissionMap(event.formId, false)));
  }

  Future<void> _onAssignedFormsRequested(
      AssignedFormsRequested event, Emitter<FormsState> emit) async {
    emit(state.copyWith(
        flowState: LoadingState(
            stateRendererType: StateRendererType.FULLSCREEN_LOADING)));

    try {
      var either = await _assignedFormRepository.getAssignedForms();
      either.fold((failure) {
        emit(state.copyWith(
            flowState: ErrorState(
                code: failure.code,
                stateRendererType: StateRendererType.FULLSCREEN_ERROR,
                message: failure.message)));
      }, (forms) {
        emit(state.copyWith(assignedForms: forms, flowState: ContentState()));
      });
    } catch (e) {
      emit(state.copyWith(
          flowState: ErrorState(
              stateRendererType: StateRendererType.FULLSCREEN_ERROR,
              message: e.toString())));
    }
  }

  Future<void> _onFormsPageRequested(
      FormsPageRequested event, Emitter<FormsState> emit) async {
    emit(state.copyWith(
        flowState: LoadingState(
            stateRendererType: StateRendererType.FULLSCREEN_LOADING)));

    try {
      var either = await _assignedFormRepository.getFormsHomeModel();
      either.fold((failure) {
        emit(state.copyWith(
            flowState: ErrorState(
                code: failure.code,
                stateRendererType: StateRendererType.FULLSCREEN_ERROR,
                message: failure.message)));
      }, (model) {
        final inactiveForms = _assignedFormRepository.getInactiveForms();
        if (model.forms.isEmpty && (inactiveForms == null || inactiveForms.isEmpty))
          emit(state.copyWith(flowState: EmptyState(AppStrings.noFormAvilable)));
        else {
          log(model.forms.toString());
          log(inactiveForms.toString());
          final hasSubmissionsMap = Map.from(state.formHasSubmissions);
          for (final form in model.forms) {
            if (_assignedFormRepository.formHasSubmissions(form.id))
              hasSubmissionsMap[form.id] = true;
          }
          emit(state.copyWith(
              inactiveForms: inactiveForms,
              formHasSubmissions: hasSubmissionsMap.cast(),
              assignedForms: model.forms,
              nodes: model.nodes,
              flowState: ContentState()));
        }
      });
    } catch (e) {
      emit(state.copyWith(
          flowState: ErrorState(
              stateRendererType: StateRendererType.FULLSCREEN_ERROR,
              message: e.toString())));
    }
  }

  Future<void> _onFormsPageRefreshRequested(
      FormsPageRefreshRequested event, Emitter<FormsState> emit) async {
    emit(state.copyWith(
        flowState:
            LoadingState(stateRendererType: StateRendererType.POPUP_LOADING)));

    try {
      var either = await _assignedFormRepository.getFormsHomeModel(
          forceFromRemote: true);
      either.fold((failure) {
        emit(state.copyWith(
            flowState: ErrorState(
                code: failure.code,
                stateRendererType: StateRendererType.POPUP_ERROR,
                message: failure.message)));
      }, (model) {
        final inactiveForms = _assignedFormRepository.getInactiveForms();
        if (model.forms.isEmpty && (inactiveForms == null || inactiveForms.isEmpty))
          emit(state.copyWith(flowState: EmptyState(AppStrings.noFormAvilable)));
        else
          emit(state.copyWith(
              inactiveForms: inactiveForms,
              assignedForms: model.forms,
              nodes: model.nodes,
              flowState: ContentState()));
      });
    } catch (e) {
      emit(state.copyWith(
          flowState: ErrorState(
              stateRendererType: StateRendererType.FULLSCREEN_ERROR,
              message: e.toString())));
    }
  }

  Future<void> _onAssignedFormsRefreshRequested(
      AssignedFormsRefreshRequested event, Emitter<FormsState> emit) async {
    emit(state.copyWith(
        flowState:
            LoadingState(stateRendererType: StateRendererType.POPUP_LOADING)));

    try {
      var either =
          await _assignedFormRepository.getAssignedForms(forceFromRemote: true);
      either.fold((failure) {
        emit(state.copyWith(
            flowState: ErrorState(
                code: failure.code,
                stateRendererType: StateRendererType.POPUP_ERROR,
                message: failure.message)));
      }, (forms) {
        emit(state.copyWith(assignedForms: forms, flowState: ContentState()));
      });
    } catch (e) {
      emit(state.copyWith(
          flowState: ErrorState(
              stateRendererType: StateRendererType.POPUP_ERROR,
              message: e.toString())));
    }
  }

  Future<void> _onFieldValueChanged(
      FieldValueChanged event, Emitter<FormsState> emit) async {
    Map<String, dynamic> map = Map.from(state.valuesMap);
    map[event.fieldName] = event.value;

    Map<String, bool> newValidationMap = Map.from(state.validationMap);
    newValidationMap[event.fieldName] = true;
    log(map.toString());
    emit(state.copyWith(valuesMap: map, validationMap: newValidationMap));
  }

  Future<void> _onMatrixFieldValueChanged(
      MatrixFieldValueChanged event, Emitter<FormsState> emit) async {
    _changeRecordValue(event.fieldName, event.value);
  }

  Future<void> _onMatrixTextValueChanged(
      MatrixTextValueChanged event, Emitter<FormsState> emit) async {
    final record = _getDesiredRecord();
    if (record != null) record.valuesMap[event.fieldName] = event.value;
  }

  Future<void> _onMatrixCheckboxGroupValueChanged(
      MatrixCheckboxGroupValueChanged event, Emitter<FormsState> emit) async {
    List<String>? groupValuesList =
        List<String>.from(getMatrixFieldValue(event.fieldName) ?? []);
    if (event.isChecked)
      groupValuesList.add(event.value);
    else
      groupValuesList.remove(event.value);

    _changeRecordValue(event.fieldName, groupValuesList);
  }

  void _changeRecordValue(String fieldName, dynamic value) {
    if (state.tempRecord != null) {
      var record = state.tempRecord!.copyWith();
      emit(state.copyWith(
          tempRecord: () => _setRecordValue(record, fieldName, value)));
    } else {
      Map<String, dynamic> valuesMap = Map.from(state.valuesMap);

      List<MatrixRecordModel> recordsList =
          List<MatrixRecordModel>.from(valuesMap[state.currentMatrixName!]);
      var record = recordsList[state.currentRecordIndex!].copyWith();
      recordsList[state.currentRecordIndex!] =
          _setRecordValue(record, fieldName, value);
      valuesMap[state.currentMatrixName!] = recordsList;

      log((state.copyWith(valuesMap: valuesMap) == state).toString());
      emit(state.copyWith(valuesMap: valuesMap));
    }
  }

  _setRecordValue(MatrixRecordModel record, String fieldName, dynamic value) {
    Map<String, dynamic> newRecordValues = Map.from(record.valuesMap);
    newRecordValues[fieldName] = value;
    return record.copyWith(valuesMap: newRecordValues);
  }

  //if temp record is not null, the current opened record is a new one (to be added),
  // or we get it from the list with the index
  MatrixRecordModel? _getDesiredRecord() {
    if (state.tempRecord != null) {
      return state.tempRecord!.copyWith();
    } else {
      Map<String, dynamic> map = Map.from(state.valuesMap);

      var recordsList = map[state.currentMatrixName!] as List?;

      if (recordsList != null)
        //check if index exists or return null
        return recordsList
            .firstWhereIndexedOrNull((i, _) => i == state.currentRecordIndex!)
            ?.copyWith();

      return null;
    }
  }

  _setCurrentRecord(int currentRecordIndex, String currentMatrix) {
    emit(state.copyWith(
        currentRecordIndex: currentRecordIndex, currentMatrix: currentMatrix));
  }

  Future<void> _onNewMatrixRecordAddRequested(
      NewMatrixRecordAddRequested event, Emitter<FormsState> emit) async {
    _setCurrentRecord(event.index, event.matrixName);

    emit(state.copyWith(tempRecord: () => MatrixRecordModel(valuesMap: {})));
  }

  Future<void> _onMatrixRecordAEditRequested(
      MatrixRecordAEditRequested event, Emitter<FormsState> emit) async {
    _setCurrentRecord(event.index, event.matrixName);

    List<MatrixRecordModel> recordsList =
        state.valuesMap[state.currentMatrixName];

    final record = recordsList[state.currentRecordIndex!].copyWith();
    emit(state.copyWith(tempRecord: () => record));
  }

  Future<void> _onMatrixNewRecordSubmitted(
      MatrixNewRecordSubmitted event, Emitter<FormsState> emit) async {
    final tempRecord = state.tempRecord!.copyWith();
    if (tempRecord.areAllValuesNull()) {
      emit(state.copyWith(
          matrixState: MatrixState(
              MatrixStatus.error, AppStrings.cantSubmitEmptyRecordMsg)));
    } else {
      var map = Map.from(state.valuesMap);
      List<MatrixRecordModel>? recordsList =
          state.valuesMap[state.currentMatrixName!];
      recordsList ??= [];
      recordsList = List<MatrixRecordModel>.from(recordsList);

      recordsList.add(tempRecord);

      map[state.currentMatrixName!] = recordsList;
      emit(state.copyWith(
          valuesMap: map.cast(),
          tempRecord: () => null,
          matrixState: MatrixState(
              MatrixStatus.success, AppStrings.cantSubmitEmptyRecordMsg)));
    }

    // log(map[state.currentMatrixName!].runtimeType.toString()+' temp record ;');
  }

  Future<void> _onMatrixEditRecordSubmitted(
      MatrixEditRecordSubmitted event, Emitter<FormsState> emit) async {
    final tempRecord = state.tempRecord!.copyWith();
    var map = Map.from(state.valuesMap);
    List<MatrixRecordModel> recordsList =
        state.valuesMap[state.currentMatrixName!];

    recordsList[state.currentRecordIndex!] = tempRecord;
    map[state.currentMatrixName!] = recordsList;
    emit(state.copyWith(
        valuesMap: map.cast(),
        tempRecord: () => null,
        matrixState: MatrixState(
            MatrixStatus.success, AppStrings.cantSubmitEmptyRecordMsg)));
  }

  String? validateMatrix(MatrixModel model) {
    List<MatrixRecordModel>? records = state.valuesMap[model.name] ?? [];
    if (records!.length > model.maxRecordsCount) {
      Map<String, bool> newValidationMap = Map.from(state.validationMap);
      newValidationMap[model.name] = true;
      emit(state.copyWith(validationMap: newValidationMap));
      return AppStrings.maxRecordCountErrorMsg +
          model.maxRecordsCount.toString();
    } else
      return null;
  }

  Future<void> _onMatrixEditCanceled(
      MatrixEditCanceled event, Emitter<FormsState> emit) async {
    final tempRecord = state.tempRecord!.copyWith();
    var map = Map.from(state.valuesMap);
    List<MatrixRecordModel> recordsList =
        state.valuesMap[state.currentMatrixName!];

    recordsList[state.currentRecordIndex!] = tempRecord;
    map[state.currentMatrixName!] = recordsList;
    emit(state.copyWith(
        valuesMap: map.cast(),
        tempRecord: () => null,
        matrixState: MatrixState(
            MatrixStatus.success, AppStrings.cantSubmitEmptyRecordMsg)));
  }

  Future<void> _onCurrentNodeChanged(
      CurrentNodeChanged event, Emitter<FormsState> emit) async {
    emit(state.copyWith(currentNode: () => event.newNode));
  }


  Future<void> _onContentStateEvent(
      ContentStateEvent event, Emitter<FormsState> emit) async {
    emit(state.copyWith(flowState: ContentState()));
  }

  Future<void> _onMatrixRecordDeleted(
      MatrixRecordDeleted event, Emitter<FormsState> emit) async {
    Map<String, dynamic> map = Map.from(state.valuesMap);
    List<MatrixRecordModel> records = List.from(map[event.matrixName]);
    records.removeAt(event.recordIndex);
    map[event.matrixName] = records;

    emit(state.copyWith(valuesMap: map));
  }

  dynamic getMatrixFieldValue(String fieldName) {
    final record = _getDesiredRecord();
    return record?.valuesMap[fieldName];
  }

  Future<void> _onFilePickerPressed(
      FilePickerPressed event, Emitter<FormsState> emit) async {
    Map<String, dynamic> map = Map.from(state.valuesMap);

    FilePickerResult? result = await FilePicker.platform.pickFiles(
        onFileLoading: (FilePickerStatus status) {
      Map<String, bool> filePickingMap = Map.from(state.isFilePicking);

      if (status == FilePickerStatus.picking) {
        filePickingMap[event.model.name] = true;
        emit(state.copyWith(isFilePicking: filePickingMap));
      }

      if (status == FilePickerStatus.done) {
        filePickingMap[event.model.name] = false;
        emit(state.copyWith(isFilePicking: filePickingMap));
      }
    }
        // type: event.model.fileType.getFilePickerPackageEnum(),

        );

    if (result != null) {
      File pickedFile = File(result.files.single.path!);
      log(pickedFile.path.toString());
      map[event.model.name] = pickedFile.path;
    } else {
      // User canceled the picker
    }

    Map<String, bool> newValidationMap = Map.from(state.validationMap);
    newValidationMap[event.model.name] = true;
    emit(state.copyWith(valuesMap: map, validationMap: newValidationMap));
  }

  Future<void> saveForm() async {
    emit(state.copyWith(
        newSubmitFlowState:
            LoadingState(stateRendererType: StateRendererType.POPUP_LOADING)));

    try {
      if (state.formModel!.hasType(FieldType.FILE)) {
        await _saveFilePickerFiles();
      }

      add(FormSubmitted(state.formModel!));
    } catch (e) {
      emit(state.copyWith(
          allSaved: false,
          newSubmitFlowState: ErrorState(
              stateRendererType: StateRendererType.POPUP_ERROR,
              message: e.toString())));
    }
  }

  Future<void> _saveFilePickerFiles() async {
    FormModel form = state.formModel!.copyWith();

    log('enter saving func');

    final filePickersFields =
        form.fields.where((field) => field.type == FieldType.FILE);
    for (var filePicker in filePickersFields) {
      Map<String, dynamic> map = Map.from(state.valuesMap);
      String? path = map[filePicker.name];
      if (path == null) return;

      String currentFormId = form.id;

      var file = File(path);

      int submissionId = _hiveDatabase.getLastSubmissionId() + 1;
      String newFilePath = '$submissionId-$currentFormId';
      //

      final newPath = await _ioService.cacheFile(file, newFilePath);
      log('cached path : ' + newPath.toString());
      map[filePicker.name] = newPath;

      emit(state.copyWith(valuesMap: map));

      log(map.toString() + ' map from file picker saving');
    }

    log('end saving func');
  }

  Future<void> _onFilePickerSaved(
      FilePickerSaved event, Emitter<FormsState> emit) async {
    Map<String, dynamic> map = state.valuesMap;
    String? path = map[event.model.name];
    {
      if (path == null) return;
    }
    emit(state.copyWith(
        newSubmitFlowState:
            LoadingState(stateRendererType: StateRendererType.POPUP_LOADING)));
    String currentFormName = state.formModel!.name;

    var file = File(path);

    int submissionId = _hiveDatabase.getLastSubmissionId() + 1;
    String newFilePath = '${submissionId}-${currentFormName}';
    //

    final either = await _ioService.cacheFile(file, newFilePath);
    // either.fold((failure) {
    //   emit(state.copyWith(
    //       allSaved: false,
    //       newSubmitFlowState: ErrorState(
    //           stateRendererType: StateRendererType.POPUP_ERROR,
    //           message: failure.message)));
    // }, (newPath) {
    //   map[event.model.name] = newPath;
    //
    //
    //   emit(state.copyWith(newSubmitFlowState: ContentState(), allSaved: true));
    // });
  }

  Future<void> _onTextValueChanged(
      TextValueChanged event, Emitter<FormsState> emit) async {
    Map<String, dynamic> map = state.valuesMap;
    map[event.fieldName] = event.value;

    Map<String, bool> newValidationMap = state.validationMap;
    newValidationMap[event.fieldName] = true;
    // emit(state.copyWith(valuesMap: map,validationMap: newValidationMap  ));
  }

  Future<void> _onMultiDropDownValueTapped(
      MultiDropDownValueTapped event, Emitter<FormsState> emit) async {
    var dropDown = state.formModel!.fields
        .firstWhere((element) => element.name == event.fieldName);
    Map<String, dynamic> map = Map.from(state.valuesMap);

    List<String> selectedValues = List.from(map[event.fieldName]);

    map[event.fieldName] = selectedValues..remove(event.value);

    Map<String, bool> newValidationMap = Map.from(state.validationMap);
    newValidationMap[event.fieldName] = true;
    emit(state.copyWith(valuesMap: map, validationMap: newValidationMap));
  }

  Future<void> _onMultiDropDownValueChanged(
      MultiDropDownValueChanged event, Emitter<FormsState> emit) async {

    Map<String, dynamic> map = Map.from(state.valuesMap);
    map[event.fieldName] = event.values;

    Map<String, bool> newValidationMap = Map.from(state.validationMap);
    newValidationMap[event.fieldName] = true;
    log(map.toString());
    emit(state.copyWith(valuesMap: map, validationMap: newValidationMap));
  }

  Future<void> _onDropDownValueChanged(
      DropDownValueChanged event, Emitter<FormsState> emit) async {
    var formModel = state.formModel!.copyWith();
    Map<String, bool> newValidationMap = Map.from(state.validationMap);
    Map<String, dynamic> map = Map.from(state.valuesMap);
    map[event.fieldName] = event.value;

    DropDownModel dropDown =
        formModel.getField(event.fieldName) as DropDownModel;

    List<DropDownModel> children =
        formModel.getRelatedDropDownsFor(dropDown.name);
    children.map((childDropDown) {
      childDropDown = childDropDown.copyWith(
          values: (state.assignedForms
                  .firstWhere((element) => formModel.id == element.id)
                  .getField(childDropDown.name) as DropDownModel)
              .values
              .where((item) => item.parent == event.value)
              .toList());

      add(DropDownValueChanged(fieldName: childDropDown.name, value: null));
      formModel.fields[formModel.fields
              .indexWhere((element) => element.name == childDropDown.name)] =
          childDropDown;
      map[childDropDown.name] = null;
    }).toList();

    newValidationMap[event.fieldName] = true;

    emit(state.copyWith(
        formModel: formModel, valuesMap: map, validationMap: newValidationMap));
  }

  Future<void> _onNewFormRequested(
      NewFormRequested event, Emitter<FormsState> emit) async {
    var formModel = event.formModel.copyWith();
    _initFields(formModel);

    //init values map with fields names with null values;
    Map<String, dynamic> map = {};
    formModel.fields.forEach((field) {
      map[field.name] = null;
    });

    log(map.toString());
    emit(state.copyWith(
        isNewSubmit: true,
        newSubmitFlowState: ContentState(),
        valuesMap: map,
        formModel: formModel,
        currentNode: () => null,
        validationMap: {},
        allSaved: false));

    log('_onNewFormRequested ************** emiting state  : ${map.toString()}');
  }

  void _initFields(FormModel formModel) {
    // init drop downs
    List<DropDownModel> childrenDropDowns = formModel.getChildrenDropDowns();
    childrenDropDowns.forEach((childDropDown) {
      childDropDown = childDropDown.copyWith(values: []);
      formModel.fields[formModel.fields
              .indexWhere((element) => element.name == childDropDown.name)] =
          childDropDown;
    });

    // emit(state.copyWith(valuesMap: map.cast()));
  }


  Future<void> _onFormSubmitted(
      FormSubmitted event, Emitter<FormsState> emit) async {
    try {
      //2022-09-14 08:58:22.229
      Map map = state.valuesMap;
      var newSub = Submission(
        formId: event.formModel.id,
        fieldEntries: _mapValuesToEntries(map),
        node: state.currentNode!,
        submittedAt: DateTime.now()
      );
      //
      // for(int i = 0  ; i < 20 ; i++){
      //   await _assignedFormRepository.addSubmission(newSub);
      //
      // }
      await _assignedFormRepository.addSubmission(newSub);

      log('sub to be added');

      emit(state.copyWith(
          newSubmitFlowState: SuccessState(AppStrings.formSubmittedSuccess),
          formHasSubmissions:
              _changeFormHasSubmissionMap(event.formModel.id, true),
          allSaved: false));
    } catch (e) {
      log(e.toString());
      final failure = ErrorTypeEnum.UNKNOWN.getFailure();
      emit(state.copyWith(
          newSubmitFlowState: ErrorState(code: 0,
              stateRendererType: StateRendererType.POPUP_ERROR,
              message: failure.message)));
    }
    // add(NewFormRequested(event.formModel));
  }

  Map<String, bool> _changeFormHasSubmissionMap(
      String formId, bool hasSubmissions) {
    final Map<String, bool> map = Map.from(state.formHasSubmissions);
    map[formId] = hasSubmissions;
    return map;
  }

  void _initFieldsUpdate(FormModel formModel, Map valuesMap) {
    // init drop downs
    List<DropDownModel> childrenDropDowns = formModel.getChildrenDropDowns();
    childrenDropDowns.forEach((childDropDown) {
      List<DropDownItemModel> values = childDropDown.values
          .where((item) =>
              item.parent == valuesMap[childDropDown.relatedListFieldName])
          .toList()
          .cast();
      childDropDown = childDropDown.copyWith(values: values);
      formModel.fields[formModel.fields
              .indexWhere((element) => element.name == childDropDown.name)] =
          childDropDown;
    });
  }

  Future<void> _onSubmissionUpdateRequested(
      SubmissionUpdateRequested event, Emitter<FormsState> emit) async {
    Map<String, dynamic> map = event.submission.entriesAsMap();
    var form = event.formModel.copyWith();
    _initFieldsUpdate(form, map);
    emit(state.copyWith(
        newSubmitFlowState: ContentState(),
        valuesMap: map,
        currentNode: () => event.submission.node,
        isNewSubmit: false,
        formModel: event.formModel));
  }

  Future<void> _onCheckboxGroupValueChanged(
      CheckboxGroupValueChanged event, Emitter<FormsState> emit) async {
    var formModel = state.formModel!.copyWith();

    Map<String, dynamic> map = Map.from(state.valuesMap);
    if (map[event.fieldName] == null) map[event.fieldName] = [];
    List groupValuesList = List.from(map[event.fieldName]);

    if (event.isChecked)
      groupValuesList.add(event.value);
    else
      groupValuesList.remove(event.value);

    map[event.fieldName] = groupValuesList;

    Map newValidationMap = Map.from(state.validationMap);
    newValidationMap[event.fieldName] = true;
    emit(state.copyWith(
        formModel: formModel,
        valuesMap: map,
        validationMap: newValidationMap.cast()));
  }

  Future<void> _onRadioGroupValueChanged(
      RadioGroupValueChanged event, Emitter<FormsState> emit) async {
    var formModel = state.formModel!.copyWith();

    Map<String, dynamic> map = Map.from(state.valuesMap);

    map[event.fieldName] = event.value;


    Map newValidationMap = Map.from(state.validationMap);
    newValidationMap[event.fieldName] = true;
    emit(state.copyWith(
        formModel: formModel,
        valuesMap: map,
        validationMap: newValidationMap.cast()));
  }

  Future<void> _onMatrixSubmitCanceled(
      MatrixSubmitCanceled event, Emitter<FormsState> emit) async {
    emit(state.copyWith(tempRecord: () => null));
  }

  Future<void> _onSubmissionUpdated(
      SubmissionUpdated event, Emitter<FormsState> emit) async {
    Map map = state.valuesMap;
    Submission submission = event.submission;
    int index = state.submissions.indexOf(event.submission);

    Submission newSub = submission.copyWith(
      updatedAt: DateTime.now(),
      fieldEntries: _mapValuesToEntries(map),
      node: state.currentNode!,
    );
    log(newSub.fieldEntries.toString());
    await _assignedFormRepository.updateSubmission(newSub);
    emit(state.copyWith(
        newSubmitFlowState: SuccessState(AppStrings.formUpdatedSuccess)));
    // add(SubmissionUpdateRequested(event.formModel, event.submission));
  }

  Future<void> _onFormSyncRequestCanceled(
      FormSyncRequestCanceled event, Emitter<FormsState> emit) async {
    _assignedFormRepository.cancelRequest(RequestType.SYNC_FORM);
  }

  double _getPercentage(int send, int total) {
    return 100 * (send / total);
  }


  void _onChunkUploadProgress(int send, int total) {
    //if submission upload size bigger than 5mb then we show a progress for it
    final percent = _getPercentage(send, total).toInt();
    emit(state.copyWith(
        syncFormProgress: state.syncFormProgress.copyWith(
            submissionSyncPercent: percent,
            requiresUploadProgress: total.toMb() > 2)));

  }

  void _onChunksTotalProgress(int send, int total) {
    final percent = _getPercentage(send, total).toInt();

    emit(state.copyWith(
      inactiveForms: _assignedFormRepository.getInactiveForms(),
        syncFormProgress: state.syncFormProgress
            .copyWith(submissionsChunksProgress: percent)));
  }

  Future<void> _onFormDataSyncRequested(
      FormDataSyncRequested event, Emitter<FormsState> emit) async {


    try {

      emit(state.copyWith(
          isFormSyncing: true,
          syncFormProgress: state.syncFormProgress.copyWith(
              submissionsChunksProgress: 0,
              submissionSyncPercent: 0,
              requiresUploadProgress: false)));
      final getSubs = _assignedFormRepository.getFormSubmissions(event.formId);
      await getSubs.fold((failure) async {}, (submissions) async {
        final request =
            FormSyncRequest(formId: event.formId, submissions: submissions);
        await _assignedFormRepository.syncForm(request,
            onChunksTotalProgress: _onChunksTotalProgress,
            onChunkUploadProgress: _onChunkUploadProgress, chunkSize: 2)
            .then((either) => either.fold((failure) {
              FlowState flowState = ErrorState(
                  code: failure.code,
                  stateRendererType: StateRendererType.POPUP_ERROR,
                  message: failure.message);

              if (failure.code == ResponseCode.CANCEL) {
                flowState = WarningState(AppStrings.syncStoppedMsg);
              }

              emit(state.copyWith(isFormSyncing: false, flowState: flowState,inactiveForms: _assignedFormRepository.getInactiveForms()  ));
            }, (success) {
              emit(state.copyWith(
                  isFormSyncing: false,
                  inactiveForms: _assignedFormRepository.getInactiveForms(),
                  formHasSubmissions: _changeFormHasSubmissionMap(event.formId, false),
                  flowState: SuccessState(AppStrings.syncSuccessMsg)));
            }));
      });
    } catch (e) {
      emit(state.copyWith(
          isFormSyncing: false,
          flowState: ErrorState(
              stateRendererType: StateRendererType.POPUP_ERROR,
              message: e.toString())));
    }
  }

  FieldType _getFieldTypeFromName(String fieldName) {
    FormFieldModel? field = state.formModel!.fields
        .firstWhereOrNull((element) => element.name == fieldName);

    return field != null ? field.type : FieldType.UNKNOWN;
  }

  bool _isFieldVisible(FormFieldModel model) {
    if (model.showIfLogicCheckbox == false) return true;

    if (state.valuesMap[model.showIfFieldName] == model.showIfFieldValue)
      return true;

    return false;
  }

  List<FieldEntry> _mapValuesToEntries(Map valuesMap) {
    List<FieldEntry> entries = [];
    for (var entry in valuesMap.entries) {
      if (!_isFieldVisible(_getField(state.formModel!, entry.key))) {
        entries.add(FieldEntry(
            name: entry.key,
            value: null,
            type: _getFieldTypeFromName(entry.key)));
      } else
        entries.add(FieldEntry(
            name: entry.key,
            value: entry.value,
            type: _getFieldTypeFromName(entry.key)));
    }

    return entries;
  }

  FormFieldModel _getField(FormModel formModel, String fieldName) {
    return formModel.fields.firstWhere((element) => element.name == fieldName);
  }



  @override
  Future<void> close() {
    log('forms bloc closed');
    return super.close();
  }
}
