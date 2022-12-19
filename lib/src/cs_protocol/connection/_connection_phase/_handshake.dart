part of '../lib.dart';

/// For more details, visit [Connection Phase Packets][connection_phase_packets]
///
/// [connection_phase_packets]: https://dev.mysql.com/doc/dev/mysql-server/latest/page_protocol_connection_phase_packets.html
///

@Packet()
@Serialized(name: "HandshakeV9")
abstract class HandshakeV9 implements SerializationStepResolutionDelegate {
  /// Always 9
  @Field()
  @SerializedField(name: 'protocol_version')
  int get protocolVersion;

  /// Human readable status information
  @Field()
  @SerializedField(name: 'server_version')
  String get serverVersion;

  /// A.k.a. Connection ID
  @Field()
  @SerializedField(name: "thread_id")
  int get threadId;

  /// Authentication plugin data for Old Password Authentication
  @Field()
  @SerializedField(name: "scramble")
  String get scramble;

  @override
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    yield context.readAsScalar(
      name: 'protocol_version',
      reader: Scalar.fixedLengthInteger(1),
    );
    yield context.readAsScalar(
      name: 'server_version',
      reader: Scalar.nullTerminatedString(),
    );
    yield context.readAsScalar(
      name: 'thread_id',
      reader: Scalar.fixedLengthInteger(4),
    );
    yield context.readAsScalar(
      name: 'scramble',
      reader: Scalar.nullTerminatedString(),
    );
  }
}

@Packet()
abstract class HandshakeV10 implements SerializationStepResolutionDelegate {
  /// Always 10
  @Field()
  @SerializedField(name: "protocol_version")
  int get protocolVersion;

  /// Human readable status information
  @Field()
  @SerializedField(name: "server_version")
  String get serverVersion;

  /// A.k.a. Connection ID
  @Field()
  @SerializedField(name: "thread_id")
  int get threadId;

  /// First 8 bytes of the plugin provided data (scramble)
  @Field()
  @SerializedField(name: "auth_plugin_data_part_1")
  String get authPluginDataPart1;

  /// 0x00 byte, terminating the first part of a scramble
  @Field()
  @SerializedField(name: "filter")
  int get filter;

  /// The lower 2 bytes of the Capabilities Flags
  @Field()
  @SerializedField(name: "capability_flags_1")
  int get capabilityFlags1;

  /// Default server a_protocol_character_set, only the lower 8-bits
  @Field()
  @SerializedField(name: "chatacter_set")
  int get characterSet;

  /// SERVER_STATUS_flags_enum
  @Field()
  @SerializedField(name: "status_flags")
  int get statusFlags;

  /// The upper 2 bytes of the Capabilities Flags
  @Field()
  @SerializedField(name: "capability_flags_2")
  int get capabilityFlags2;

  /// length of the combined auth_plugin_data (scramble), if auth_plugin_data_len is > 0
  @Field()
  @SerializedField(name: "auth_plugin_data_len")
  @Capabilities("CLIENT_PLUGIN_AUTH")
  int get authPluginDataLen;

  /// Always 0x00
  @Field()
  @SerializedField(name: "00")
  @Capabilities("!CLIENT_PLUGIN_AUTH")
  int get constant0;

  /// reserved. All 0s.
  @Field()
  @SerializedField(name: "reserved")
  String get reserved;

  /// Rest of the plugin provided data (scramble), $len=MAX(13, length of auth-plugin-data - 8)
  @Field()
  @SerializedField(name: "auth_plugin_data_part_2")
  String get authPluginDataPart2;

  /// name of the auth_method that the auth_plugin_data belongs to
  @Field()
  @SerializedField(name: "auth_plugin_name")
  @Capabilities("CLIENT_PLUGIN_AUTH")
  String get authPluginName;

  @override
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    yield context.readAsScalar(
      name: 'protocol_version',
      reader: Scalar.fixedLengthInteger(1),
    );
    yield context.readAsScalar(
      name: 'server_version',
      reader: Scalar.nullTerminatedString(),
    );
    yield context.readAsScalar(
      name: 'thread_id',
      reader: Scalar.fixedLengthInteger(4),
    );
    yield context.readAsScalar(
      name: 'auth_plugin_data_part_1',
      reader: Scalar.fixedLengthString(8),
    );
    yield context.readAsScalar(
      name: 'filter',
      reader: Scalar.fixedLengthInteger(1),
    );
    yield context.readAsScalar(
      name: 'capability_flags_1',
      reader: Scalar.fixedLengthInteger(2),
    );
    yield context.readAsScalar(
      name: 'character_set',
      reader: Scalar.fixedLengthInteger(1),
    );
    yield context.readAsScalar(
      name: 'status_flags',
      reader: Scalar.fixedLengthInteger(2),
    );
    yield context.readAsScalar(
      name: 'capability_flags_2',
      reader: Scalar.fixedLengthInteger(2),
    );
    if (context.capabilities.hasSupported('CLIENT_PLUGIN_AUTH')) {
      yield context.readAsScalar(
        name: 'auth_plugin_data_len',
        reader: Scalar.fixedLengthInteger(1),
      );
    } else {
      yield context.readAsScalar(
        name: '00',
        reader: Scalar.fixedLengthInteger(1),
      );
    }
    yield context.readAsScalar(
      name: 'reversed',
      reader: Scalar.fixedLengthString(10),
    );
    yield context.readAsScalar(
      name: 'auth_plugin_data_part_1',
      reader: Scalar.lengthEncodedString(),
    );
    if (context.capabilities.hasSupported('CLIENT_PLUGIN_AUTH')) {
      yield context.readAsScalar(
        name: 'auth_plugin_name',
        reader: Scalar.nullTerminatedString(),
      );
    }
  }
}

