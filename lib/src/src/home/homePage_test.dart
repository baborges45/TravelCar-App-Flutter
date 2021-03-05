import 'package:rotas_cars/src/home/homePage.dart';

void main() {
  final repository = HomePage();

  test('Deve retornar uma lista de carros!', () async {
    final list = await repository.fetchCars();
    print(list[1].model);
  });
}

void test(String s, Future<Null> Function() param1) {}
