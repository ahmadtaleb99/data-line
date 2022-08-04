extension NotNullString on String?{
  String orEmpty () => this == null ? '' : this!;
}

extension NotEmptyInt on int?{
  int orZero () => this == null ? 0 : this!;
}

