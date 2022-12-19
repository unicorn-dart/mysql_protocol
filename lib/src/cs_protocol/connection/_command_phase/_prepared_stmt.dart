part of '../lib.dart';

/// For more details, visit [Prepared Statements][prepared_stmts].
///
/// [prepared_stmts]: https://dev.mysql.com/doc/dev/mysql-server/latest/page_protocol_command_phase_ps.html
///

@Packet()
@Serialized(name: "COM_STMT_PREPARE")
abstract class StmtPrepareCommand {}

@Packet()
@Serialized(name: "COM_STMT_EXECUTE")
abstract class StmtExecuteCommand {}

@Packet()
@Serialized(name: "COM_STMT_FETCH")
abstract class StmtFetchCommand {}

@Packet()
@Serialized(name: "COM_STMT_CLOSE")
abstract class StmtCloseCommand {}

@Packet()
@Serialized(name: "COM_STMT_RESET")
abstract class StmtResetCommand {}

@Packet()
@Serialized(name: "COM_STMT_SEND_LONG_DATA")
abstract class StmtSendLongDataCommand {}
