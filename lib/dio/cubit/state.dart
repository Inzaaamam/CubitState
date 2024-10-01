import 'package:equatable/equatable.dart';

class DioState extends Equatable {
  final bool loading;
  final String? message;
  final List list;
  const DioState({this.loading = false, this.message, this.list = const []});
  DioState copyWith({bool? loading, String? message, List? list}) {
    return DioState(
        loading: loading ?? this.loading,
        message: message ?? this.message,
        list: list ?? this.list);
  }

  @override
  List<Object?> get props => [loading, message, list];
}
