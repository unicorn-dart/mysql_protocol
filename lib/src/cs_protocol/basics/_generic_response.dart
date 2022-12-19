part of 'lib.dart';

/// For more details, visit [Generic Response Packets][generic_response_packets]
///
/// [generic_response_packets]: https://dev.mysql.com/doc/dev/mysql-server/latest/page_protocol_basic_response_packets.html
///

@Packet()
@Serialized(name: "OK_Packet")
abstract class OKResponse implements SerializationStepResolutionDelegate {
  /// 0x00 or 0xFE the OK packet header
  @Field()
  @SerializedField(name: 'header')
  int get header;

  /// Affected rows
  @Field()
  @SerializedField(name: 'affected_rows')
  int get affectedRows;

  // Last insert ID
  @Field()
  @SerializedField(name: 'last_insert_id')
  int get lastInsertId;

  @Field()
  @SerializedField(name: 'status_flags')
  ServerStatus get statusFlags;

  @Field()
  @SerializedField(name: 'warnings')
  int get warnings;

  @Field()
  @SerializedField(name: 'info')
  String get info;

  @Field()
  @SerializedField(name: 'session_state_info')
  SessionStateInfo get sessionStateInfo;

  @override
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    yield context.readAsScalar(
      name: 'header',
      reader: Scalar.fixedLengthInteger(1),
    );
    yield context.readAsScalar(
      name: 'affected_rows',
      reader: Scalar.lengthEncodedInteger(),
    );
    yield context.readAsScalar(
      name: 'last_insert_id',
      reader: Scalar.lengthEncodedInteger(),
    );
    if (context.capabilities.hasSupported('CLIENT_PROTOCOL_41')) {
      yield context.readAsScalar(
        name: 'status_flags',
        reader: Scalar.fixedLengthInteger(2),
      );
      yield context.readAsScalar(
        name: 'warnings',
        reader: Scalar.fixedLengthInteger(2),
      );
    } else if (context.capabilities.hasSupported('CLIENT_TRANSACTIONS')) {
      yield context.readAsScalar(
        name: 'status_flags',
        reader: Scalar.fixedLengthInteger(2),
      );
    }
    if (context.capabilities.hasSupported('CLIENT_SESSION_TRACK')) {
      yield context.readAsScalar(
        name: 'info',
        reader: Scalar.lengthEncodedString(),
      );
      if (context.capabilities.hasSupported('SERVER_SESSION_STATE_CHANGED')) {
        yield context.readAsScalar(
          name: 'session_state_info',
          reader: Scalar.lengthEncodedString(),
        );
      }
    } else {
      yield context.readAsScalar(
        name: 'session_state_info',
        reader: Scalar.restOfPacketString(),
      );
    }
  }
}

@DataModel()
abstract class SessionStateInfo {
  @Field()
  int get type;

  @Field()
  String get data;
}

@DataModel()
abstract class SessionTrackSystemVariables {
  @Field()
  int get mandatoryFlag;

  @Field()
  String get name;

  @Field()
  String get value;
}

@DataModel()
abstract class SessionTrackSchema {
  @Field()
  int get mandatoryFlag;

  @Field()
  String get name;
}

@DataModel()
abstract class SessionTrackStateChange {
  @Field()
  int get mandatoryFlag;

  @Field()
  String get isTracked;
}

@Packet()
@Serialized(name: "ERR_Packet")
abstract class ErrPacket implements SerializationStepResolutionDelegate {
  @Field()
  @SerializedField(name: 'header')
  int get header;

  @Field()
  @SerializedField(name: 'error_code')
  int get errorCode;

  @Field()
  @SerializedField(name: 'error_message')
  String get errorMessage;

  @Field()
  @SerializedField(name: 'sql_state_marker')
  @Capabilities("CLIENT_PROTOCOL_41")
  String get sqlStateMarker;

  @Field()
  @SerializedField(name: 'sql_state')
  @Capabilities("CLIENT_PROTOCOL_41")
  String get sqlState;

  @override
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    yield context.readAsScalar(
      name: 'header',
      reader: Scalar.fixedLengthInteger(1),
    );
    yield context.readAsScalar(
      name: 'error_code',
      reader: Scalar.fixedLengthInteger(2),
    );
    if (context.capabilities.hasSupported('CLIENT_PROTOCOL_41')) {
      yield context.readAsScalar(
        name: 'sql_state_marker',
        reader: Scalar.fixedLengthString(1),
      );
      yield context.readAsScalar(
        name: 'sql_state',
        reader: Scalar.fixedLengthString(5),
      );
    }
    yield context.readAsScalar(
      name: 'error_message',
      reader: Scalar.restOfPacketString(),
    );
  }
}

@Packet()
@Serialized(name: "EOF_Packet")
abstract class EOFPacket implements SerializationStepResolutionDelegate {
  @Field()
  @SerializedField(name: 'header')
  int get header;

  @Field()
  @SerializedField(name: 'warnings')
  @Capabilities("CLIENT_PROTOCOL_41")
  int get warnings;

  @Field()
  @SerializedField(name: 'status_flags')
  @Capabilities("CLIENT_PROTOCOL_41")
  ServerStatus get statusFlags;

  @override
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    yield context.readAsScalar(
      name: 'header',
      reader: Scalar.fixedLengthInteger(1),
    );
    if (context.capabilities.hasSupported('CLIENT_PROTOCOL_41')) {
      yield context.readAsScalar(
        name: 'warnings',
        reader: Scalar.fixedLengthString(2),
      );
      yield context.readAsScalar(
        name: 'status_flags',
        reader: Scalar.fixedLengthString(2),
      );
    }
  }
}
