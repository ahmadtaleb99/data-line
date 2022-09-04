// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matrix_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MatrixModelAdapter extends TypeAdapter<MatrixModel> {
  @override
  final int typeId = 22;

  @override
  MatrixModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MatrixModel(
      maxRecordsCount: fields[13] as int,
      values: (fields[14] as List).cast<MatrixFieldModel>(),
      name: fields[1] as String,
      label: fields[2] as String,
      type: fields[3] as FieldType,
      deactivate: fields[4] as bool,
      required: fields[5] as bool,
      isHidden: fields[6] as bool,
      isReadOnly: fields[7] as bool,
      showIfLogicCheckbox: fields[8] as bool,
      showIfIsRequired: fields[9] as bool,
      showIfFieldName: fields[11] as String,
      showIfFieldValue: fields[12] as String,
      requiredIfLogicCheckbox: fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MatrixModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(13)
      ..write(obj.maxRecordsCount)
      ..writeByte(14)
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
      other is MatrixModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MatrixFieldModelAdapter extends TypeAdapter<MatrixFieldModel> {
  @override
  final int typeId = 21;

  @override
  MatrixFieldModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MatrixFieldModel(
      fieldName: fields[1] as String,
      label: fields[2] as String,
      type: fields[3] as FieldType,
    );
  }

  @override
  void write(BinaryWriter writer, MatrixFieldModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.fieldName)
      ..writeByte(2)
      ..write(obj.label)
      ..writeByte(3)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatrixFieldModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MultipleOptionsModelAdapter extends TypeAdapter<MultipleOptionsModel> {
  @override
  final int typeId = 23;

  @override
  MultipleOptionsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MultipleOptionsModel(
      label: fields[1] as String,
      value: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MultipleOptionsModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.label)
      ..writeByte(2)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MultipleOptionsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