@Packet()
@Serialized(name: "HandshakeResponse320")
abstract class HandshakeResponse320
    implements SerializationStepResolutionDelegate {
  @Field()
  @SerializedField(name: 'client_flag')
  int get clientFlag;

  @Field()
  @SerializedField(name: 'max_packet_size')
  int get maxPacketSize;

  @Field()
  @SerializedField(name: 'username')
  String get username;

  @Field()
  @SerializedField(name: 'auth_response')
  String get authResponse;

  @Field()
  @SerializedField(name: 'database')
  String get database;

  @override
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    yield context.readAsScalar(
      name: 'client_flag',
      reader: Scalar.fixedLengthInteger(2),
    );
    yield context.readAsScalar(
      name: 'max_packet_size',
      reader: Scalar.fixedLengthInteger(3),
    );
    yield context.readAsScalar(
      name: 'username',
      reader: Scalar.nullTerminatedString(),
    );
    if (context.capabilities.hasSupported('CLIENT_CONNECT_WITH_DB')) {
      yield context.readAsScalar(
        name: 'auth_response',
        reader: Scalar.nullTerminatedString(),
      );
      yield context.readAsScalar(
        name: 'database',
        reader: Scalar.nullTerminatedString(),
      );
    } else {
      yield context.readAsScalar(
        name: 'auth_response',
        reader: Scalar.restOfPacketString(),
      );
    }
  }
}

@Packet()
@Serialized(name: "HandshakeResponse41")
abstract class HandshakeResponse41
    implements SerializationStepResolutionDelegate {
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

  @Field()
  @SerializedField(name: 'username')
  String get username;

  @Field()
  @SerializedField(name: 'auth_response')
  String get authResponse;

  @Field()
  @SerializedField(name: 'auth_response_length')
  int get authResponseLength;

  @Field()
  @SerializedField(name: 'database')
  String get database;

  @Field()
  @SerializedField(name: 'client_plugin_name')
  String get clientPluginName;

  @Field()
  @SerializedField(name: 'attrs')
  Map<String, String> get attrs;

  @Field()
  @SerializedField(name: 'attrs_length')
  int get attrsLength;

  @Field()
  @SerializedField(name: 'zstd_compression_level')
  int get zstdCompressionLevel;

  @override
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    context.readAsScalar(
      name: 'client_flag',
      reader: Scalar.fixedLengthInteger(4),
    );
    context.readAsScalar(
      name: 'max_packet_size',
      reader: Scalar.fixedLengthInteger(4),
    );
    context.readAsScalar(
      name: 'character_set',
      reader: Scalar.fixedLengthInteger(1),
    );
    context.readAsScalar(
      name: 'filter',
      reader: Scalar.fixedLengthString(23),
    );
    context.readAsScalar(
      name: 'username',
      reader: Scalar.nullTerminatedString(),
    );
    if (context.capabilities
        .hasSupported('CLIENT_PLUGIN_AUTH_LENENC_CLIENT_DATA')) {
      context.readAsScalar(
        name: 'auth_response',
        reader: Scalar.lengthEncodedString(),
      );
    } else {
      context.readAsScalar(
        name: 'auth_response_length',
        reader: Scalar.fixedLengthInteger(1),
      );
      context.readAsScalar(
        name: 'username',
        reader: Scalar.lengthEncodedString(),
      );
    }
    if (context.capabilities.hasSupported('CLIENT_CONNECT_WITH_DB')) {
      context.readAsScalar(
        name: 'database',
        reader: Scalar.nullTerminatedString(),
      );
    }
    if (context.capabilities.hasSupported('CLIENT_PLUGIN_AUTH')) {
      context.readAsScalar(
        name: 'client_plugin_name',
        reader: Scalar.nullTerminatedString(),
      );
    }
    if (context.capabilities.hasSupported('CLIENT_CONNECT_ATTRS')) {
      context.readAsScalar(
        name: 'attrs_length',
        reader: Scalar.lengthEncodedInteger(),
      );
      // TODO(coocoa): Implement stream fetching within serialization context.
      //
      // streaming attributes...
    }
    context.readAsScalar(
      name: 'zstd_compression_level',
      reader: Scalar.fixedLengthInteger(1),
    );
  }
}
