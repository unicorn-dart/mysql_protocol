class Packet {
  const Packet();
}

class Serialized {
  const Serialized({
    required String name,
  });
}

class DataModel {
  const DataModel();
}

class Field {
  const Field();
}

class SerializedField {
  const SerializedField({
    required String name,
  });
}

class DataType {
  const DataType();

  const DataType.fixedLengthInteger(int bytesTaken);

  const DataType.lengthEncodedInteger();

  const DataType.fixedLengthString(int bytesTaken);

  const DataType.nullTerminatedString();

  const DataType.variableLengthString(int bytesTaken);

  const DataType.lengthEncodedString();

  const DataType.restOfPacketString();
}

abstract class SerializationStepAnswerContext {
  Iterable<String> get capabilities;

  Map<String, dynamic> get fields;

  SerializationStep answerStep({
    required String name,
    required DataType dataType,
  });
}

class SerializationStep {
  const SerializationStep({
    required String name,
    required DataType dataType,
  });
}

abstract class SerializationStepResolutionDelegate {
  Iterable<SerializationStep> answerSerializationStep(
    SerializationStepAnswerContext context,
  );
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
  const ReferenceKind(String name);

  static const kDataModel = ReferenceKind("data_model");

  static const kEnumeration = ReferenceKind("enumeration");

  static const kEnumerationKey = ReferenceKind("enumeration_key");
}
