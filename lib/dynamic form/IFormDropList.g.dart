// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'IFormDropList.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IFormDropListAdapter extends TypeAdapter<IFormDropList> {
  @override
  final int typeId = 24;

  @override
  IFormDropList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IFormDropList(
      values: (fields[1] as List).cast<DropDownItem>(),
      label: fields[2] as String,
      parentName: fields[11] as String?,
      name: fields[3] as String,
      deactivate: fields[5] as bool,
      isHidden: fields[6] as bool,
      prompt: fields[4] as String,
      multiple: fields[7] as bool,
      required: fields[8] as bool,
      isReadOnly: fields[9] as bool,
      relatedToParent: fields[10] as bool,
      visible: fields[12] as bool?,
      showIfValueSelected: fields[13] as bool,
      showIfFieldValue: fields[14] as String?,
      showIfIsRequired: fields[15] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, IFormDropList obj) {
    writer
      ..writeByte(15)
      ..writeByte(1)
      ..write(obj.values)
      ..writeByte(2)
      ..write(obj.label)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.prompt)
      ..writeByte(5)
      ..write(obj.deactivate)
      ..writeByte(6)
      ..write(obj.isHidden)
      ..writeByte(7)
      ..write(obj.multiple)
      ..writeByte(8)
      ..write(obj.required)
      ..writeByte(9)
      ..write(obj.isReadOnly)
      ..writeByte(10)
      ..write(obj.relatedToParent)
      ..writeByte(11)
      ..write(obj.parentName)
      ..writeByte(12)
      ..write(obj.visible)
      ..writeByte(13)
      ..write(obj.showIfValueSelected)
      ..writeByte(14)
      ..write(obj.showIfFieldValue)
      ..writeByte(15)
      ..write(obj.showIfIsRequired);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IFormDropListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
