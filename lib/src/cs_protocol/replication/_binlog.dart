part of "lib.dart";

/// [BinlogDumpCommand] represents COM_BIGLOG_DUMP command.
///
/// For more details, visit [COM_BINLOG_DUMP][com_binlog_dump].
///
/// [com_binlog_dump]: https://dev.mysql.com/doc/dev/mysql-server/latest/page_protocol_com_binlog_dump.html
///
@Packet()
@Serialized(name: "Binlog::COM_BIGLOG_DUMP")
abstract class BinlogDumpCommand
    implements SerializationStepResolutionDelegate {
  @Field()
  @SerializedField(name: "status")
  int get status;

  @Field()
  @SerializedField(name: "binlog_pos")
  int get binlogPos;

  @Field()
  @SerializedField(name: "flags")
  int get flags;

  @Field()
  @SerializedField(name: "server_id")
  int get serverId;

  @Field()
  @SerializedField(name: "binlog_filename")
  String get binlogFilename;

  @override
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    yield context.readAsScalar(
      name: "status",
      reader: Scalar.fixedLengthInteger(1),
    );
    yield context.readAsScalar(
      name: "binlog_pos",
      reader: Scalar.fixedLengthInteger(4),
    );
    yield context.readAsScalar(
      name: "flags",
      reader: Scalar.fixedLengthInteger(2),
    );
    yield context.readAsScalar(
      name: "server_id",
      reader: Scalar.fixedLengthInteger(4),
    );
    yield context.readAsScalar(
      name: "binlog_filename",
      reader: Scalar.restOfPacketString(),
    );
  }
}

@Packet()
@Serialized(name: "START_EVENT_V3")
abstract class BinlogStartEventV3
    implements SerializationStepResolutionDelegate {
  @Field()
  @SerializedField(name: "binlog_version")
  int get binlogVersion;

  @Field()
  @SerializedField(name: "mysql_server_version")
  String get mysqlServerVersion;

  @Field()
  @SerializedField(name: "create_timestamp")
  int get createTimestamp;

  @override
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    yield context.readAsScalar(
      name: "binlog_version",
      reader: Scalar.fixedLengthInteger(2),
    );
    yield context.readAsScalar(
      name: "mysql_server_version",
      reader: Scalar.fixedLengthString(50),
    );
    yield context.readAsScalar(
      name: "create_timestamp",
      reader: Scalar.fixedLengthInteger(4),
    );
  }
}

@Packet()
@Serialized(name: "Binlog::EventHeader")
abstract class BinlogEventHeader
    implements SerializationStepResolutionDelegate {
  @Field()
  @SerializedField(name: "timestamp")
  int get createTimestamp;

  @Field()
  @SerializedField(name: "event_type")
  int get eventType;

  @Field()
  @SerializedField(name: "server_id")
  int get serverId;

  @Field()
  @SerializedField(name: "event_size")
  int get eventSize;

  @Field()
  @SerializedField(name: "log_pos")
  int get logPos;

  @Field()
  @SerializedField(name: "flags")
  int get flags;

  @override
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    yield context.readAsScalar(
      name: "timestamp",
      reader: Scalar.fixedLengthInteger(4),
    );
    yield context.readAsScalar(
      name: "event_type",
      reader: Scalar.fixedLengthInteger(4),
    );
    yield context.readAsScalar(
      name: "server_id",
      reader: Scalar.fixedLengthInteger(4),
    );
    yield context.readAsScalar(
      name: "event_size",
      reader: Scalar.fixedLengthInteger(4),
    );
    if (context.binlog.binlogVersion > Version(1, 0, 0)) {
      yield context.readAsScalar(
        name: "log_pos",
        reader: Scalar.fixedLengthInteger(4),
      );
      yield context.readAsScalar(
        name: "flags",
        reader: Scalar.fixedLengthInteger(2),
      );
    }
  }
}

