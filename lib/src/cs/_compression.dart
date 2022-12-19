part of 'lib.dart';

class CompressedPacket implements SerializableObject {
  CompressedPacket({
    required int sequenceId,
    required Iterable<Packet> packets,
  })  : _sequenceId = sequenceId,
        _packets = packets;

  final int _sequenceId;

  int get sequenceId => _sequenceId;

  final Iterable<Packet> _packets;

  Iterable<Packet> get packets => _packets;

  Uint8List get rawPayload => Uint8List.fromList([
        ..._packets
            .map((packet) => packet.toBinary())
            .expand((buffer) => buffer)
      ]);

  Uint8List? _compressedPayloadCache;

  Uint8List get compressedPayload =>
      UnmodifiableUint8ListView(_compressOrGetPayload());

  int get length => _calculatePacketLength();

  @override
  Uint8List toBinary() {
    final buffer = BytesBuilder();

    // int<3> for compressed payload length
    buffer.add(FixedLengthInteger.int3(compressedPayload.length).toBinary());

    // int<1> for sequence ID
    buffer.add(FixedLengthInteger.int1(sequenceId).toBinary());

    // int<3> for raw payload length
    buffer.add(FixedLengthInteger.int3(rawPayload.length).toBinary());

    // followed by compressed payload
    buffer.add(compressedPayload);

    return buffer.toBytes();
  }

  Uint8List _compressOrGetPayload() {
    // ignore: prefer_conditional_assignment
    if (_compressedPayloadCache == null) {
      final codec = ZLibCodec();
      _compressedPayloadCache = Uint8List.fromList(codec.encode(rawPayload));
    }

    return _compressedPayloadCache!;
  }

  int _calculatePacketLength() {
    // Packet header taken 7 bytes.
    return 7 + compressedPayload.length;
  }
}

class UncompressedPacket implements SerializableObject {
  const UncompressedPacket({
    required int sequenceId,
    required Iterable<Packet> packets,
  })  : _sequenceId = sequenceId,
        _packets = packets;

  final int _sequenceId;

  int get sequenceId => _sequenceId;

  final Iterable<Packet> _packets;

  Uint8List get payload => Uint8List.fromList([
        ..._packets
            .map((packet) => packet.toBinary())
            .expand((buffer) => buffer)
      ]);

  int get length => _calculatePacketLength();

  @override
  Uint8List toBinary() {
    final buffer = BytesBuilder();

    // int<3> for raw payload length
    buffer.add(FixedLengthInteger.int3(payload.length).toBinary());

    // int<1> for sequence ID
    buffer.add(FixedLengthInteger.int1(sequenceId).toBinary());

    // int<3> for constant value 0x000000 to indicate an
    //   uncompressed packet.
    buffer.add(FixedLengthInteger.int3(0x000000).toBinary());

    // followed by compressed payload
    buffer.add(payload);

    return buffer.toBytes();
  }

  int _calculatePacketLength() {
    // Packet header taken 7 bytes.
    return 7 + payload.length;
  }
}
