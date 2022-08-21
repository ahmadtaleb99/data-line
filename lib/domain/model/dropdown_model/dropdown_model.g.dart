// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dropdown_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DropDownModelAdapter extends TypeAdapter<DropDownModel> {
  @override
  final int typeId = 4;

  @override
  DropDownModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DropDownModel(
      prompt: fields[13] as String,
      relatedListCheckbox: fields[14] as bool,
      relatedListFieldName: fields[15] as String,
      multiple: fields[16] as bool,
      values: (fields[17] as List).cast<DropDownItemModel>(),
      name: fields[1] as String,
      label: fields[2] as String,
      type: fields[3] as FieldType,
      deactivate: fields[4] as bool,
      required: fields[5] as bool,
      isHidden: fields[6] as bool,
      isReadOnly: fields[7] as bool,
      showIfLogicCheckbox: fields[8] as bool,
      showIfFieldName: fields[11] as String,
      showIfFieldValue: fields[12] as String,
      showIfIsRequired: fields[9] as bool,
      requiredIfLogicCheckbox: fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, DropDownModel obj) {
    writer
      ..writeByte(17)
      ..writeByte(13)
      ..write(obj.prompt)
      ..writeByte(14)
      ..write(obj.relatedListCheckbox)
      ..writeByte(15)
      ..write(obj.relatedListFieldName)
      ..writeByte(16)
      ..write(obj.multiple)
      ..writeByte(17)
      ..write(obj.values)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.label)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.deactivate)
      ..writeByte(5)
      ..write(obj.required)
      ..writeByte(6)
      ..write(obj.isHidden)
      ..writeByte(7)
      ..write(obj.isReadOnly)
      ..writeByte(8)
      ..write(obj.showIfLogicCheckbox)
      ..writeByte(9)
      ..write(obj.showIfIsRequired)
      ..writeByte(10)
      ..write(obj.requiredIfLogicCheckbox)
      ..writeByte(11)
      ..write(obj.showIfFieldName)
      ..writeByte(12)
      ..write(obj.showIfFieldValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DropDownModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
