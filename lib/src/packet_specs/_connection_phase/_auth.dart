part of '../lib.dart';

/// For more details, visit [Connection Phase Packets][connection_phase_packets]
///
/// [connection_phase_packets]: https://dev.mysql.com/doc/dev/mysql-server/latest/page_protocol_connection_phase_packets.html
///

@Packet()
@Serialized(name: 'AuthSwitchRequest')
abstract class AuthSwitchRequest
    implements SerializationStepResolutionDelegate {
  /// Always 0xfe
  @Field()
  @SerializedField(name: "status_tag")
  int get statusTag;

  @Field()
  @SerializedField(name: "plugin_name")
  int get pluginName;

  @Field()
  @SerializedField(name: "plugin_provided_data")
  int get pluginProvidedData;

  @override
  Iterable<SerializationStep> answerSerializationStep(
    SerializationStepAnswerContext context,
  ) sync* {
    yield context.answerStep(
      name: 'status_tag',
      dataType: DataType.fixedLengthInteger(1),
    );
    yield context.answerStep(
      name: 'plugin_name',
      dataType: DataType.nullTerminatedString(),
    );
    yield context.answerStep(
      name: 'plugin_provided_data',
      dataType: DataType.restOfPacketString(),
    );
  }
}

@Packet()
@Serialized(name: "OldAuthSwitchRequest")
abstract class OldAuthSwitchRequest
    implements SerializationStepResolutionDelegate {
  /// Always value 0xfe
  @Field()
  @SerializedField(name: "status_tag")
  int get statusTag;

  @override
  Iterable<SerializationStep> answerSerializationStep(
    SerializationStepAnswerContext context,
  ) sync* {
    yield context.answerStep(
      name: 'status_tag',
      dataType: DataType.fixedLengthInteger(1),
    );
  }
}

@Packet()
@Serialized(name: "AuthSwitchResponse")
abstract class AuthSwitchResponse
    implements SerializationStepResolutionDelegate {
  @Field()
  @SerializedField(name: "authentication_response_data")
  String get authenticationResponseData;

  @override
  Iterable<SerializationStep> answerSerializationStep(
    SerializationStepAnswerContext context,
  ) sync* {
    yield context.answerStep(
      name: 'authentication_response_data',
      dataType: DataType.restOfPacketString(),
    );
  }
}

@Packet()
@Serialized(name: "AuthMoreData")
abstract class AuthMoreData implements SerializationStepResolutionDelegate {
  /// Always 0x01
  @Field()
  @SerializedField(name: "status_tag")
  String get statusTag;

  @Field()
  @SerializedField(name: "authentication_method_data")
  String get data;

  @override
  Iterable<SerializationStep> answerSerializationStep(
    SerializationStepAnswerContext context,
  ) sync* {
    yield context.answerStep(
      name: 'authentication_method_data',
      dataType: DataType.fixedLengthInteger(1),
    );
    yield context.answerStep(
      name: 'authentication_method_data',
      dataType: DataType.restOfPacketString(),
    );
  }
}

@Packet()
@Serialized(name: "AuthNextFactor")
abstract class AuthNextFactor implements SerializationStepResolutionDelegate {
  /// Always 0x02
  @Field()
  @SerializedField(name: "packet_type")
  String get packetType;

  @Field()
  @SerializedField(name: "plugin_name")
  String get pluginName;

  @Field()
  @SerializedField(name: "plugin_provided_data")
  String get pluginProvidedData;

  @override
  Iterable<SerializationStep> answerSerializationStep(
    SerializationStepAnswerContext context,
  ) sync* {
    yield context.answerStep(
      name: "packet_type",
      dataType: DataType.fixedLengthInteger(1),
    );
    yield context.answerStep(
      name: "plugin_name",
      dataType: DataType.nullTerminatedString(),
    );
    yield context.answerStep(
      name: "plugin_provided_data",
      dataType: DataType.restOfPacketString(),
    );
  }
}
