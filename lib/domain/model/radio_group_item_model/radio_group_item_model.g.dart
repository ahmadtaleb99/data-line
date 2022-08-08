// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'radio_group_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RadioGroupItemModelAdapter extends TypeAdapter<RadioGroupItemModel> {
  @override
  final int typeId = 8;

  @override
  RadioGroupItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RadioGroupItemModel(
      label: fields[1] as String,
      value: fields[2] as String,
      parent: fields[3] as String,
      status: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RadioGroupItemModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.label)
      ..writeByte(2)
      ..write(obj.value)
      ..writeByte(3)
      ..write(obj.parent)
      ..writeByte(4)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RadioGroupItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
