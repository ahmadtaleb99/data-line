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

class OperatorAdapter extends TypeAdapter<Operator> {
  @override
  final int typeId = 62;

  @override
  Operator read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 1:
        return Operator.MORE;
      case 2:
        return Operator.LESS;
      case 3:
        return Operator.EQUAL;
      case 4:
        return Operator.BETWEEN;
      default:
        return Operator.MORE;
    }
  }

  @override
  void write(BinaryWriter writer, Operator obj) {
    switch (obj) {
      case Operator.MORE:
        writer.writeByte(1);
        break;
      case Operator.LESS:
        writer.writeByte(2);
        break;
      case Operator.EQUAL:
        writer.writeByte(3);
        break;
      case Operator.BETWEEN:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OperatorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
