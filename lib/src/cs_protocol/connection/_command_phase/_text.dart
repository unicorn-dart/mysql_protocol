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
    yield context.readAsField(
      name: 'command',
      dataType: DataType.fixedLengthInteger(1),
    );
    if (context.capabilities.contains('CLIENT_QUERY_ATTRIBUTES')) {
      yield context.readAsField(
        name: 'parameter_count',
        dataType: DataType.lengthEncodedInteger(),
      );
      yield context.readAsField(
        name: 'parameter_set_count',
        dataType: DataType.lengthEncodedInteger(),
      );
      if (context.fields['parameter_count'] > 0) {
        yield context.readAsField(
          name: 'null_bitmap',
          dataType: DataType.variableLengthString(
              (context.fields['parameter_count'] + 7) / 8),
        );
        yield context.readAsField(
          name: 'new_params_bind_flag',
          dataType: DataType.fixedLengthInteger(1),
        );
        if (context.fields['new_params_bind_flag']) {
          for (var i = 0; i < context.fields['parameter_count']; i++) {
            if (context.fields['new_params_bind_flag']) {
              yield context.readAsField(
                name: 'param_type_and_flag[]',
                dataType: DataType.fixedLengthInteger(2),
              );
              yield context.readAsField(
                name: 'parameter_name[]',
                dataType: DataType.lengthEncodedString(),
              );
            }
          }
        }
        for (var i = 0; i < context.fields['parameter_count']; i++) {
          yield context.readAsField(
            name: 'parameter_values',
            dataType: DataType.lengthEncodedString(),
          );
        }
      }
    }
    yield context.readAsField(
      name: 'query',
      dataType: DataType.restOfPacketString(),
    );
  }
}
