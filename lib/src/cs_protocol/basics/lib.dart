library mysql_protocol.cs_protocol.basics;

/// For more details, visit [Protocol Basics][protocol_basics].
///
/// [protocol_basics]: https://dev.mysql.com/doc/dev/mysql-server/latest/page_protocol_basics.html

import 'dart:io';
import 'dart:typed_data';

import 'package:mysql_protocol/_internal/codegen/annotations.dart';
import 'package:mysql_protocol/_internal/codegen/serialization.dart';

import 'package:mysql_protocol/src/serialization/lib.dart';
import 'package:mysql_protocol/src/cs_protocol/data_types/lib.dart';

part '_data_types.dart';
part '_mysql_packets.dart';
part '_generic_response.dart';
part '_compression.dart';

part '_builder.dart';
