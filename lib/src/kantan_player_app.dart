import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/features/settings/data/settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kantan_player_app.g.dart';

class KantanPlayerApp extends StatelessWidget {
  const KantanPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const _EagerInitializer(
      child: MaterialApp(
        home: Scaffold(
          body: TestHome(),
        ),
      ),
    );
  }
}

class TestHome extends ConsumerWidget {
  const TestHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

@riverpod
FutureOr<void> appStartup(AppStartupRef ref) async {
  ref.onDispose(() {
    ref.invalidate(settingsRepositoryProvider);
  });
  await ref.watch(settingsRepositoryProvider.future);
}

class _EagerInitializer extends ConsumerWidget {
  const _EagerInitializer({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartupState = ref.watch(appStartupProvider);
    return appStartupState.when(
      loading: () => const AppStartupLoading(),
      error: (e, st) => AppStartupError(
        error: e,
        stackTrace: st,
      ),
      data: (_) => child,
    );
  }
}

class AppStartupLoading extends StatelessWidget {
  const AppStartupLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator.adaptive();
  }
}

class AppStartupError extends StatelessWidget {
  const AppStartupError({
    required this.error,
    required this.stackTrace,
    super.key,
  });
  final Object error;
  final StackTrace stackTrace;

  @override
  Widget build(BuildContext context) {
    // TODO: Show error text.
    // TODO: Retry logic:
    // https://codewithandrea.com/articles/robust-app-initialization-riverpod/#how-to-implement-the-retry-logic?
    return const Placeholder();
  }
}
