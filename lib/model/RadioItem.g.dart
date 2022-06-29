// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RadioItem.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RadioItemAdapter extends TypeAdapter<RadioItem> {
  @override
  final int typeId = 56;

  @override
  RadioItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RadioItem(
      label: fields[1] as String,
      parent: fields[2] as String,
      value: fields[3] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, RadioItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.label)
      ..writeByte(2)
      ..write(obj.parent)
      ..writeByte(3)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RadioItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
