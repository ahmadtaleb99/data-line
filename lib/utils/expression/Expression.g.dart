// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Expression.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpressionAdapter extends TypeAdapter<Expression> {
  @override
  final int typeId = 61;

  @override
  Expression read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Expression(
      operator: fields[1] as Operator,
      value: fields[2] as int,
      value2: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Expression obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.operator)
      ..writeByte(2)
      ..write(obj.value)
      ..writeByte(3)
      ..write(obj.value2);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpressionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