@Packet()
@Serialized(name: "Binlog::FORMAT_DESCRIPTION_EVENT")
abstract class BinlogFormatDescriptionEvent
    implements SerializationStepResolutionDelegate {
  @Field()
  @SerializedField(name: "binlog_version")
  int get binlogVersion;

  @Field()
  @SerializedField(name: "mysql_server_version")
  String get mysqlServerVersion;

  @Field()
  @SerializedField(name: "create_timestamp")
  int get createTimestamp;

  @override
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    yield context.readAsScalar(
      name: "binlog_version",
      reader: Scalar.fixedLengthInteger(2),
    );
    yield context.readAsScalar(
      name: "mysql_server_version",
      reader: Scalar.fixedLengthString(50),
    );
    yield context.readAsScalar(
      name: "create_timestamp",
      reader: Scalar.fixedLengthInteger(4),
    );
  }
}

@Packet()
@Serialized(name: "Binlog::STOP_EVENT")
abstract class BinlogStopEvent {}

@Packet()
@Serialized(name: "ROTATE_EVENT")
abstract class BinlogRotateEvent
    implements SerializationStepResolutionDelegate {
  @Field()
  @SerializedField(name: "position")
  int get position;

  @Field()
  @SerializedField(name: "binlog")
  String get binlog;

  @override
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    if (context.binlog.binlogVersion > Version(1, 0, 0)) {
      yield context.readAsScalar(
        name: "position",
        reader: Scalar.fixedLengthInteger(8),
      );
      yield context.readAsScalar(
        name: "binlog",
        reader: Scalar.restOfPacketString(),
      );
    }
  }
}

@Packet()
@Serialized(name: "SLAVE_EVENT")
abstract class BinlogSlaveEvent {}

@Packet()
@Serialized(name: "INCIENT_EVENT")
abstract class BinlogIncidentEvent
    implements SerializationStepResolutionDelegate {
  @Field()
  @SerializedField(name: "type")
  int get type;

  @Field()
  @SerializedField(name: "message_length")
  int get messageLength;

  @Field()
  @SerializedField(name: "message")
  String get message;

  @override
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    yield context.readAsScalar(
      name: 'type',
      reader: Scalar.fixedLengthInteger(1),
    );
    yield context.readAsScalar(
      name: 'message_length',
      reader: Scalar.fixedLengthInteger(1),
    );
    yield context.readAsScalar(
      name: 'message',
      reader: Scalar.fixedLengthInteger(context.fields['message_length']),
    );
  }
}

@Packet()
@Serialized(name: "HEARTBEAT_EVENT")
abstract class BinlogHeartbeatEvent {}

@Packet()
@Serialized(name: "Binlog::QUERY_EVENT")
abstract class BinlogQueryEvent implements SerializationStepResolutionDelegate {
  @Field()
  @SerializedField(name: "slave_proxy_id")
  int get slaveProxyId;

  @Field()
  @SerializedField(name: "execution_time")
  int get executionTime;

  @Field()
  @SerializedField(name: "schema_length")
  int get schemaLength;

  @Field()
  @SerializedField(name: "error_code")
  int get errorCode;

  @Field()
  @SerializedField(name: "status_vars_length")
  int get statusVarsLength;

  @Field()
  @SerializedField(name: "status_vars")
  Map<BinlogQueryStatusVarKey, BinlogQueryStatusVarValue> get statusVars;

  @Field()
  @SerializedField(name: "schema")
  String get schema;

  @Field()
  @SerializedField(name: "query")
  String get query;

