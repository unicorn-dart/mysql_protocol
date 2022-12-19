part of 'lib.dart';

/// For more details, visit [field_types.h](https://sourcegraph.com/github.com/mysql/mysql-server@8.0/-/blob/include/field_types.h)
///

@Reference(kind: ReferenceKind.kEnumeration)
class MySqlFieldType {
  const MySqlFieldType({
    required this.name,
    required this.code,
  });

  final String name;

  @Reference(kind: ReferenceKind.kEnumerationPrimaryKey)
  final int code;

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kDecimal = MySqlFieldType(
    name: "MYSQL_TYPE_DECIMAL",
    code: 0,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kTiny = MySqlFieldType(
    name: "MYSQL_TYPE_TINY",
    code: 1,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kShort = MySqlFieldType(
    name: "MYSQL_TYPE_SHORT",
    code: 2,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kLong = MySqlFieldType(
    name: "MYSQL_TYPE_LONG",
    code: 3,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kFloat = MySqlFieldType(
    name: "MYSQL_TYPE_FLOAT",
    code: 4,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kDouble = MySqlFieldType(
    name: "MYSQL_TYPE_DOUBLE",
    code: 5,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kNull = MySqlFieldType(
    name: "MYSQL_TYPE_NULL",
    code: 6,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kTimestamp = MySqlFieldType(
    name: "MYSQL_TYPE_TIMESTAMP",
    code: 7,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kLongLong = MySqlFieldType(
    name: "MYSQL_TYPE_LONGLONG",
    code: 8,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kInt24 = MySqlFieldType(
    name: "MYSQL_TYPE_INT24",
    code: 9,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kDate = MySqlFieldType(
    name: "MYSQL_TYPE_DATE",
    code: 10,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kTime = MySqlFieldType(
    name: "MYSQL_TYPE_TIME",
    code: 11,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kDateTime = MySqlFieldType(
    name: "MYSQL_TYPE_DATETIME",
    code: 12,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kYear = MySqlFieldType(
    name: "MYSQL_TYPE_YEAR",
    code: 13,
  );

  /// Internal to MySQL. Not used in protocol.
  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kNewDate = MySqlFieldType(
    name: "MYSQL_TYPE_NEWDATE",
    code: 14,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kVarChar = MySqlFieldType(
    name: "MYSQL_TYPE_VARCHAR",
    code: 15,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kBit = MySqlFieldType(
    name: "MYSQL_TYPE_BIT",
    code: 16,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kTimestamp2 = MySqlFieldType(
    name: "MYSQL_TYPE_TIMESTAMP2",
    code: 17,
  );

  /// Internal to MySQL. Not used in protocol.
  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kDateTime2 = MySqlFieldType(
    name: "MYSQL_TYPE_DATETIME2",
    code: 18,
  );

  /// Internal to MySQL. Not used in protocol.
  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kTime2 = MySqlFieldType(
    name: "MYSQL_TYPE_TIME2",
    code: 19,
  );

  /// Used for replication only.
  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kTypedArray = MySqlFieldType(
    name: "MYSQL_TYPE_TYPED_ARRAY",
    code: 20,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kInvalid = MySqlFieldType(
    name: "MYSQL_TYPE_INVALID",
    code: 243,
  );

  /// Currently just a placeholder.
  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kBool = MySqlFieldType(
    name: "MYSQL_TYPE_BOOL",
    code: 244,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kJson = MySqlFieldType(
    name: "MYSQL_TYPE_JSON",
    code: 245,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kNewDecimal = MySqlFieldType(
    name: "MYSQL_TYPE_NEWDECIMAL",
    code: 246,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kEnum = MySqlFieldType(
    name: "MYSQL_TYPE_ENUM",
    code: 247,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kSet = MySqlFieldType(
    name: "MYSQL_TYPE_SET",
    code: 248,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kTinyBlob = MySqlFieldType(
    name: "MYSQL_TYPE_TINY_BLOB",
    code: 249,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kMediumBlob = MySqlFieldType(
    name: "MYSQL_TYPE_MEDIUM_BLOB",
    code: 250,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kLongBlob = MySqlFieldType(
    name: "MYSQL_TYPE_LONG_BLOB",
    code: 251,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kBlob = MySqlFieldType(
    name: "MYSQL_TYPE_BLOB",
    code: 252,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kVarString = MySqlFieldType(
    name: "MYSQL_TYPE_VAR_STRING",
    code: 253,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kString = MySqlFieldType(
    name: "MYSQL_TYPE_STRING",
    code: 254,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kGeometry = MySqlFieldType(
    name: "MYSQL_TYPE_GEOMETRY",
    code: 255,
  );
}
