part of 'lib.dart';

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
  @SerializedField(name: 'status')
  int get status;

  @Field()
  @SerializedField(name: 'binlog_pos')
  int get binlogPos;

  @Field()
  @SerializedField(name: 'flags')
  int get flags;

  @Field()
  @SerializedField(name: 'server_id')
  int get serverId;

  @Field()
  @SerializedField(name: 'binlog_filename')
  String get binlogFilename;

  @override
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    yield context.readAsField(
      name: 'status',
      dataType: DataType.fixedLengthInteger(1),
    );
    yield context.readAsField(
      name: 'binlog_pos',
      dataType: DataType.fixedLengthInteger(4),
    );
    yield context.readAsField(
      name: 'flags',
      dataType: DataType.fixedLengthInteger(2),
    );
    yield context.readAsField(
      name: 'server_id',
      dataType: DataType.fixedLengthInteger(4),
    );
    yield context.readAsField(
      name: 'binlog_filename',
      dataType: DataType.restOfPacketString(),
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
    yield context.readAsField(
      name: "binlog_version",
      dataType: DataType.fixedLengthInteger(2),
    );
    yield context.readAsField(
      name: "mysql_server_version",
      dataType: DataType.fixedLengthString(50),
    );
    yield context.readAsField(
      name: "create_timestamp",
      dataType: DataType.fixedLengthInteger(4),
    );
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
    yield context.readAsField(
      name: "binlog_version",
      dataType: DataType.fixedLengthInteger(2),
    );
    yield context.readAsField(
      name: "mysql_server_version",
      dataType: DataType.fixedLengthString(50),
    );
    yield context.readAsField(
      name: "create_timestamp",
      dataType: DataType.fixedLengthInteger(4),
    );
  }
}

@Packet()
@Serialized(name: "Binlog::STOP_EVENT")
abstract class BinlogStopEvent {}

@Packet()
@Serialized(name: "ROTATE_EVENT")
abstract class BinlogRotateEvent {}

@Packet()
@Serialized(name: "SLAVE_EVENT")
abstract class BinlogSlaveEvent {}

@Packet()
@Serialized(name: "INCIENT_EVENT")
abstract class BinlogIncidentEvent {}

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

  @override
  Iterable<SerializationStep> resolveSteps(
    SerializationStepResolutionContext context,
  ) sync* {
    yield context.readAsField(
      name: "slave_proxy_id",
      dataType: DataType.fixedLengthInteger(4),
    );
    yield context.readAsField(
      name: "execution_time",
      dataType: DataType.fixedLengthInteger(4),
    );
    yield context.readAsField(
      name: "schema_length",
      dataType: DataType.fixedLengthInteger(1),
    );
    yield context.readAsField(
      name: "error_code",
      dataType: DataType.fixedLengthInteger(2),
    );
    final binlogVersion =
        context.getEnvironment<BinlogEnvironment>().binlogVersion;
    if (binlogVersion >= Version(4, 0, 0)) {
      yield context.readAsField(
        name: "status_vars_length",
        dataType: DataType.fixedLengthInteger(2),
      );
    }
  }
}

@Packet()
@Serialized(name: "Binlog::EventHeader")
abstract class BinlogHeader implements SerializationStepResolutionDelegate {
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
    yield context.readAsField(
      name: 'timestamp',
      dataType: DataType.fixedLengthInteger(4),
    );
    yield context.readAsField(
      name: 'event_type',
      dataType: DataType.fixedLengthInteger(4),
    );
    yield context.readAsField(
      name: 'server_id',
      dataType: DataType.fixedLengthInteger(4),
    );
    yield context.readAsField(
      name: 'event_size',
      dataType: DataType.fixedLengthInteger(4),
    );
    final binlogVersion =
        context.getEnvironment<BinlogEnvironment>().binlogVersion;
    if (binlogVersion > Version(1, 0, 0)) {
      yield context.readAsField(
        name: 'log_pos',
        dataType: DataType.fixedLengthInteger(4),
      );
      yield context.readAsField(
        name: 'flags',
        dataType: DataType.fixedLengthInteger(2),
      );
    }
  }
}

@Reference(kind: ReferenceKind.kEnumeration)
class BinlogQueryStatusVarKey {
  const BinlogQueryStatusVarKey({
    required this.name,
    required this.code,
  });

