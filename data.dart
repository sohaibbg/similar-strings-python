import 'dart:convert';
import 'dart:io';

main() {
  File formatted = File('assets/routes.json');
  Map routes = jsonDecode(formatted.readAsStringSync());
  List stops = [];
  routes.forEach((bus, stopList) {
    stopList.forEach((stop) => stops.add(stop));
  });
  stops.sort();
  File stopList = File('assets/stopList.json');
  stopList.writeAsStringSync(jsonEncode(stops.toSet().toList()));
}
