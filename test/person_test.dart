import 'package:flutter_test/flutter_test.dart';
import 'package:unity_test_study/person.dart';

void main() {
  final person = Person(id: 1, name: 'Jacob', age: 29, height: 1.77, weight: 64.4);

  test('Imc deve vir 20.56', () {
    expect(person.imc, 20.56);
  });

  group('isOlder | ', () {
    test('Se a idade for maior que 18, entao isOlder deve ser true', () {
      expect(person.isOlder, true);
    });

    test('Se a idade for igual a 18, entao isOlder deve ser true', () {
      final person = Person(id: 1, name: 'Jacob', age: 18, height: 1.77, weight: 64.4);
      expect(person.isOlder, true);
    });
  });
}
