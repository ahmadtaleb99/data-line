// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matrix_text_field_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MatrixTextFieldModelAdapter extends TypeAdapter<MatrixTextFieldModel> {
  @override
  final int typeId = 30;

  @override
  MatrixTextFieldModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MatrixTextFieldModel(
      fieldName: fields[1] as String,
      label: fields[2] as String,
      type: fields[3] as FieldType,
    );
  }

  @override
  void write(BinaryWriter writer, MatrixTextFieldModel obj) {
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
      other is MatrixTextFieldModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
