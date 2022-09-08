// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AssignedFormsAdapter extends TypeAdapter<AssignedForms> {
  @override
  final int typeId = 15;

  @override
  AssignedForms read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AssignedForms(
      (fields[1] as List?)?.cast<FormModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, AssignedForms obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssignedFormsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FormModelAdapter extends TypeAdapter<FormModel> {
  @override
  final int typeId = 14;

  @override
  FormModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FormModel(
      name: fields[1] as String,
      directionality: fields[2] as String,
      fields: (fields[3] as List).cast<FormFieldModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, FormModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.directionality)
      ..writeByte(3)
      ..write(obj.fields);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FormFieldModelAdapter extends TypeAdapter<FormFieldModel> {
  @override
  final int typeId = 13;

  @override
  FormFieldModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FormFieldModel(
      name: fields[1] as String,
      label: fields[2] as String,
      type: fields[3] as FieldType,
      deactivate: fields[4] as bool,
      required: fields[5] as bool,
      isHidden: fields[6] as bool,
      isReadOnly: fields[7] as bool,
      showIfLogicCheckbox: fields[8] as bool,
      showIfIsRequired: fields[9] as bool,
      showIfFieldName: fields[11] as String,
      showIfFieldValue: fields[12] as String,
      requiredIfLogicCheckbox: fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, FormFieldModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.label)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.deactivate)
      ..writeByte(5)
      ..write(obj.required)
      ..writeByte(6)
      ..write(obj.isHidden)
      ..writeByte(7)
      ..write(obj.isReadOnly)
      ..writeByte(8)
      ..write(obj.showIfLogicCheckbox)
      ..writeByte(9)
      ..write(obj.showIfIsRequired)
      ..writeByte(10)
      ..write(obj.requiredIfLogicCheckbox)
      ..writeByte(11)
      ..write(obj.showIfFieldName)
      ..writeByte(12)
      ..write(obj.showIfFieldValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormFieldModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SubmissionAdapter extends TypeAdapter<Submission> {
  @override
  final int typeId = 17;

  @override
  Submission read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Submission(
      id: fields[3] as int?,
      formName: fields[1] as String,
      fieldEntries: (fields[2] as List).cast<FieldEntry>(),
    );
  }

  @override
  void write(BinaryWriter writer, Submission obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.formName)
      ..writeByte(2)
      ..write(obj.fieldEntries)
      ..writeByte(3)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubmissionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FieldEntryAdapter extends TypeAdapter<FieldEntry> {
  @override
  final int typeId = 18;

  @override
  FieldEntry read(BinaryReader reader) {

    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };


    // List<MatrixRecordModel>? records;
    // if(fields[3] == FieldType.MATRIX)
    //     {
    //       if (fields[2] != null ){
    //         records = List<MatrixRecordModel>.from(fields[2]);
    //       }
    //     }


    return FieldEntry(
      name: fields[1] as String,
      value: fields[2],
      type: fields[3] as FieldType,
    );
  }

  @override
  void write(BinaryWriter writer, FieldEntry obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.value)
      ..writeByte(3)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FieldEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
