import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/common_widgets/error_message_widget.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.data,
  });
  final AsyncValue<T> value;
  final Widget Function(T) data;

  @override
  Widget build(BuildContext context) {
    return value.when(
      loading: () {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
      error: (e, st) {
        return Center(
          child: ErrorMessageWidget(e.toString()),
        );
      },
      data: data,
    );
  }
}

class AsyncValueSliverWidget<T> extends StatelessWidget {
  const AsyncValueSliverWidget({
    super.key,
    required this.value,
    required this.data,
  });
  final AsyncValue<T> value;
  final Widget Function(T) data;

  @override
  Widget build(BuildContext context) {
    return value.when(
      loading: () {
        return const SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
      },
      error: (e, st) {
        return SliverToBoxAdapter(
          child: Center(
            child: ErrorMessageWidget(e.toString()),
          ),
        );
      },
      data: data,
    );
  }
}
