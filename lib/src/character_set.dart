import 'dart:typed_data';

import 'package:mysql_protocol/src/serialization/lib.dart';

///
/// Useful resources can be found in:
///
/// * [mysql-server/strings]: https://github.com/mysql/mysql-server/tree/8.0/strings
/// * [mysql-server/mysys/charset-def.cc]: https://github.com/mysql/mysql-server/blob/8.0/mysys/charset-def.cc

class CharacterSet implements SerializableObject {
  const CharacterSet({
    required this.number,
    required this.collationName,
  });

  final int number;

  final String collationName;

  @override
  Uint8List toBinary() {
    throw UnimplementedError();
  }
}

class CharacterSets {
  const CharacterSets._static();

  /// See [strings/ctype-latin1.cc](https://github.com/mysql/mysql-server/blob/8.0/strings/ctype-latin1.cc)
  static const kLatin1SwedishCaseIntensive = CharacterSet(
    number: 8,
    collationName: "latin1_swedish_ci",
  );
}
