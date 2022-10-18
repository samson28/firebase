import 'historique.dart';

import 'lieu.dart';

class MyUser {
  late final String email;
  final List<Historique> historique;
  final List<Lieu> lieux;

  MyUser({required this.email, required this.historique, required this.lieux});

  MyUser.fromJson(Map<String, dynamic> json)
      : this(
          email: json['email'].toString(),
          lieux: retLieux(json),
          historique: retHistorique(json),
        );

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'historique': (historique.isEmpty)
          ? []
          : historique.map((e) => e.toJson()).toList(),
      'lieux': (lieux.isEmpty) ? [] : lieux.map((e) => e.toJson()).toList(),
    };
  }
}

List<Lieu> retLieux(Map<String, dynamic> parsedJson) {
  var list = parsedJson['lieux'] as List;
  List<Lieu> lieuxList = list.map((i) => Lieu.fromJson(i)).toList();
  return lieuxList;
}

List<Historique> retHistorique(Map<String, dynamic> parsedJson) {
  var list = parsedJson['historique'] as List;
  List<Historique> historiqueList =
      list.map((i) => Historique.fromJson(i)).toList();
  return historiqueList;
}
