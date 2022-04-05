// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'IFormCheckBoxGroup.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IFormCheckBoxGroupAdapter extends TypeAdapter<IFormCheckBoxGroup> {
  @override
  final int typeId = 42;

  @override
  IFormCheckBoxGroup read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IFormCheckBoxGroup(
      label: fields[1] as String,
      name: fields[2] as String,
      deactivate: fields[3] as bool,
      isHidden: fields[4] as bool,
      required: fields[5] as bool,
      children: (fields[15] as List).cast<CheckboxItem>(),
      isReadOnly: fields[6] as bool,
      visible: fields[7] as bool?,
      showIfValueSelected: fields[8] as bool,
      showIfFieldValue: fields[9] as String?,
      showIfIsRequired: fields[13] as bool?,
      minMaxCheckbox: fields[10] as bool,
      minCheckedAllowed: fields[11] as int?,
      maxCheckedAllowed: fields[12] as int?,
      other: fields[14] as bool,
    )..value = fields[16] as dynamic;
  }

  @override
  void write(BinaryWriter writer, IFormCheckBoxGroup obj) {
    writer
      ..writeByte(16)
      ..writeByte(1)
      ..write(obj.label)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.deactivate)
      ..writeByte(4)
      ..write(obj.isHidden)
      ..writeByte(5)
      ..write(obj.required)
      ..writeByte(6)
      ..write(obj.isReadOnly)
      ..writeByte(7)
      ..write(obj.visible)
      ..writeByte(8)
      ..write(obj.showIfValueSelected)
      ..writeByte(9)
      ..write(obj.showIfFieldValue)
      ..writeByte(10)
      ..write(obj.minMaxCheckbox)
      ..writeByte(11)
      ..write(obj.minCheckedAllowed)
      ..writeByte(12)
      ..write(obj.maxCheckedAllowed)
      ..writeByte(13)
      ..write(obj.showIfIsRequired)
      ..writeByte(14)
      ..write(obj.other)
      ..writeByte(15)
      ..write(obj.children)
      ..writeByte(16)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IFormCheckBoxGroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
