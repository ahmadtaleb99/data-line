// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CheckboxItem.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CheckboxItemAdapter extends TypeAdapter<CheckboxItem> {
  @override
  final int typeId = 40;

  @override
  CheckboxItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CheckboxItem(
      label: fields[1] as String,
      groupName: fields[2] as String,
      value: fields[3] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, CheckboxItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.label)
      ..writeByte(2)
      ..write(obj.groupName)
      ..writeByte(3)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckboxItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
