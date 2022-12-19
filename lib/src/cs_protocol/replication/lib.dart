/// For more details, visit [Replication Protocol][replication_protocol].
///
/// [replication_protocol]: https://dev.mysql.com/doc/dev/mysql-server/latest/page_protocol_replication.html
///
library mysql_protocol.cs_protocol.replication;

import 'package:equatable/equatable.dart';
import 'package:mysql_protocol/_internal/codegen/annotations.dart';
import 'package:mysql_protocol/_internal/codegen/serialization.dart';
import 'package:mysql_protocol/src/utils/bitmask.dart';
import 'package:version/version.dart';

part '_binlog.dart';
