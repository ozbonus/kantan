import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/config.dart';
import 'package:kantan/src/common_widgets/error_message_widget.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:kantan/src/features/settings/data/settings_repository.dart';
import 'package:kantan/src/features/track_list/data/tracks_repository.dart';
import 'package:kantan/src/kantan_player_app.dart';
import 'package:kantan/src/localization/string_hardcoded.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main.g.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: AppStartupWidget(
        child: KantanPlayerApp(),
      ),
    ),
  );
}

class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartupState = ref.watch(appStartupProvider);
    return appStartupState.when(
      loading: () {
        return const AppNotStartedScreen(
          body: AppStartupLoadingWidget(),
        );
      },
      error: (e, st) {
        return AppNotStartedScreen(
          body: AppStartupErrorWidget(
            errorMessage: e.toString(),
            retry: () => ref.invalidate(appStartupProvider),
          ),
        );
      },
      data: (_) {
        return child;
      },
    );
  }
}

class AppNotStartedScreen extends StatelessWidget {
  const AppNotStartedScreen({
    super.key,
    required this.body,
  });
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Config.appTitle,
      themeMode: ThemeMode.system,
      home: Scaffold(
        body: body,
      ),
    );
  }
}

class AppStartupLoadingWidget extends StatelessWidget {
  const AppStartupLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
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
    ref.invalidate(tracksListProvider);
    ref.invalidate(audioHandlerProvider);
  });
  ref
      .watch(settingsRepositoryProvider.future)
      .then((_) => ref.watch(tracksListProvider.future))
      .then((_) => ref.watch(audioHandlerProvider.future));
}