  final String name;

  @Reference(kind: ReferenceKind.kEnumerationPrimaryKey)
  final int code;

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

abstract class BinlogQueryStatusVarFlags2Code
    implements BinlogQueryStatusVarValue {
  int get bitMask;
}

@Reference(kind: ReferenceKind.kBitMask)
class BinlogQueryStatusVarFlags2CodeBitMask
    implements BitMask<BinlogQueryStatusVarFlags2CodeBitMask> {
  const BinlogQueryStatusVarFlags2CodeBitMask({
    required this.name,
    required this.bitMask,
  });

  final String name;

  @override
  final int bitMask;

  static const kOptionAutoIsNull = BinlogQueryStatusVarFlags2CodeBitMask(
    name: "OPTION_AUTO_IS_NULL",
    bitMask: 0x00004000,
  );

  static const kOptionNotAutoCommit = BinlogQueryStatusVarFlags2CodeBitMask(
    name: "OPTION_NOT_AUTOCOMMIT",
    bitMask: 0x00080000,
  );

  static const kOptionNoForeignKeyChecks =
      BinlogQueryStatusVarFlags2CodeBitMask(
    name: "OPTION_NO_FOREIGN_KEY_CHECKS",
    bitMask: 0x04000000,
  );

  static const kOptionRelaxedUniqueChecks =
      BinlogQueryStatusVarFlags2CodeBitMask(
    name: "OPTION_RELAXED_UNIQUE_CHECKS",
    bitMask: 0x08000000,
  );
}

abstract class BinlogQueryStatusVarSqlModeCode
    implements BinlogQueryStatusVarValue {
  int get bitMask;
}

@Reference(kind: ReferenceKind.kBitMask)
class BinlogQueryStatusVarSqlModeCodeBitMask
    implements BitMask<BinlogQueryStatusVarSqlModeCodeBitMask> {
  const BinlogQueryStatusVarSqlModeCodeBitMask({
    required this.name,
    required this.bitMask,
  });

  final String name;

  @override
  final int bitMask;

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

abstract class BinlogQueryStatusVarAutoIncrement
    implements BinlogQueryStatusVarValue {
  int get increment;

  int get offset;
}

abstract class BinlogQueryStatusVarCatalog
    implements BinlogQueryStatusVarValue {
  int get length;

  String get catalogName;
}

abstract class BinlogQueryStatusVarCharsetCode
    implements BinlogQueryStatusVarValue {
  int get characterSetClient;

  int get collationConnection;

  int get collationServer;
}

abstract class BinlogQueryStatusVarTimeZoneCode
    implements BinlogQueryStatusVarValue {
  int get length;

  String get timezone;
}

///
/// For more details, visit [Q_CATALOG_NZ_CODE](source_code)
///
/// [source_code]: https://github.com/mysql/mysql-server/blob/8.0/libbinlogevents/include/statement_events.h#L483
///
abstract class BinlogQueryStatusVarCatalogNzCode
    implements BinlogQueryStatusVarValue {
  int get length;

  String get catalogName;
}

abstract class BinlogQueryStatusVarLCTimeNamesCode
    implements BinlogQueryStatusVarValue {
  int get localeCode;
}

abstract class BinlogQueryStatusVarCharsetDatabaseCode
    implements BinlogQueryStatusVarValue {
  String get databaseCollation;
}

abstract class BinlogQueryStatusVarTableMapForUpdateCode
    implements BinlogQueryStatusVarValue {
  int get bitMask;
}

abstract class BinlogQueryStatusVarMasterDataWrittenCode
    implements BinlogQueryStatusVarValue {
  int get originalEventLength;
}

abstract class BinlogQueryStatusVarInvokers
    implements BinlogQueryStatusVarValue {
  int get usernameLength;

  String get username;

  int get hostnameLength;

  String get hostname;
}

abstract class BinlogQueryStatusVarUpdatedDbNames
    implements BinlogQueryStatusVarValue {
  int get count;

  List<String> get databaseNames;
}

abstract class BinlogQueryStatusVarMicroseconds
    implements BinlogQueryStatusVarValue {
  int get microsecondPart;
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
    'MySQL server version',
    "Unknown MySQL server version",
  );
}
