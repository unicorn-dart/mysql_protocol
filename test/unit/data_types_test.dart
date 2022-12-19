import 'package:test/test.dart';
import 'package:mysql_protocol/src/cs/lib.dart';

void main() {
  group("FixedLengthInteger", () {
    group("serialization", () {
      group("given a signed integer that below the bytes length", () {
        test(
          "should be serialized",
          () {
            expect(
              FixedLengthInteger.int1(0x00).toBinary(),
              equals([0x00]),
            );
            expect(
              FixedLengthInteger.int1(0xff).toBinary(),
              equals([0xff]),
            );
            expect(
              FixedLengthInteger.int2(0xf1f2).toBinary(),
              equals([0xf2, 0xf1]),
            );
            expect(
              FixedLengthInteger.int3(0xf1f2f3).toBinary(),
              equals([0xf3, 0xf2, 0xf1]),
            );
            expect(
              FixedLengthInteger.int4(0xf1f2f3f4).toBinary(),
              equals([0xf4, 0xf3, 0xf2, 0xf1]),
            );
            expect(
              FixedLengthInteger.int6(0xf1f2f3f4f5f6).toBinary(),
              equals([0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1]),
            );
            expect(
              FixedLengthInteger.int8(0xf1f2f3f4f5f6f7f8).toBinary(),
              equals([0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1]),
            );
          },
        );
      });

      group("given a signed integer that over the byte length", () {
        test(
          "should truncate and be serialized",
          () {
            expect(
              FixedLengthInteger.int1(0xa01).toBinary(),
              equals([0x01]),
            );
            expect(
              FixedLengthInteger.int2(0xaf1f2).toBinary(),
              equals([0xf2, 0xf1]),
            );
            expect(
              FixedLengthInteger.int3(0xaf1f2f3).toBinary(),
              equals([0xf3, 0xf2, 0xf1]),
            );
            expect(
              FixedLengthInteger.int4(0xaf1f2f3f4).toBinary(),
              equals([0xf4, 0xf3, 0xf2, 0xf1]),
            );
            expect(
              FixedLengthInteger.int6(0xaf1f2f3f4f5f6).toBinary(),
              equals([0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1]),
            );
          },
        );
      });
    });
  });
}
