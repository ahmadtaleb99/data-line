// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matrix_radio_group_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MatrixRadioGroupModelAdapter extends TypeAdapter<MatrixRadioGroupModel> {
  @override
  final int typeId = 29;

  @override
  MatrixRadioGroupModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MatrixRadioGroupModel(
      values: (fields[4] as List).cast<MultipleOptionsModel>(),
      fieldName: fields[1] as String,
      label: fields[2] as String,
      type: fields[3] as FieldType,
    );
  }

  @override
  void write(BinaryWriter writer, MatrixRadioGroupModel obj) {
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
      other is MatrixRadioGroupModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
