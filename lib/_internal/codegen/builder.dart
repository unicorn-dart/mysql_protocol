import 'package:build/build.dart';
import 'package:mysql_protocol/_internal/codegen/generators/protocol_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder generateProtocol() => LibraryBuilder(ProtocolGenerator());
