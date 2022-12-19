part of '../lib.dart';

/// For more details, visit [Command Phase](command_phase)
///
/// [command_phase]: https://dev.mysql.com/doc/dev/mysql-server/latest/page_protocol_command_phase.html
///

// TODO(coocoa): Have unfinished works.

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
  String get nullBitmap;

  @Field()
  @SerializedField(name: 'new_params_bind_flag')
  int get newParamsBindFlag;

  @Field()
  @SerializedField(name: 'query')
  String get query;

  @override
  Iterable<SerializationStep> answerSerializationStep(
    SerializationStepAnswerContext context,
  ) sync* {
    yield context.answerStep(
      name: 'command',
      dataType: DataType.fixedLengthInteger(1),
    );
    if (context.capabilities.contains('CLIENT_QUERY_ATTRIBUTES')) {
      yield context.answerStep(
        name: 'parameter_count',
        dataType: DataType.lengthEncodedInteger(),
      );
      yield context.answerStep(
        name: 'parameter_set_count',
        dataType: DataType.lengthEncodedInteger(),
      );
      if (context.fields['parameter_count'] > 0) {
        yield context.answerStep(
          name: 'null_bitmap',
          dataType: DataType.variableLengthString(
              (context.fields['parameter_count'] + 7) / 8),
        );
        yield context.answerStep(
          name: 'new_params_bind_flag',
          dataType: DataType.fixedLengthInteger(1),
        );
        if (context.fields['new_params_bind_flag']) {
          // TODO(coocoa): Same _handshark.dart#364.
          // Steaming...
        }
        // TODO(coocoa): Same _handshark.dart#364.
        // Steaming...
      }
    }
    yield context.answerStep(
      name: 'query',
      dataType: DataType.restOfPacketString(),
    );
  }
}
