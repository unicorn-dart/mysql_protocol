library mysql_protocol.serialization;

import 'dart:typed_data';

abstract class SerializableObject {
  Uint8List toBinary();
}
