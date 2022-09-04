// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matrix_dropdown_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MatrixDropDownModelAdapter extends TypeAdapter<MatrixDropDownModel> {
  @override
  final int typeId = 27;

  @override
  MatrixDropDownModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MatrixDropDownModel(
      values: (fields[4] as List).cast<MultipleOptionsModel>(),
      fieldName: fields[1] as String,
      label: fields[2] as String,
      type: fields[3] as FieldType,
    );
  }

  @override
  void write(BinaryWriter writer, MatrixDropDownModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(4)
      ..write(obj.values)
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
      other is MatrixDropDownModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
