
import 'package:hive_flutter/hive_flutter.dart';

part 'prediction_model.g.dart';

@HiveType(typeId: 0)
class PredictionModel {
  @HiveField(0)
  final double prediction;
  @HiveField(1)
  final String message;

  PredictionModel({required this.prediction, required this.message});
}