import 'package:equatable/equatable.dart';

class PricePoint extends Equatable {
  const PricePoint({required this.timestamp, required this.price});

  factory PricePoint.fromJson(List<dynamic> json) {
    return PricePoint(
      timestamp: DateTime.fromMillisecondsSinceEpoch((json[0] as num).toInt()),
      price: (json[1] as num).toDouble(),
    );
  }

  final DateTime timestamp;
  final double price;

  @override
  List<Object?> get props => [timestamp, price];
}
