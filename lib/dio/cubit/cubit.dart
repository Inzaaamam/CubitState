import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cubit/db/appDB/dao.dart';
import 'package:cubit/db/table/table.dart';
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
      final data = await service.getData();
      emit(state.copyWith(loading: false, list: data));
    } catch (e) {
      emit(state.copyWith(loading: false, message: e.toString()));
    }
  }

  Future<void> addOffline() async {
    try {
      // Fetch data from the service; it should return a List<dynamic>
      final response = await service.getData();

      // Check if response is a list
      if (response is List) {
        for (var element in response) {
          // Assuming each element is a map and has 'id' and other fields
          final data = OfflineTable.create(
            id: element.id, // Make sure id is a string
            isSynced: '0', // Mark as unsynced initially
            serverData: jsonEncode(
                element), // Convert the entire element to JSON string
          ).toJson();

          // Call your DAO to insert the data
          await OfflineDao.get().addOfflineData(data);
        }
      } else {
        throw Exception("Expected a list but received something else");
      }
    } catch (e) {
      throw Exception("Error adding offline data: $e");
    }
  }

  // Fetch more data for pagination
  // Future<void> getMoreData() async {
  //   if (!state.loading) {
  //     emit(state.copyWith(loading: true));
  //     try {
  //       start += limit; // Increment the start value for pagination
  //       final nextData = await service.getData(start: start, limit: limit);
  //       if (nextData.isNotEmpty) {
  //         emit(state.copyWith(
  //           loading: false,
  //           list: List.from(state.list)..addAll(nextData),
  //         ));
  //       } else {
  //         emit(state.copyWith(loading: false));
  //       }
  //     } catch (e) {
  //       emit(state.copyWith(loading: false, message: e.toString()));
  //     }
  //   }
  // }
}
