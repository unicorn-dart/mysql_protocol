part of 'lib.dart';

class FixedLengthInteger implements SerializableObject {
  const FixedLengthInteger._internal({
    required int value,
    required int byteWidth,
  })  : _value = value,
        _byteWidth = byteWidth;

  const FixedLengthInteger.int1(int value)
      : this._internal(
          value: value,
          byteWidth: 1,
        );

  const FixedLengthInteger.int2(int value)
      : this._internal(
          value: value,
          byteWidth: 2,
        );

  const FixedLengthInteger.int3(int value)
      : this._internal(
          value: value,
          byteWidth: 3,
        );

  const FixedLengthInteger.int4(int value)
      : this._internal(
          value: value,
          byteWidth: 4,
        );

  const FixedLengthInteger.int6(int value)
      : this._internal(
          value: value,
          byteWidth: 6,
        );

  const FixedLengthInteger.int8(int value)
      : this._internal(
          value: value,
          byteWidth: 8,
        );

  final int _byteWidth;

  final int _value;

  int get value => _value;

  @override
  Uint8List toBinary() {
    final buffer = BytesBuilder(copy: false);
    for (var i = 0; i < _byteWidth; i++) {
      var shift = i * 8;
      buffer.addByte((_value >> shift) & 0xff);
    }
    return buffer.toBytes();
  }
}
