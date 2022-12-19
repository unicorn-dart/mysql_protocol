class Packet {
  const Packet();
}

class Field {
  const Field();
}

class Serialized {
  const Serialized({
    required String name,
  });
}

class DataModel {
  const DataModel();
}

class SerializedField {
  const SerializedField({
    required String name,
  });
}

class Capabilities {
  const Capabilities(String condition);
}

class Reference {
  const Reference({
    required ReferenceKind kind,
  });
}

class ReferenceKind {
  const ReferenceKind._internal(String name);

  static const kDataType = ReferenceKind._internal("DATA_TYPE");

  static const kEnumeration = ReferenceKind._internal("ENUMERATION");

  static const kEnumerationItem = ReferenceKind._internal("ENUMERATION_ITEM");

  static const kEnumerationPrimaryKey =
      ReferenceKind._internal("ENUMERATION_PRIMARY_KEY");

  static const kBitMask = ReferenceKind._internal("BIT_MASK");

  static const kBitMaskItem = ReferenceKind._internal("BIT_MASK");
}
