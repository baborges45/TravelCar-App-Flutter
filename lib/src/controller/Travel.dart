import 'package:rotas_cars/src/model/Position.dart';

class Travel {
  final Position initial;
  final Position end;

  @override
  String toString() {
    var travel =
        "Endereço Inicial: ${initial.id} => ${initial.address} => Com KM: ${initial.hodometro}";

    if (end != null) {
      travel =
          "$travel até o Endereço Final: ${end.id} => ${end.address} => Com KM: ${end.hodometro}";
    }
    return travel;
  }

  Travel(this.initial, this.end);
}
