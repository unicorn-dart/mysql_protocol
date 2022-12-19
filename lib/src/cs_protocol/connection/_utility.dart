part of 'lib.dart';

/// For more details, visit [Text Protocol][text_protocol].
///
/// [text_protocol]: https://dev.mysql.com/doc/dev/mysql-server/latest/page_protocol_command_phase_text.html
///

@Packet()
@Serialized(name: "COM_QUIT")
abstract class QuitCommand {}

@Packet()
@Serialized(name: "COM_INIT_DB")
abstract class InitDbCommand {}

@Packet()
@Serialized(name: "COM_FIELD_LIST")
abstract class FieldListCommand {}

@Packet()
@Serialized(name: "COM_REFRESH")
abstract class RefreshCommand {}

@Packet()
@Serialized(name: "COM_STATISTICS")
abstract class StatisticsCommand {}

@Packet()
@Serialized(name: "COM_PROCESS_INFO")
abstract class ProcessInfoCommand {}

@Packet()
@Serialized(name: "COM_PROCESS_KILL")
abstract class ProcessKillCommand {}

@Packet()
@Serialized(name: "COM_DEBUG")
abstract class DebugCommand {}

@Packet()
@Serialized(name: "COM_PING")
abstract class PingCommand {}

@Packet()
@Serialized(name: "COM_CHANGE_USER")
abstract class ChangeUserCommand {}

@Packet()
@Serialized(name: "COM_RESET_CONNECTION")
abstract class ResetConnectionCommand {}

@Packet()
@Serialized(name: "COM_SET_OPTION")
abstract class SetOptionCommand {}
