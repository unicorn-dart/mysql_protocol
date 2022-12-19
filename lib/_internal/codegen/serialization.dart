import 'dart:typed_data';

import 'package:version/version.dart';

abstract class BinaryReader {}

abstract class DataType {}

abstract class ObjectReader implements BinaryReader {}

class ReferencedObject implements DataType, ObjectReader {
  factory ReferencedObject.from(Type type) => throw UnimplementedError();
}

abstract class ScalarReader implements BinaryReader {}

class Scalar implements DataType, ScalarReader {
  factory Scalar.fixedLengthInteger(int bytesTaken, {bool unsigned = true}) =>
      throw UnimplementedError();

  factory Scalar.lengthEncodedInteger() => throw UnimplementedError();

  factory Scalar.fixedLengthString(int bytesTaken) =>
      throw UnimplementedError();

  factory Scalar.nullTerminatedString() => throw UnimplementedError();

  factory Scalar.variableLengthString(int bytesTaken) =>
      throw UnimplementedError();

  factory Scalar.lengthEncodedString() => throw UnimplementedError();

  factory Scalar.restOfPacketString() => throw UnimplementedError();

  factory Scalar.fixedLengthBytes() => throw UnimplementedError();

  factory Scalar.lengthEncodedBytes(int bytesTaken) =>
      throw UnimplementedError();

  factory Scalar.restOfPacketBytes() => throw UnimplementedError();
}

typedef SerializationStepResolverFunc = Iterable<SerializationStep> Function(
  SerializationStepResolutionContext context,
);

abstract class SerializationStepResolutionContext {
  Map<String, dynamic> get fields;

  T environmentOf<T>();

  SerializationStep readAsScalar({
    required String name,
    required ScalarReader reader,
    DataType? dataType,
  });

  SerializationStep readAsObject({
    required String name,
    required ObjectReader reader,
    DataType? dataType,
  });

  SerializationStep readAsMapEntry({
    required String name,
    required BinaryReader keyReader,
    DataType? keyType,
    required BinaryReader valueReader,
    DataType? valueType,
  });

  SerializationStep readAsArrayElement({
    required String name,
    required BinaryReader reader,
    DataType? dataType,
  });

  Uint8List peek(int bytesTaken);
}

extension SerializationStepResolutionCapabilitiesExtensions
    on SerializationStepResolutionContext {
  CapabilitiesEnvironment get capabilities => throw UnimplementedError();

  MySqlServerEnvironment get mysqlServer => throw UnimplementedError();

  BinlogEnvironment get binlog => throw UnimplementedError();
}

extension SerializationStepResolutionPeekingExtensions
    on SerializationStepResolutionContext {
  int peekAsInteger({
    required Scalar dataType,
  }) {
    throw UnimplementedError();
  }

  String peekAsString({
    required Scalar dataType,
  }) {
    throw UnimplementedError();
  }
}

abstract class CapabilitiesEnvironment implements List<String> {
  bool hasSupported(String name);
}

abstract class MySqlServerEnvironment {
  Version get version;
}

abstract class BinlogEnvironment {
  Version get binlogVersion;
}

class SerializationStep {
  const SerializationStep({
    required String name,
    required Scalar dataType,
  });
}

abstract class SerializationStepResolutionDelegate {
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  );
}

abstract class SerializedFieldContext {}
