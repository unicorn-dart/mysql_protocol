part of 'lib.dart';

/// For more details, visit [Generic Response Packets][generic_response_packets]
///
/// [generic_response_packets]: https://dev.mysql.com/doc/dev/mysql-server/latest/page_protocol_basic_response_packets.html
///

@Packet()
@Serialized(name: "OK_Packet")
abstract class OkResponse implements SerializationStepResolutionDelegate {
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
  Iterable<SerializationStep> answerSerializationStep(
    SerializationStepAnswerContext context,
  ) sync* {
    yield context.answerStep(
      name: 'header',
      dataType: DataType.fixedLengthInteger(1),
    );
    yield context.answerStep(
      name: 'affected_rows',
      dataType: DataType.lengthEncodedInteger(),
    );
    yield context.answerStep(
      name: 'last_insert_id',
      dataType: DataType.lengthEncodedInteger(),
    );
    if (context.capabilities.contains('CLIENT_PROTOCOL_41')) {
      yield context.answerStep(
        name: 'status_flags',
        dataType: DataType.fixedLengthInteger(2),
      );
      yield context.answerStep(
        name: 'warnings',
        dataType: DataType.fixedLengthInteger(2),
      );
    } else if (context.capabilities.contains('CLIENT_TRANSACTIONS')) {
      yield context.answerStep(
        name: 'status_flags',
        dataType: DataType.fixedLengthInteger(2),
      );
    }
    if (context.capabilities.contains('CLIENT_SESSION_TRACK')) {
      yield context.answerStep(
        name: 'info',
        dataType: DataType.lengthEncodedString(),
      );
      if (context.capabilities.contains('SERVER_SESSION_STATE_CHANGED')) {
        yield context.answerStep(
          name: 'session_state_info',
          dataType: DataType.lengthEncodedString(),
        );
      }
    } else {
      yield context.answerStep(
        name: 'session_state_info',
        dataType: DataType.restOfPacketString(),
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
  Iterable<SerializationStep> answerSerializationStep(
    SerializationStepAnswerContext context,
  ) sync* {
    yield context.answerStep(
      name: 'header',
      dataType: DataType.fixedLengthInteger(1),
    );
    yield context.answerStep(
      name: 'error_code',
      dataType: DataType.fixedLengthInteger(2),
    );
    if (context.capabilities.contains('CLIENT_PROTOCOL_41')) {
      yield context.answerStep(
        name: 'sql_state_marker',
        dataType: DataType.fixedLengthString(1),
      );
      yield context.answerStep(
        name: 'sql_state',
        dataType: DataType.fixedLengthString(5),
      );
    }
    yield context.answerStep(
      name: 'error_message',
      dataType: DataType.restOfPacketString(),
    );
  }
}

@Packet()
@Serialized(name: "EOF_Packet")
abstract class EofPacket implements SerializationStepResolutionDelegate {
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
  Iterable<SerializationStep> answerSerializationStep(
    SerializationStepAnswerContext context,
  ) sync* {
    yield context.answerStep(
      name: 'header',
      dataType: DataType.fixedLengthInteger(1),
    );
    if (context.capabilities.contains('CLIENT_PROTOCOL_41')) {
      yield context.answerStep(
        name: 'warnings',
        dataType: DataType.fixedLengthString(2),
      );
      yield context.answerStep(
        name: 'status_flags',
        dataType: DataType.fixedLengthString(2),
      );
    }
  }
}

@Reference(
  kind: ReferenceKind.kEnumeration,
)
class ServerStatus {
  const ServerStatus({
    required this.name,
    required this.bitwise,
  });

  @Field()
  final String name;

  @Field()
  @Reference(
    kind: ReferenceKind.kEnumerationKey,
  )
  final int bitwise;

  static const kServerStatusInTrans = ServerStatus(
    name: "SERVER_STATUS_IN_TRANS",
    bitwise: 0x00000001,
  );

  static const kServerStatusAutoCommit = ServerStatus(
    name: "SERVER_STATUS_AUTOCOMMIT",
    bitwise: 0x00000002,
  );
}
