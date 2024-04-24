part of 'prediction_bloc.dart';

@immutable
abstract class PredictionState {}

class PredictionInitial extends PredictionState {}

class LoadedAllPredictionState extends PredictionState {
  final List<PredictionModel> predictions;

  LoadedAllPredictionState({required this.predictions});
}

class EmptyPredictionListState extends PredictionState {}