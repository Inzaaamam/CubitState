import 'package:cubit/dio/cubit/cubit.dart';
import 'package:cubit/dio/cubit/state.dart';
import 'package:cubit/dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DioScreen extends StatelessWidget {
  const DioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DioCubit(service: Services())..get(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await context.read<DioCubit>().service.getData();
            await context.read<DioCubit>().addOffline();
          },
          child: const Icon(Icons.save),
        ),
        appBar: AppBar(title: const Text('Data List')),
        body: BlocBuilder<DioCubit, DioState>(
          builder: (context, state) {
            if (state.loading && state.list.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.message != null) {
              return Center(child: Text(state.message!));
            } else if (state.list.isEmpty) {
              return const Center(child: Text('No data available.'));
            } else {
              return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent &&
                      !state.loading) {}
                  return false;
                },
                child: ListView.builder(
                  itemCount: state.list.length + (state.loading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == state.list.length) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      final item = state.list[index];
                      return ListTile(
                        title: Text(item['title'] ?? 'No Title'),
                        subtitle: Text('ID: ${item['id']}'),
                      );
                    }
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
