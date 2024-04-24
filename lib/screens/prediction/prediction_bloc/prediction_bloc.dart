import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mcluck_app/models/prediction_model.dart';
import 'package:meta/meta.dart';

part 'prediction_event.dart';
part 'prediction_state.dart';

class PredictionBloc extends Bloc<PredictionEvent, PredictionState> {
  PredictionBloc() : super(PredictionInitial()) {
    on<GetAllPredictionEvent>(_GetAllPredictionHandler);
    on<AddPredictionEvent>(_addPredictionHandler);
  }

  void _GetAllPredictionHandler(
      GetAllPredictionEvent event, Emitter<PredictionState> emit) async {
    List<PredictionModel> predictions = [];

    final predictionBox = Hive.box('predictions');

    if (predictionBox.isNotEmpty) {
      for (int i = 0; i < predictionBox.length; i++) {
        predictions.add(predictionBox.getAt(i));
      }

      emit(LoadedAllPredictionState(
          predictions: predictions.reversed.toList()));
    } else {
      emit(EmptyPredictionListState());
    }
  }

  void _addPredictionHandler(
      AddPredictionEvent event, Emitter<PredictionState> emit) async {
    final predictionBox = Hive.box('predictions');
    predictionBox.add(event.prediction);
  }
}
