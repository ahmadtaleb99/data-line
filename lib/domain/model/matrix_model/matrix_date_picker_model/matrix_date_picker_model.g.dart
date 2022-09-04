// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matrix_date_picker_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MatrixDatePickerModelAdapter extends TypeAdapter<MatrixDatePickerModel> {
  @override
  final int typeId = 26;

  @override
  MatrixDatePickerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MatrixDatePickerModel(
      fieldName: fields[1] as String,
      label: fields[2] as String,
      type: fields[3] as FieldType,
    );
  }

  @override
  void write(BinaryWriter writer, MatrixDatePickerModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.fieldName)
      ..writeByte(2)
      ..write(obj.label)
      ..writeByte(3)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatrixDatePickerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
