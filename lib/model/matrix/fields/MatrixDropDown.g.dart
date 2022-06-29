// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MatrixDropDown.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MatrixDropDownAdapter extends TypeAdapter<MatrixDropDown> {
  @override
  final int typeId = 63;

  @override
  MatrixDropDown read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MatrixDropDown(
      name: fields[1] as String,
      label: fields[2] as String,
      values: (fields[3] as List).cast<DropDownItem>(),
    )..value = fields[4] as dynamic;
  }

  @override
  void write(BinaryWriter writer, MatrixDropDown obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.label)
      ..writeByte(3)
      ..write(obj.values)
      ..writeByte(4)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatrixDropDownAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
