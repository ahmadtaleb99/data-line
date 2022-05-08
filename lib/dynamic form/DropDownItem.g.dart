// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DropDownItem.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DropDownItemAdapter extends TypeAdapter<DropDownItem> {
  @override
  final int typeId = 41;

  @override
  DropDownItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DropDownItem(
      parent: fields[1] as String?,
      value: fields[2] as dynamic,
      status: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DropDownItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.parent)
      ..writeByte(2)
      ..write(obj.value)
      ..writeByte(3)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DropDownItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
