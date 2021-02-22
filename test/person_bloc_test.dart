import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unity_test_study/person.dart';
import 'package:unity_test_study/person_bloc.dart';
import 'package:unity_test_study/person_repository.dart';
import 'package:unity_test_study/person_state.dart';

class PersonRepositoryMock extends Mock implements PersonRepository {}

void main() {
  final repository = PersonRepositoryMock();
  final bloc = PersonBloc(repository);
  final person = Person(id: 1, name: 'Jacob', age: 29, height: 1.77, weight: 64.4);

  test('deve retorna uma lista de person', () async {
    when(repository).calls(#getPerson).thenAnswer((_) async => <Person>[person, person]);

    bloc.add(PersonEvent.fetch);

    await expectLater(
        bloc,
        emitsInOrder([
          isA<PersonLoadingState>(),
          isA<PersonListState>(),
        ]));
  });

  test('deve disparar um error', () async {
    when(repository).calls(#getPerson).thenThrow(Exception('deu error'));

    bloc.add(PersonEvent.fetch);

    await expectLater(
        bloc,
        emitsInOrder([
          isA<PersonLoadingState>(),
          isA<PersonErrorState>(),
        ]));
  });
}
