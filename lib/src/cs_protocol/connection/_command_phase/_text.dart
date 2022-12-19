part of '../lib.dart';

/// For more details, visit [Text Protocol][text_protocol].
///
/// [text_protocol]: https://dev.mysql.com/doc/dev/mysql-server/latest/page_protocol_command_phase_text.html
///

@Packet()
@Serialized(name: "COM_QUERY")
abstract class QueryCommand implements SerializationStepResolutionDelegate {
  @Field()
  @SerializedField(name: 'command')
  int get command;

  @Field()
  @SerializedField(name: 'parameter_count')
  int get parameterCount;

  /// Currently always 0x01
  @Field()
  @SerializedField(name: 'parameter_set_count')
  int get parameterSetCount;

  @Field()
  @SerializedField(name: 'null_bitmap')
  Uint8List get nullBitmap;

  /// Always 1. Malformed packet error if not 1
  @Field()
  @SerializedField(name: 'new_params_bind_flag')
  int get newParamsBindFlag;

  @Field()
  @SerializedField(name: 'param_type_and_flag')
  List<int> get paramTypeAndFlag;

  @Field()
  @SerializedField(name: 'parameter_name')
  List<String> get parameterName;

  @Field()
  @SerializedField(name: 'parameter_values')
  List<String> get parameterValues;

  @Field()
  @SerializedField(name: 'query')
  String get query;

  @override
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    yield context.readAsScalar(
      name: 'command',
      reader: Scalar.fixedLengthInteger(1),
    );
    if (context.capabilities.hasSupported('CLIENT_QUERY_ATTRIBUTES')) {
      yield context.readAsScalar(
        name: 'parameter_count',
        reader: Scalar.lengthEncodedInteger(),
      );
      yield context.readAsScalar(
        name: 'parameter_set_count',
        reader: Scalar.lengthEncodedInteger(),
      );
      if (context.fields['parameter_count'] > 0) {
        yield context.readAsScalar(
          name: 'null_bitmap',
          reader: Scalar.variableLengthString(
              (context.fields['parameter_count'] + 7) / 8),
        );
        yield context.readAsScalar(
          name: 'new_params_bind_flag',
          reader: Scalar.fixedLengthInteger(1),
        );
        if (context.fields['new_params_bind_flag']) {
          for (var i = 0; i < context.fields['parameter_count']; i++) {
            if (context.fields['new_params_bind_flag']) {
              yield context.readAsScalar(
                name: 'param_type_and_flag[]',
                reader: Scalar.fixedLengthInteger(2),
              );
              yield context.readAsScalar(
                name: 'parameter_name[]',
                reader: Scalar.lengthEncodedString(),
              );
            }
          }
        }
        for (var i = 0; i < context.fields['parameter_count']; i++) {
          yield context.readAsScalar(
            name: 'parameter_values',
            reader: Scalar.lengthEncodedString(),
          );
        }
      }
    }
    yield context.readAsScalar(
      name: 'query',
      reader: Scalar.restOfPacketString(),
    );
  }
}
