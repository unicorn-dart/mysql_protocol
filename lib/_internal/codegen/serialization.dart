import 'package:version/version.dart';

class DataType {
  const DataType();

  const DataType.fixedLengthInteger(int bytesTaken);

  const DataType.lengthEncodedInteger();

  const DataType.fixedLengthString(int bytesTaken);

  const DataType.nullTerminatedString();

  const DataType.variableLengthString(int bytesTaken);

  const DataType.lengthEncodedString();

  const DataType.restOfPacketString();

  const DataType.fromType(Type type);
}

abstract class SerializationStepResolutionContext {
  Iterable<String> get capabilities;

  Map<String, dynamic> get fields;

  T getEnvironment<T>();

  SerializationStep readAsField({
    required String name,
    required DataType dataType,
  });
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
    required DataType dataType,
  });
}

abstract class SerializationStepResolutionDelegate {
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  );
}

abstract class SerializedFieldContext {}
