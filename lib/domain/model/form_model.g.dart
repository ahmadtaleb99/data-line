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
    throw UnimplementedError();
  }

  @override
  void write(BinaryWriter writer, FormFieldModel obj) {
    writer
      ..writeByte(10)
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
      ..write(obj.requiredIfLogicCheckbox);
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
      formName: fields[1] as String,
      fieldEntries: (fields[2] as List).cast<FieldEntry>(),
    );
  }

  @override
  void write(BinaryWriter writer, Submission obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.formName)
      ..writeByte(2)
      ..write(obj.fieldEntries);
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
    return FieldEntry(
      name: fields[1] as String,
      value: fields[2] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, FieldEntry obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.value);
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

class FieldTypeAdapter extends TypeAdapter<FieldType> {
  @override
  final int typeId = 16;

  @override
  FieldType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 1:
        return FieldType.TEXT;
      case 2:
        return FieldType.TEXT_AREA;
      case 3:
        return FieldType.NUMBER;
      case 4:
        return FieldType.EMAIL;
      case 5:
        return FieldType.DROPDOWN;
      case 6:
        return FieldType.STAR_RATING;
      case 7:
        return FieldType.CHECKBOX_GROUP;
      case 8:
        return FieldType.CHECKBOX;
      case 9:
        return FieldType.RADIO_GROUP;
      case 10:
        return FieldType.FILE;
      default:
        return FieldType.TEXT;
    }
  }

  @override
  void write(BinaryWriter writer, FieldType obj) {
    switch (obj) {
      case FieldType.TEXT:
        writer.writeByte(1);
        break;
      case FieldType.TEXT_AREA:
        writer.writeByte(2);
        break;
      case FieldType.NUMBER:
        writer.writeByte(3);
        break;
      case FieldType.EMAIL:
        writer.writeByte(4);
        break;
      case FieldType.DROPDOWN:
        writer.writeByte(5);
        break;
      case FieldType.STAR_RATING:
        writer.writeByte(6);
        break;
      case FieldType.CHECKBOX_GROUP:
        writer.writeByte(7);
        break;
      case FieldType.CHECKBOX:
        writer.writeByte(8);
        break;
      case FieldType.RADIO_GROUP:
        writer.writeByte(9);
        break;
      case FieldType.FILE:
        writer.writeByte(10);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FieldTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