  @override
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    yield context.readAsScalar(
      name: "slave_proxy_id",
      reader: Scalar.fixedLengthInteger(4),
    );
    yield context.readAsScalar(
      name: "execution_time",
      reader: Scalar.fixedLengthInteger(4),
    );
    yield context.readAsScalar(
      name: "schema_length",
      reader: Scalar.fixedLengthInteger(1),
    );
    yield context.readAsScalar(
      name: "error_code",
      reader: Scalar.fixedLengthInteger(2),
    );
    if (context.binlog.binlogVersion >= Version(4, 0, 0)) {
      yield context.readAsScalar(
        name: "status_vars_length",
        reader: Scalar.fixedLengthInteger(2),
      );
      for (var i = 0; i < context.fields["status_vars_length"]; i++) {
        final statusVarKey = BinlogQueryStatusVarKey.from(context.peekAsInteger(
          dataType: Scalar.fixedLengthInteger(1),
        ));

        if (statusVarKey == BinlogQueryStatusVarKey.kFlags2Code) {
          yield context.readAsMapEntry(
            name: "status_vars",
            keyReader: Scalar.fixedLengthInteger(1),
            keyType: ReferencedObject.from(BinlogQueryStatusVarKey),
            valueReader: ReferencedObject.from(BinlogQueryStatusVarFlags2Code),
          );
        }

        if (statusVarKey == BinlogQueryStatusVarKey.kSqlModeCode) {
          yield context.readAsMapEntry(
            name: "status_vars",
            keyReader: Scalar.fixedLengthInteger(1),
            keyType: ReferencedObject.from(BinlogQueryStatusVarKey),
            valueReader: ReferencedObject.from(BinlogQueryStatusVarSqlModeCode),
          );
        }

        if (statusVarKey == BinlogQueryStatusVarKey.kAutoIncrement) {
          yield context.readAsMapEntry(
            name: "status_vars",
            keyReader: Scalar.fixedLengthInteger(1),
            keyType: ReferencedObject.from(BinlogQueryStatusVarKey),
            valueReader:
                ReferencedObject.from(BinlogQueryStatusVarAutoIncrement),
          );
        }

        if (statusVarKey == BinlogQueryStatusVarKey.kCatalog) {
          yield context.readAsMapEntry(
            name: "status_vars",
            keyReader: Scalar.fixedLengthInteger(1),
            keyType: ReferencedObject.from(BinlogQueryStatusVarKey),
            valueReader: ReferencedObject.from(BinlogQueryStatusVarCatalog),
          );
        }

        if (statusVarKey == BinlogQueryStatusVarKey.kCharsetCode) {
          yield context.readAsMapEntry(
            name: "status_vars",
            keyReader: Scalar.fixedLengthInteger(1),
            keyType: ReferencedObject.from(BinlogQueryStatusVarKey),
            valueReader: ReferencedObject.from(BinlogQueryStatusVarCharsetCode),
          );
        }

        if (statusVarKey == BinlogQueryStatusVarKey.kTimeZoneCode) {
          yield context.readAsMapEntry(
            name: "status_vars",
            keyReader: Scalar.fixedLengthInteger(1),
            keyType: ReferencedObject.from(BinlogQueryStatusVarKey),
            valueReader:
                ReferencedObject.from(BinlogQueryStatusVarTimeZoneCode),
          );
        }

        if (statusVarKey == BinlogQueryStatusVarKey.kCatalogNzCode) {
          yield context.readAsMapEntry(
            name: "status_vars",
            keyReader: Scalar.fixedLengthInteger(1),
            keyType: ReferencedObject.from(BinlogQueryStatusVarKey),
            valueReader:
                ReferencedObject.from(BinlogQueryStatusVarCatalogNzCode),
          );
        }

        if (statusVarKey == BinlogQueryStatusVarKey.kLCTimeNamesCode) {
          yield context.readAsMapEntry(
            name: "status_vars",
            keyReader: Scalar.fixedLengthInteger(1),
            keyType: ReferencedObject.from(BinlogQueryStatusVarKey),
            valueReader:
                ReferencedObject.from(BinlogQueryStatusVarLCTimeNamesCode),
          );
        }

        if (statusVarKey == BinlogQueryStatusVarKey.kCharsetDatabaseCode) {
          yield context.readAsMapEntry(
            name: "status_vars",
            keyReader: Scalar.fixedLengthInteger(1),
            keyType: ReferencedObject.from(BinlogQueryStatusVarKey),
            valueReader:
                ReferencedObject.from(BinlogQueryStatusVarCharsetDatabaseCode),
          );
        }

        if (statusVarKey == BinlogQueryStatusVarKey.kTableMapForUpdateCode) {
          yield context.readAsMapEntry(
            name: "status_vars",
            keyReader: Scalar.fixedLengthInteger(1),
            keyType: ReferencedObject.from(BinlogQueryStatusVarKey),
            valueReader: ReferencedObject.from(
                BinlogQueryStatusVarTableMapForUpdateCode),
          );
        }

        if (statusVarKey == BinlogQueryStatusVarKey.kMasterDataWrittenCode) {
          yield context.readAsMapEntry(
            name: "status_vars",
            keyReader: Scalar.fixedLengthInteger(1),
            keyType: ReferencedObject.from(BinlogQueryStatusVarKey),
            valueReader: ReferencedObject.from(
                BinlogQueryStatusVarMasterDataWrittenCode),
          );
        }

        if (statusVarKey == BinlogQueryStatusVarKey.kInvokers) {
          yield context.readAsMapEntry(
            name: "status_vars",
            keyReader: Scalar.fixedLengthInteger(1),
            keyType: ReferencedObject.from(BinlogQueryStatusVarKey),
            valueReader: ReferencedObject.from(BinlogQueryStatusVarInvokers),
          );
        }

        if (statusVarKey == BinlogQueryStatusVarKey.kUpdatedDbNames) {
          yield context.readAsMapEntry(
            name: "status_vars",
            keyReader: Scalar.fixedLengthInteger(1),
            keyType: ReferencedObject.from(BinlogQueryStatusVarKey),
            valueReader:
                ReferencedObject.from(BinlogQueryStatusVarUpdatedDbNames),
          );
        }

        if (statusVarKey == BinlogQueryStatusVarKey.kMicroseconds) {
          yield context.readAsMapEntry(
            name: "status_vars",
            keyReader: Scalar.fixedLengthInteger(1),
            keyType: ReferencedObject.from(BinlogQueryStatusVarKey),
            valueReader:
                ReferencedObject.from(BinlogQueryStatusVarMicroseconds),
          );
        }
      }
    }
    yield context.readAsScalar(
      name: "database",
      reader: Scalar.nullTerminatedString(),
    );
    yield context.readAsScalar(
      name: "query",
      reader: Scalar.restOfPacketString(),
    );
  }
}

