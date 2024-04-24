part of 'prediction_bloc.dart';

@immutable
abstract class PredictionEvent {}

class GetAllPredictionEvent extends PredictionEvent {}

class AddPredictionEvent extends PredictionEvent {
  final PredictionModel prediction;

  AddPredictionEvent({required this.prediction});
}

