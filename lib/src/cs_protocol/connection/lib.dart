library mysql_protocol.cs_protocol.connection;

import 'dart:typed_data';

import 'package:mysql_protocol/_internal/codegen/annotations.dart';
import 'package:mysql_protocol/_internal/codegen/serialization.dart';

part '_connection_phase/_ssl.dart';
part '_connection_phase/_handshake.dart';
part '_connection_phase/_auth.dart';

part '_command_phase/_text.dart';
part '_command_phase/_utility.dart';
part '_command_phase/_prepared_stmt.dart';
part '_command_phase/_stored_program.dart';
