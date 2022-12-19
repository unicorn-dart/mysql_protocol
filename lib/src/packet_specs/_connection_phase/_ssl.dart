part of '../lib.dart';

/// For more details, visit [Connection Phase Packets][connection_phase_packets]
///
/// [connection_phase_packets]: https://dev.mysql.com/doc/dev/mysql-server/latest/page_protocol_connection_phase_packets.html
///

@Packet()
@Serialized(name: "SSLRequest")
abstract class SSLRequest implements SerializationStepResolutionDelegate {
  @Field()
  @SerializedField(name: 'client_flag')
  int get clientFlag;

  @Field()
  @SerializedField(name: 'max_packet_size')
  int get maxPacketSize;

  @Field()
  @SerializedField(name: 'character_set')
  int get characterSet;

  @Field()
  @SerializedField(name: 'filter')
  String get filter;

  @override
  Iterable<SerializationStep> answerSerializationStep(
    SerializationStepAnswerContext context,
  ) sync* {
    if (context.capabilities.contains('CLIENT_PROTOCOL_41')) {
      yield context.answerStep(
        name: 'client_flag',
        dataType: DataType.fixedLengthInteger(4),
      );
      yield context.answerStep(
        name: 'max_packet_size',
        dataType: DataType.fixedLengthInteger(4),
      );
      yield context.answerStep(
        name: 'character_set',
        dataType: DataType.fixedLengthInteger(1),
      );
      yield context.answerStep(
        name: 'filter',
        dataType: DataType.fixedLengthString(23),
      );
    } else {
      yield context.answerStep(
        name: 'client_flag',
        dataType: DataType.fixedLengthInteger(2),
      );
      yield context.answerStep(
        name: 'max_packet_size',
        dataType: DataType.fixedLengthInteger(3),
      );
    }
  }
}
