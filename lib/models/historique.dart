import 'position.dart';

class Historique {
  final int duree;
  final String distance;
  final DateTime date;
  final Positions source;
  final Positions destination;
  final String engin;

  Historique(
      {required this.engin,
      required this.duree,
      required this.distance,
      required this.date,
      required this.source,
      required this.destination});

  Historique.fromJson(Map<String, Object?> json)
      : this(
          engin: json['engin'].toString(),
          duree: int.parse(json['duree'].toString()),
          distance: json['distance'].toString(),
          date: DateTime.parse(json['date'].toString()),
          source: Positions.fromJson(json['source'] as Map<String, Object?>),
          destination:
              Positions.fromJson(json['destination'] as Map<String, Object?>),
        );

  Map<String, Object?> toJson() {
    return {
      'duree': duree,
      'distance': distance,
      'date': date.toString(),
      'source': source.toJson(),
      'destination': destination.toJson(),
      'engin': engin
    };
  }
}
