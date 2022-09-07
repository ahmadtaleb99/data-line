// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matrix_record_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MatrixRecordModelAdapter extends TypeAdapter<MatrixRecordModel> {
  @override
  final int typeId = 31;

  @override
  MatrixRecordModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MatrixRecordModel(
      valuesMap: (fields[1] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, MatrixRecordModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.valuesMap);
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
