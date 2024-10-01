import 'package:bloc/bloc.dart';
import 'package:cubit/dio/cubit/state.dart';
import 'package:cubit/dio/dio.dart';

class DioCubit extends Cubit<DioState> {
  final Services service;
  int start = 0;
  final int limit = 10;

  DioCubit({required this.service}) : super(const DioState());
  Future<void> get() async {
    emit(state.copyWith(loading: true));
    try {
      final data = await service.getData(start: start, limit: limit);
      emit(state.copyWith(loading: false, list: data));
    } catch (e) {
      emit(state.copyWith(loading: false, message: e.toString()));
    }
  }

  // Fetch more data for pagination
  Future<void> getMoreData() async {
    if (!state.loading) {
      emit(state.copyWith(loading: true));
      try {
        start += limit; // Increment the start value for pagination
        final nextData = await service.getData(start: start, limit: limit);
        if (nextData.isNotEmpty) {
          emit(state.copyWith(
            loading: false,
            list: List.from(state.list)..addAll(nextData),
          ));
        } else {
          emit(state.copyWith(loading: false));
        }
      } catch (e) {
        emit(state.copyWith(loading: false, message: e.toString()));
      }
    }
  }
}