@Reference(kind: ReferenceKind.kEnumeration)
class BinlogQueryStatusVarKey with EquatableMixin {
  const BinlogQueryStatusVarKey({
    required this.name,
    required this.code,
  });

  factory BinlogQueryStatusVarKey.from(int code) =>
      allPossible.firstWhere((x) => x.code == code);

  final String name;

  @Reference(kind: ReferenceKind.kEnumerationPrimaryKey)
  final int code;

  @override
  List<Object> get props => [code];

  @override
  String toString() {
    return "$name(${code.toRadixString(16)})";
  }

  static const allPossible = [
    kFlags2Code,
    kSqlModeCode,
    kAutoIncrement,
    kCatalog,
    kCharsetCode,
    kTimeZoneCode,
    kCatalogNzCode,
    kLCTimeNamesCode,
    kCharsetDatabaseCode,
    kTableMapForUpdateCode,
    kMasterDataWrittenCode,
    kInvokers,
    kUpdatedDbNames,
    kMicroseconds
  ];

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kFlags2Code = BinlogQueryStatusVarKey(
    name: "Q_FLAGS2_CODE",
    code: 0x00,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kSqlModeCode = BinlogQueryStatusVarKey(
    name: "Q_SQL_MODE_CODE",
    code: 0x01,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kAutoIncrement = BinlogQueryStatusVarKey(
    name: "Q_AUTO_INCREMENT",
    code: 0x02,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kCatalog = BinlogQueryStatusVarKey(
    name: "Q_CATALOG",
    code: 0x03,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kCharsetCode = BinlogQueryStatusVarKey(
    name: "Q_CHARSET_CODE",
    code: 0x04,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kTimeZoneCode = BinlogQueryStatusVarKey(
    name: "Q_TIME_ZONE_CODE",
    code: 0x05,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kCatalogNzCode = BinlogQueryStatusVarKey(
    name: "	Q_CATALOG_NZ_CODE",
    code: 0x06,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kLCTimeNamesCode = BinlogQueryStatusVarKey(
    name: "Q_LC_TIME_NAMES_CODE",
    code: 0x07,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kCharsetDatabaseCode = BinlogQueryStatusVarKey(
    name: "Q_CHARSET_DATABASE_CODE",
    code: 0x08,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kTableMapForUpdateCode = BinlogQueryStatusVarKey(
    name: "Q_TABLE_MAP_FOR_UPDATE_CODE",
    code: 0x09,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kMasterDataWrittenCode = BinlogQueryStatusVarKey(
    name: "Q_MASTER_DATA_WRITTEN_CODE",
    code: 0x0a,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kInvokers = BinlogQueryStatusVarKey(
    name: "Q_INVOKERS",
    code: 0x0b,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kUpdatedDbNames = BinlogQueryStatusVarKey(
    name: "Q_UPDATED_DB_NAMES",
    code: 0x0c,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kMicroseconds = BinlogQueryStatusVarKey(
    name: "Q_MICROSECONDS",
    code: 0x0d,
  );
}

abstract class BinlogQueryStatusVarValue {}

@Reference(kind: ReferenceKind.kDataType)
@Serialized(name: "Binlog::QUERY_EVENT::Q_FLAGS2_CODE")
abstract class BinlogQueryStatusVarFlags2Code
    implements BinlogQueryStatusVarValue {
  @Field()
  @SerializedField(name: "bit_mask")
  int get bitMask;
}

@Reference(kind: ReferenceKind.kBitMask)
class BinlogQueryStatusVarFlags2CodeBitMask
    with EquatableMixin
    implements BitMask<BinlogQueryStatusVarFlags2CodeBitMask> {
  const BinlogQueryStatusVarFlags2CodeBitMask({
    required this.name,
    required this.bitMask,
  });

  final String name;

  @override
  final int bitMask;

  @override
  List<Object> get props => [bitMask];

  @override
  String toString() {
    return "$name(${bitMask.toRadixString(16)})";
  }

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kOptionAutoIsNull = BinlogQueryStatusVarFlags2CodeBitMask(
    name: "OPTION_AUTO_IS_NULL",
    bitMask: 0x00004000,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kOptionNotAutoCommit = BinlogQueryStatusVarFlags2CodeBitMask(
    name: "OPTION_NOT_AUTOCOMMIT",
    bitMask: 0x00080000,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kOptionNoForeignKeyChecks =
      BinlogQueryStatusVarFlags2CodeBitMask(
    name: "OPTION_NO_FOREIGN_KEY_CHECKS",
    bitMask: 0x04000000,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kOptionRelaxedUniqueChecks =
      BinlogQueryStatusVarFlags2CodeBitMask(
    name: "OPTION_RELAXED_UNIQUE_CHECKS",
    bitMask: 0x08000000,
  );
}

@Reference(kind: ReferenceKind.kDataType)
@Serialized(name: "Binlog::QUERY_EVENT::Q_SQL_MODE_CODE")
abstract class BinlogQueryStatusVarSqlModeCode
    implements BinlogQueryStatusVarValue {
  @Field()
  @SerializedField(name: "bit_mask")
  int get bitMask;
}

@Reference(kind: ReferenceKind.kBitMask)
class BinlogQueryStatusVarSqlModeCodeBitMask
    with EquatableMixin
    implements BitMask<BinlogQueryStatusVarSqlModeCodeBitMask> {
  const BinlogQueryStatusVarSqlModeCodeBitMask({
    required this.name,
    required this.bitMask,
  });

  final String name;

  @override
  final int bitMask;

  @override
  List<Object> get props => [bitMask];

  @override
  String toString() {
    return "$name(${bitMask.toRadixString(16)})";
  }

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModeRealAsFloat = BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_REAL_AS_FLOAT",
    bitMask: 0x00000001,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModePipesAsConcat = BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_PIPES_AS_CONCAT",
    bitMask: 0x00000002,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModeAnsiQuotes = BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_ANSI_QUOTES",
    bitMask: 0x00000004,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModeIgnoreSpace = BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_IGNORE_SPACE",
    bitMask: 0x00000008,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModeNotUsed = BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_NOT_USED",
    bitMask: 0x00000010,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModeOnlyFullGroupBy = BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_ONLY_FULL_GROUP_BY",
    bitMask: 0x00000020,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModeNoUnsignedSubtraction =
      BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_NO_UNSIGNED_SUBTRACTION",
    bitMask: 0x00000040,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModeNoDirInCreate = BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_NO_DIR_IN_CREATE",
    bitMask: 0x00000080,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModePostgresql = BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_POSTGRESQL",
    bitMask: 0x00000100,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModeOracle = BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_ORACLE",
    bitMask: 0x00000200,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModeMssql = BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_MSSQL",
    bitMask: 0x00000800,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModeDb2 = BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_DB2",
    bitMask: 0x00001000,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModeMaxdb = BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_MAXDB",
    bitMask: 0x00002000,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModeNoKeyOptions = BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_NO_KEY_OPTIONS",
    bitMask: 0x00004000,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModeNoTableOptions = BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_NO_TABLE_OPTIONS",
    bitMask: 0x00008000,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModeNoFieldOptions = BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_NO_FIELD_OPTIONS",
    bitMask: 0x00010000,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModeMysql323 = BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_MYSQL323",
    bitMask: 0x00020000,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModeMysql40 = BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_MYSQL40",
    bitMask: 0x00040000,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModeAnsi = BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_ANSI",
    bitMask: 0x00080000,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModeNoAutoValueOnZero = BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_NO_AUTO_VALUE_ON_ZERO",
    bitMask: 0x00100000,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModeNoBackslashEscapes = BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_NO_BACKSLASH_ESCAPES",
    bitMask: 0x00200000,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModeStrictTransTables = BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_STRICT_TRANS_TABLES",
    bitMask: 0x00400000,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModeStrictAllTables = BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_STRICT_ALL_TABLES",
    bitMask: 0x00800000,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModeNoZeroInDate = BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_NO_ZERO_IN_DATE",
    bitMask: 0x00800000,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModeNoZeroDate = BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_NO_ZERO_DATE",
    bitMask: 0x01000000,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModeInvalidDates = BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_INVALID_DATES",
    bitMask: 0x02000000,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModeErrorForDivisionByZero =
      BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_ERROR_FOR_DIVISION_BY_ZERO",
    bitMask: 0x04000000,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModeTraditional = BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_TRADITIONAL",
    bitMask: 0x08000000,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModeNoAutoCreateUser = BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_NO_AUTO_CREATE_USER",
    bitMask: 0x10000000,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModeHighNotPrecedence = BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_HIGH_NOT_PRECEDENCE",
    bitMask: 0x20000000,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModeNoEngineSubstitution =
      BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_NO_ENGINE_SUBSTITUTION",
    bitMask: 0x40000000,
  );

  @Reference(kind: ReferenceKind.kBitMaskItem)
  static const kModePadCharToFullLength =
      BinlogQueryStatusVarSqlModeCodeBitMask(
    name: "MODE_PAD_CHAR_TO_FULL_LENGTH",
    bitMask: 0x80000000,
  );
}

@Reference(kind: ReferenceKind.kDataType)
@Serialized(name: "Binlog::QUERY_EVENT::Q_AUTO_INCREMENT")
abstract class BinlogQueryStatusVarAutoIncrement
    implements BinlogQueryStatusVarValue, SerializationStepResolutionDelegate {
  @Field()
  @SerializedField(name: "autoincrement_increment")
  int get increment;

  @Field()
  @SerializedField(name: "autoincrement_offset")
  int get offset;

  @override
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    yield context.readAsScalar(
      name: "autoincrement_increment",
      reader: Scalar.fixedLengthInteger(2),
    );
    yield context.readAsScalar(
      name: "autoincrement_offset",
      reader: Scalar.fixedLengthInteger(2),
    );
  }
}

@Reference(kind: ReferenceKind.kDataType)
@Serialized(name: "Binlog::QUERY_EVENT::Q_CATALOG")
abstract class BinlogQueryStatusVarCatalog
    implements BinlogQueryStatusVarValue, SerializationStepResolutionDelegate {
  @Field()
  @SerializedField(name: "length")
  int get length;

  @Field()
  @SerializedField(name: "catalog")
  String get catalog;

  @override
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    yield context.readAsScalar(
      name: "length",
      reader: Scalar.fixedLengthInteger(1),
    );
    yield context.readAsScalar(
      name: "catalog",
      reader: Scalar.nullTerminatedString(),
    );
  }
}

@Reference(kind: ReferenceKind.kDataType)
@Serialized(name: "Binlog::QUERY_EVENT::Q_CHARSET_CODE")
abstract class BinlogQueryStatusVarCharsetCode
    implements BinlogQueryStatusVarValue, SerializationStepResolutionDelegate {
  @Field()
  @SerializedField(name: "client_character_set")
  int get clientCharacterSet;

  @Field()
  @SerializedField(name: "collation_connection")
  int get collationConnection;

  @Field()
  @SerializedField(name: "collation_server")
  int get collationServer;

  @override
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    yield context.readAsScalar(
      name: "client_character_set",
      reader: Scalar.fixedLengthInteger(2),
    );
    yield context.readAsScalar(
      name: "collation_connection",
      reader: Scalar.fixedLengthInteger(2),
    );
    yield context.readAsScalar(
      name: "collation_server",
      reader: Scalar.fixedLengthInteger(2),
    );
  }
}

@Reference(kind: ReferenceKind.kDataType)
@Serialized(name: "Binlog::QUERY_EVENT::Q_TIME_ZONE_CODE")
abstract class BinlogQueryStatusVarTimeZoneCode
    implements BinlogQueryStatusVarValue, SerializationStepResolutionDelegate {
  @Field()
  @SerializedField(name: "length")
  int get length;

  @Field()
  @SerializedField(name: "time_zone")
  String get timeZone;

  @override
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    yield context.readAsScalar(
      name: "length",
      reader: Scalar.fixedLengthInteger(2),
    );
    final length = context.fields["length"];
    if (length > 0) {
      yield context.readAsScalar(
        name: "time_zone",
        reader: Scalar.fixedLengthInteger(length),
      );
    }
  }
}

///
/// For more details, visit [Q_CATALOG_NZ_CODE](source_code)
///
/// [source_code]: https://github.com/mysql/mysql-server/blob/8.0/libbinlogevents/include/statement_events.h#L483
///
@Reference(kind: ReferenceKind.kDataType)
@Serialized(name: "Binlog::QUERY_EVENT::Q_CATALOG_NZ_CODE")
abstract class BinlogQueryStatusVarCatalogNzCode
    implements BinlogQueryStatusVarValue, SerializationStepResolutionDelegate {
  @Field()
  @SerializedField(name: "length")
  int get length;

  @Field()
  @SerializedField(name: "catalog")
  String get catalog;

  @override
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    yield context.readAsScalar(
      name: "length",
      reader: Scalar.fixedLengthInteger(2),
    );
    final length = context.fields["length"];
    if (length > 0) {
      yield context.readAsScalar(
        name: "catalog",
        reader: Scalar.fixedLengthInteger(length),
      );
    }
  }
}

@Reference(kind: ReferenceKind.kDataType)
@Serialized(name: "Binlog::QUERY_EVENT::Q_LC_TIME_NAMES_CODE")
abstract class BinlogQueryStatusVarLCTimeNamesCode
    implements BinlogQueryStatusVarValue, SerializationStepResolutionDelegate {
  @Field()
  @SerializedField(name: "locale_code")
  int get localeCode;

  @override
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    yield context.readAsScalar(
      name: "locale_code",
      reader: Scalar.fixedLengthInteger(2),
    );
  }
}

@Reference(kind: ReferenceKind.kDataType)
@Serialized(name: "Binlog::QUERY_EVENT::Q_CHARSET_DATABASE_CODE")
abstract class BinlogQueryStatusVarCharsetDatabaseCode
    implements BinlogQueryStatusVarValue, SerializationStepResolutionDelegate {
  @Field()
  @SerializedField(name: "database_collation")
  int get databaseCollation;

  @override
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    yield context.readAsScalar(
      name: "database_collation",
      reader: Scalar.fixedLengthInteger(2),
    );
  }
}

@Reference(kind: ReferenceKind.kDataType)
@Serialized(name: "Binlog::QUERY_EVENT::Q_TABLE_MAP_FOR_UPDATE_CODE")
abstract class BinlogQueryStatusVarTableMapForUpdateCode
    implements BinlogQueryStatusVarValue, SerializationStepResolutionDelegate {
  @Field()
  @SerializedField(name: "bit_mask")
  int get bitMask;

  @override
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    yield context.readAsScalar(
      name: "bit_mask",
      reader: Scalar.fixedLengthInteger(8),
    );
  }
}

@Reference(kind: ReferenceKind.kDataType)
@Serialized(name: "Binlog::QUERY_EVENT::Q_MASTER_DATA_WRITTEN_CODE")
abstract class BinlogQueryStatusVarMasterDataWrittenCode
    implements BinlogQueryStatusVarValue, SerializationStepResolutionDelegate {
  @Field()
  @SerializedField(name: "original_event_length")
  int get originalEventLength;

  @override
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    yield context.readAsScalar(
      name: "original_event_length",
      reader: Scalar.fixedLengthInteger(4),
    );
  }
}

@Reference(kind: ReferenceKind.kDataType)
@Serialized(name: "Binlog::QUERY_EVENT::Q_INVOKERS")
abstract class BinlogQueryStatusVarInvokers
    implements BinlogQueryStatusVarValue, SerializationStepResolutionDelegate {
  @Field()
  @SerializedField(name: "user_name_length")
  int get usernameLength;

  @Field()
  @SerializedField(name: "user_name")
  String get username;

  @Field()
  @SerializedField(name: "host_name_length")
  int get hostnameLength;

  @Field()
  @SerializedField(name: "host_name")
  String get hostname;

  @override
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    yield context.readAsScalar(
      name: "user_name_length",
      reader: Scalar.fixedLengthInteger(1),
    );
    final usernameLen = context.fields["user_name_length"];
    if (usernameLen > 0) {
      yield context.readAsScalar(
        name: "user_name",
        reader: Scalar.fixedLengthString(usernameLen),
      );
    }
    yield context.readAsScalar(
      name: "host_name_length",
      reader: Scalar.fixedLengthInteger(1),
    );
    final hostnameLen = context.fields["host_name_length"];
    if (hostnameLen > 0) {
      yield context.readAsScalar(
        name: "host_name",
        reader: Scalar.fixedLengthString(usernameLen),
      );
    }
  }
}

@Reference(kind: ReferenceKind.kDataType)
@Serialized(name: "Binlog::QUERY_EVENT::Q_UPDATED_DB_NAMES")
abstract class BinlogQueryStatusVarUpdatedDbNames
    implements BinlogQueryStatusVarValue, SerializationStepResolutionDelegate {
  @Field()
  @SerializedField(name: "count")
  int get count;

  @Field()
  @SerializedField(name: "database_names")
  List<String> get databaseNames;

  @override
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    yield context.readAsScalar(
      name: "count",
      reader: Scalar.fixedLengthInteger(1),
    );
    final count = context.fields["count"];
    for (var i = 0; i < count; i++) {
      yield context.readAsArrayElement(
        name: "database_names",
        reader: Scalar.nullTerminatedString(),
      );
    }
  }
}

@Reference(kind: ReferenceKind.kDataType)
@Serialized(name: "Binlog::QUERY_EVENT::Q_MICROSECONDS")
abstract class BinlogQueryStatusVarMicroseconds
    implements BinlogQueryStatusVarValue, SerializationStepResolutionDelegate {
  @Field()
  @SerializedField(name: "microsecond_part")
  int get microsecondPart;

  @override
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    yield context.readAsScalar(
      name: "microsecond_part",
      reader: Scalar.fixedLengthInteger(3),
    );
  }
}

Version getBinlogVersion(Version mysqlServerVersion) {
  if (mysqlServerVersion >= Version(3, 23, 0) &&
      mysqlServerVersion < Version(4, 0, 0)) {
    return Version(1, 0, 0);
  }

  if (mysqlServerVersion >= Version(4, 0, 0) &&
      mysqlServerVersion <= Version(4, 0, 1)) {
    return Version(2, 0, 0);
  }

  if (mysqlServerVersion >= Version(4, 0, 2) &&
      mysqlServerVersion < Version(5, 0, 0)) {
    return Version(3, 0, 0);
  }

  if (mysqlServerVersion >= Version(5, 0, 0)) {
    return Version(4, 0, 0);
  }

  throw ArgumentError.value(
    mysqlServerVersion,
    "MySQL server version",
    "Unknown MySQL server version",
  );
}
