// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'star_rating_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StarRatingModelAdapter extends TypeAdapter<StarRatingModel> {
  @override
  final int typeId = 10;

  @override
  StarRatingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StarRatingModel(
      name: fields[1] as String,
      label: fields[2] as String,
      type: fields[3] as FieldType,
      deactivate: fields[4] as bool,
      required: fields[5] as bool,
      isHidden: fields[6] as bool,
      isReadOnly: fields[7] as bool,
      showIfLogicCheckbox: fields[8] as bool,
      showIfIsRequired: fields[9] as bool,
      requiredIfLogicCheckbox: fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, StarRatingModel obj) {
    writer
      ..writeByte(10)
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
      ..write(obj.requiredIfLogicCheckbox);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StarRatingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
