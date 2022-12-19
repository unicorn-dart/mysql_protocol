import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:mysql_protocol/src/cs/lib.dart';

void main() {
  group("Packet", () {
    group("serialization", () {
      test("should pass the case that mentioned in official documentation", () {
        const expected = [
          //
          0x2e, 0x00, 0x00, 0x00, 0x03, 0x73, 0x65, 0x6c,
          //
          0x65, 0x63, 0x74, 0x20, 0x22, 0x30, 0x31, 0x32,
          //
          0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x30,
          //
          0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
          //
          0x39, 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36,
          //
          0x37, 0x38, 0x39, 0x30, 0x31, 0x32, 0x33, 0x34,
          //
          0x35, 0x22
        ];

        final packet = Packet(
          sequenceId: 0,
          payload: Uint8List.fromList([
            // command byte
            0x03,
            ...'select "012345678901234567890123456789012345"'.codeUnits
          ]),
        );

        expect(packet.toBinary(), equals(expected));
      });
    });
  });

  group("CompressedPacket", () {
    group("serialization", () {
      test("should pass the case that was mentioned in official documentation",
          () {
        const expected = [
          //
          0x22, 0x00, 0x00, 0x00, 0x32, 0x00, 0x00, 0x78,
          //
          0x9c, 0xd3, 0x63, 0x60, 0x60, 0x60, 0x2e, 0x4e,
          //
          0xcd, 0x49, 0x4d, 0x2e, 0x51, 0x50, 0x32, 0x30,
          //
          0x34, 0x32, 0x36, 0x31, 0x35, 0x33, 0xb7, 0xb0,
          //
          0xc4, 0xcd, 0x52, 0x02, 0x00, 0x0c, 0xd1, 0x0a,
          //
          0x6c
        ];

        final packet = CompressedPacket(
          sequenceId: 0x00,
          packets: [
            Packet(
              sequenceId: 0,
              payload: Uint8List.fromList([
                // command byte
                0x03,
                ...'select "012345678901234567890123456789012345"'.codeUnits
              ]),
            )
          ],
        );

        expect(packet.toBinary(), equals(expected));
      });
    });
  });

  group("UncompressedPacket", () {
    group("serialization", () {
      test("should pass the case that was mentioned in official documentation",
          () {
        const expected = [
          //
          0x0d, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09,
          //
          0x00, 0x00, 0x00, 0x03, 0x53, 0x45, 0x4c, 0x45,
          //
          0x43, 0x54, 0x20, 0x31,
        ];

        final packet = UncompressedPacket(
          sequenceId: 0x00,
          packets: [
            Packet(
              sequenceId: 0,
              payload: Uint8List.fromList([
                // command byte
                0x03,
                ...'SELECT 1'.codeUnits
              ]),
            )
          ],
        );

        expect(packet.toBinary(), equals(expected));
      });
    });
  });
}
