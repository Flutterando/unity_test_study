// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unity_test_study/bloc_provider.dart';
import 'package:unity_test_study/home_page.dart';

import 'package:unity_test_study/main.dart';
import 'package:unity_test_study/person.dart';
import 'package:unity_test_study/person_bloc.dart';
import 'package:unity_test_study/person_repository.dart';

class PersonRepositoryMock extends Mock implements PersonRepository {}

void main() {
  final repository = PersonRepositoryMock();
  final bloc = PersonBloc(repository);

  final person = Person(id: 1, name: 'Jacob', age: 29, height: 1.77, weight: 64.4);
  testWidgets('Deve mostrar todos os estados na tela', (WidgetTester tester) async {
    when(repository).calls(#getPerson).thenAnswer((_) async => <Person>[person, person]);

    await tester.pumpWidget(MaterialApp(home: BlocProvider(bloc: bloc, child: HomePage())));

    final textButton = find.byType(TextButton);
    expect(textButton, findsOneWidget);
    final loading = find.byType(CircularProgressIndicator);
    expect(loading, findsNothing);
    final listPersons = find.byType(ListView);
    expect(listPersons, findsNothing);

    await tester.tap(textButton);

    await tester.runAsync(() => bloc.first);
    await tester.pump();
    expect(loading, findsOneWidget);

    await tester.runAsync(() => bloc.first);
    await tester.pump();
    expect(listPersons, findsOneWidget);
  });
}
