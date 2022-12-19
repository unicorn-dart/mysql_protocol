part of 'lib.dart';

class Packet implements SerializableObject {
  const Packet({
    required int sequenceId,
    required Uint8List payload,
  })  : _sequenceId = sequenceId,
        _payload = payload;

  final int _sequenceId;

  int get sequenceId => _sequenceId;

  final Uint8List _payload;

  Uint8List get payload => UnmodifiableUint8ListView(_payload);

  int get length => _calculatePacketLength();

  @override
  Uint8List toBinary() {
    final buffer = BytesBuilder();

    // int<3> for payload length
    buffer.add(FixedLengthInteger.int3(payload.length).toBinary());

    // int<1> for sequence ID
    buffer.add(FixedLengthInteger.int1(sequenceId).toBinary());

    buffer.add(payload);

    return buffer.toBytes();
  }

  int _calculatePacketLength() {
    // Packet header taken 4 bytes.
    return 4 + payload.length;
  }
}
