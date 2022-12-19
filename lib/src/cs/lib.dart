library mysql_protocol.cs;

/// For more details, see [Protocol][protocol_basic_packet]
///
/// [protocol_basic_packet]: https://dev.mysql.com/doc/dev/mysql-server/latest/page_protocol_basic_packets.html
///

import 'dart:io';
import 'dart:typed_data';

import 'package:mysql_protocol/src/serialization/lib.dart';

part '_data_types.dart';
part '_packet.dart';
part '_compression.dart';

part '_builder.dart';
