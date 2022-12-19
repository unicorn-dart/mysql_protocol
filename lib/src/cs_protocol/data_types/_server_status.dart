part of 'lib.dart';

@Reference(kind: ReferenceKind.kEnumeration)
class ServerStatus {
  const ServerStatus({
    required this.name,
    required this.code,
  });

  @Field()
  final String name;

  @Field()
  @Reference(kind: ReferenceKind.kEnumerationPrimaryKey)
  final int code;

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kServerStatusInTrans = ServerStatus(
    name: "SERVER_STATUS_IN_TRANS",
    code: 0x00000001,
  );

  @Reference(kind: ReferenceKind.kEnumerationItem)
  static const kServerStatusAutoCommit = ServerStatus(
    name: "SERVER_STATUS_AUTOCOMMIT",
    code: 0x00000002,
  );
}
