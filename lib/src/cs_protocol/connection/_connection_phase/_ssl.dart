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
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    if (context.capabilities.hasSupported('CLIENT_PROTOCOL_41')) {
      yield context.readAsScalar(
        name: 'client_flag',
        reader: Scalar.fixedLengthInteger(4),
      );
      yield context.readAsScalar(
        name: 'max_packet_size',
        reader: Scalar.fixedLengthInteger(4),
      );
      yield context.readAsScalar(
        name: 'character_set',
        reader: Scalar.fixedLengthInteger(1),
      );
      yield context.readAsScalar(
        name: 'filter',
        reader: Scalar.fixedLengthString(23),
      );
    } else {
      yield context.readAsScalar(
        name: 'client_flag',
        reader: Scalar.fixedLengthInteger(2),
      );
      yield context.readAsScalar(
        name: 'max_packet_size',
        reader: Scalar.fixedLengthInteger(3),
      );
    }
  }
}
