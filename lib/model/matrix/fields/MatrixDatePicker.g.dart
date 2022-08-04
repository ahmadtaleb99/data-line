// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MatrixDatePicker.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MatrixDatePickerAdapter extends TypeAdapter<MatrixDatePicker> {
  @override
  final int typeId = 64;

  @override
  MatrixDatePicker read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MatrixDatePicker(
      name: fields[1] as String,
      label: fields[2] as String,
      value: fields[3] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, MatrixDatePicker obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.label)
      ..writeByte(3)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatrixDatePickerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
