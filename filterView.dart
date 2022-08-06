import 'dart:convert';
import 'dart:io';

main() {
  File formatted = File('assets/routes.json');
  Map routes = jsonDecode(formatted.readAsStringSync());
  List<Map> filteredRoutes = [];
  List<String> shouldContain = ['quaidabad'];
  routes.forEach((bus, stopList) {
    int matches = 0;
    stopList.forEach((stop) {
      if (shouldContain.contains(stop.toLowerCase())) {
        matches++;
      }
    });
    if (matches == shouldContain.length) {
      filteredRoutes.add({bus: stopList});
    }
  });
  if (shouldContain.length > 1)
    for (int i = 0; i < filteredRoutes.length; i++) {
      List stopList = filteredRoutes[i].values.first;
      String key = filteredRoutes[i].keys.first;
      int i1 =
          stopList.indexWhere((stop) => stop.toLowerCase() == shouldContain[0]);
      int i2 =
          stopList.indexWhere((stop) => stop.toLowerCase() == shouldContain[1]);
      if (i1 > i2) {
        filteredRoutes[i][key] =
            (filteredRoutes[i][key] as List).reversed.toList();
      }
    }
  File('assets/filterView.json').writeAsStringSync(jsonEncode(filteredRoutes));
}
