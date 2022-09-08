// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'IFormModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IFormModelAdapter extends TypeAdapter<IFormModel> {
  @override
  final int typeId = 47;

  @override
  IFormModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IFormModel();
  }

  @override
  void write(BinaryWriter writer, IFormModel obj) {
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IFormModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
