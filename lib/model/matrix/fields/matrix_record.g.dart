// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matrix_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MatrixRecordModelAdapter extends TypeAdapter<MatrixRecordModel> {
  @override
  final int typeId = 67;

  @override
  MatrixRecordModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MatrixRecordModel(
      fields: (fields[1] as List).cast<IFormModel>(),
      value: fields[2] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, MatrixRecordModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.fields)
      ..writeByte(2)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatrixRecordModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
