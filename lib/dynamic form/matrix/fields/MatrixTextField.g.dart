// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MatrixTextField.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MatrixTextFieldAdapter extends TypeAdapter<MatrixTextField> {
  @override
  final int typeId = 60;

  @override
  MatrixTextField read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MatrixTextField(
      name: fields[1] as String,
      label: fields[2] as String,
    )..value = fields[3] as dynamic;
  }

  @override
  void write(BinaryWriter writer, MatrixTextField obj) {
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
      other is MatrixTextFieldAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
