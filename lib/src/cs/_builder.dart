part of 'lib.dart';

class PacketBuilder {
  PacketBuilder();

  // ignore: prefer_final_field
  int? _sequenceId;

  // ignore: prefer_final_field
  Uint8List? _payload;

  void withSequenceId(int sequenceId) {
    _sequenceId = sequenceId;
  }

  void withPayload(Uint8List payload) {
    _payload = payload;
  }

  void withPayloadAsString(String payload) {
    _payload = Uint8List.fromList(payload.codeUnits);
  }

  Packet build() {
    // ignore: prefer_conditional_assignment
    if (_sequenceId == null) {
      _sequenceId = 0;
    }

    // ignore: prefer_conditional_assignment
    if (_payload == null) {
      _payload = Uint8List(0);
    }

    return Packet(
      sequenceId: _sequenceId!,
      payload: _payload!,
    );
  }
}

class CompressedPacketBuilder {
  CompressedPacketBuilder();

  // ignore: prefer_final_field
  int? _sequenceId;

  // ignore: prefer_final_fields
  List<Packet> _packets = [];

  void withSequenceId(int sequenceId) {
    _sequenceId = _sequenceId;
  }

  void addPacket(Packet packet) {
    _packets.add(packet);
  }

  void addPackets(Iterable<Packet> packets) {
    _packets.addAll(packets.toList());
  }

  CompressedPacket build() {
    // ignore: prefer_conditional_assignment
    if (_sequenceId == null) {
      _sequenceId = 0;
    }

    return CompressedPacket(
      sequenceId: _sequenceId!,
      packets: _packets,
    );
  }
}
