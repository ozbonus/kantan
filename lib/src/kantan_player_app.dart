import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/config.dart';
import 'package:kantan/l10n/app_localizations.dart';
import 'package:kantan/src/features/player/presentation/player_screen.dart';
import 'package:kantan/src/features/settings/application/interface_locale_service.dart';
import 'package:kantan/src/features/settings/presentation/settings_menu.dart';
import 'package:kantan/src/features/track_list/presentation/track_list_screen.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_screen_contents.dart';
import 'package:kantan/src/routing/app_router.dart';
import 'package:kantan/src/themes/theme_extensions.dart';
import 'package:kantan/src/themes/theme_mode_service.dart';
import 'package:kantan/src/themes/themes.dart';

class KantanPlayerApp extends ConsumerWidget {
  const KantanPlayerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    final themeMode = ref.watch(themeModeServiceProvider);
    final interfaceLocale = ref.watch(interfaceLocaleServiceProvider);
    return MaterialApp.router(
      title: Config.appTitle,
      routerConfig: goRouter,
      restorationScopeId: 'app',
      localizationsDelegates: const [
        LocaleNamesLocalizationsDelegate(),
        ...AppLocalizations.localizationsDelegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: interfaceLocale,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > Config.largeBreakpoint) {
          return const LargeLayout();
        } else if (constraints.maxWidth > Config.mediumBreakpoint) {
          return const MediumLayout();
        } else {
          return const TrackListScreen();
        }
      },
    );
  }
}

class MediumLayout extends StatelessWidget {
  const MediumLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final viewPadding = MediaQuery.viewPaddingOf(context);
    return Scaffold(
      drawer: const SettingsMenu(),
      body: SafeArea(
        minimum: EdgeInsets.only(
          left: viewPadding.left + Config.layoutOuterPadding,
          right: viewPadding.right + Config.layoutOuterPadding,
          bottom: viewPadding.left + Config.layoutOuterPadding,
          top: viewPadding.bottom + Config.layoutOuterPadding,
        ),
        child: Row(
          spacing: Config.layoutSpacing,
          children: [
            Expanded(
              flex: 1,
              child: const TrackListPane(),
            ),
            Expanded(
              flex: 1,
              child: const PlayerPane(),
            ),
          ],
        ),
      ),
    );
  }
}

class LargeLayout extends StatelessWidget {
  const LargeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final viewPadding = MediaQuery.viewPaddingOf(context);
    return Scaffold(
      drawer: const SettingsMenu(),
      body: SafeArea(
        minimum: EdgeInsets.only(
          left: viewPadding.left + Config.layoutOuterPadding,
          right: viewPadding.right + Config.layoutOuterPadding,
          bottom: viewPadding.left + Config.layoutOuterPadding,
          top: viewPadding.bottom + Config.layoutOuterPadding,
        ),
        child: Row(
          spacing: Config.layoutSpacing,
          children: [
            Expanded(
              flex: 1,
              child: const TrackListPane(),
            ),
            Expanded(
              flex: 1,
              child: const PlayerPane(),
            ),
            Expanded(
              flex: 1,
              child: const TranscriptPane(),
            ),
          ],
        ),
      ),
    );
  }
}

class TrackListPane extends StatelessWidget {
  const TrackListPane({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(
      context,
    ).extension<TrackListPaneStyle>();
    return Container(
      decoration: style?.decoration ?? BoxDecoration(),
      clipBehavior: Clip.antiAlias,
      child: const TrackListScreenContents(),
    );
  }
}

class PlayerPane extends StatelessWidget {
  const PlayerPane({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).extension<PlayerPaneStyle>();
    return Container(
      decoration: style?.containerDecoration ?? BoxDecoration(),
      clipBehavior: Clip.antiAlias,
      child: const PlayerScreenContents(),
    );
  }
}

class TranscriptPane extends StatelessWidget {
  const TranscriptPane({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).extension<TranscriptPaneStyle>();
    return Container(
      decoration: style?.decoration ?? BoxDecoration(),
      clipBehavior: Clip.antiAlias,
      child: const TranscriptScreenContents(),
    );
  }
}
