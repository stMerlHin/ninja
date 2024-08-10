import 'package:flutter_test/flutter_test.dart';
import 'package:kunai/kunai.dart';

void main() {
  const String input = 'thisPassword';
  const String output = '4515c456ed6b3990664f61afbaeb8985';

  test('md5Hash', () {
    expect(md5Hash(input), equals(output));
  });
}
