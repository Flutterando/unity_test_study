import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:unity_test_study/person_repository.dart';

class ClientMock extends Mock implements http.Client {}

void main() {
  final client = ClientMock();

  final repository = PersonRepository(client);
  test('deve pegar uma lista de person', () async {
    when(client).calls(#get).thenAnswer((_) async => http.Response(jsonReturn, 200));

    final list = await repository.getPerson();

    expect(list.isNotEmpty, equals(true));
    expect(list.first.name, equals('Xander Ledner'));
  });

  test('retorna uma exception se nao for statuCode 200', () async {
    when(client).calls(#get).thenAnswer((_) async => http.Response(jsonReturn, 404));
    expect(() async => await repository.getPerson(), throwsException);
  });
}

const jsonReturn = '[{"id":"1","name":"Xander Ledner","age":2800,"height":13575,"weight":40867},{"id":"2","name":"Leonel Harris","age":10877,"height":55959,"weight":32416},{"id":"3","name":"Eino Rolfson PhD","age":24477,"height":38433,"weight":9366},{"id":"4","name":"Cali Williamson V","age":29268,"height":72984,"weight":61804},{"id":"5","name":"Ted Emmerich","age":71359,"height":53924,"weight":20669},{"id":"6","name":"Melyna Pagac","age":34722,"height":99796,"weight":51223},{"id":"7","name":"Dedrick Schinner","age":29097,"height":23702,"weight":775},{"id":"8","name":"Natalia Hudson","age":10661,"height":78714,"weight":45},{"id":"9","name":"Joana Herzog","age":53291,"height":44442,"weight":7843},{"id":"10","name":"Brannon Jenkins IV","age":45538,"height":87152,"weight":57890},{"id":"11","name":"Roscoe Paucek","age":39212,"height":77701,"weight":17929},{"id":"12","name":"Mr. Marilie Pfannerstill","age":70718,"height":52449,"weight":58261},{"id":"13","name":"Lurline Windler","age":1453,"height":14427,"weight":56416},{"id":"14","name":"Liliane Stanton","age":50583,"height":50467,"weight":7399},{"id":"15","name":"Mckayla Rath","age":53251,"height":93896,"weight":33483},{"id":"16","name":"Mrs. Abe Harris","age":90993,"height":59813,"weight":28678},{"id":"17","name":"Nola Mayer","age":50997,"height":29853,"weight":5432},{"id":"18","name":"Luisa Graham","age":87727,"height":34799,"weight":8057},{"id":"19","name":"Karli Haley","age":53326,"height":22083,"weight":12729},{"id":"20","name":"Kelton Beier","age":20999,"height":85492,"weight":32510},{"id":"21","name":"Hobart Stracke","age":80967,"height":27969,"weight":37683},{"id":"22","name":"Breana Kertzmann","age":213,"height":35802,"weight":65287},{"id":"23","name":"Earnestine Rosenbaum","age":30776,"height":8761,"weight":87223},{"id":"24","name":"Charley Mayert","age":46564,"height":20757,"weight":34468},{"id":"25","name":"Bertrand Murazik V","age":72796,"height":18306,"weight":49049},{"id":"26","name":"Odie Smitham Sr.","age":54679,"height":74363,"weight":42802},{"id":"27","name":"Lillian McCullough","age":89414,"height":26467,"weight":75269},{"id":"28","name":"Alize Kemmer","age":75119,"height":39392,"weight":69793},{"id":"29","name":"Dr. Juanita Baumbach","age":65363,"height":25577,"weight":49551},{"id":"30","name":"Mario Becker","age":37688,"height":92161,"weight":42837},{"id":"31","name":"Kamron Runolfsdottir","age":27615,"height":12267,"weight":42356},{"id":"32","name":"Marshall Boehm","age":71371,"height":93972,"weight":48345},{"id":"33","name":"Justina Toy PhD","age":58862,"height":74208,"weight":94594}]';
