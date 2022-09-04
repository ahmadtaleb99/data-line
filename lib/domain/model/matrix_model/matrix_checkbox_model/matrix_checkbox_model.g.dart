// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matrix_checkbox_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MatrixCheckboxModelAdapter extends TypeAdapter<MatrixCheckboxModel> {
  @override
  final int typeId = 25;

  @override
  MatrixCheckboxModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MatrixCheckboxModel(
      fieldName: fields[1] as String,
      label: fields[2] as String,
      type: fields[3] as FieldType,
    );
  }

  @override
  void write(BinaryWriter writer, MatrixCheckboxModel obj) {
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
      other is MatrixCheckboxModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
