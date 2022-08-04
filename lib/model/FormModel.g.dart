// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FormModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OldFormModelAdapter extends TypeAdapter<OldFormModel> {
  @override
  final int typeId = 35;

  @override
  OldFormModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OldFormModel(
      value: fields[4] as dynamic,
      name: fields[1] as String,
      directionality: fields[2] as String,
      fields: (fields[3] as List).cast<IFormModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, OldFormModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.directionality)
      ..writeByte(3)
      ..write(obj.fields)
      ..writeByte(4)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OldFormModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
