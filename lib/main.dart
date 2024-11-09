import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/common_widgets/error_message_widget.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:kantan/src/features/settings/data/settings_repository.dart';
import 'package:kantan/src/kantan_player_app.dart';
import 'package:kantan/src/localization/string_hardcoded.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main.g.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: KantanPlayerApp(),
    ),
  );
}

class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartupState = ref.watch(appStartupProvider);
    return appStartupState.when(
      loading: () => const AppStartupLoadingWidget(),
      error: (e, st) => ErrorMessageWidget(e.toString()),
      data: (_) => const KantanPlayerApp(),
    );
  }
}

class AppStartupLoadingWidget extends StatelessWidget {
  const AppStartupLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}

class AppStartupErrorWidget extends StatelessWidget {
  const AppStartupErrorWidget({
    super.key,
    required this.errorMessage,
    required this.retry,
  });

  final String errorMessage;
  final VoidCallback retry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ErrorMessageWidget(errorMessage),
          FilledButton.tonal(
            onPressed: retry,
            child: Text('Retry'.hardcoded),
          ),
        ],
      ),
    );
  }
}

@Riverpod(keepAlive: true)
Future<void> appStartup(Ref ref) async {
  ref.onDispose(() {
    ref.invalidate(settingsRepositoryProvider);
    ref.invalidate(audioHandlerProvider);
  });
  await ref.watch(settingsRepositoryProvider.future);
  await ref.watch(audioHandlerProvider.future);
}
