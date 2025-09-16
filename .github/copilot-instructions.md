# Kantan Player - AI Coding Assistant Instructions

## Project Overview

Kantan Player is a Flutter app framework for distributing textbook audio resources with rich features like multi-language support, transcripts, translations, and parental controls. The app follows a feature-based architecture with clean separation between data, domain, and presentation layers.

## Architecture & Patterns

### Feature-Based Structure
- Each feature follows the pattern: `lib/src/features/<feature>/{data,domain,presentation}/`
- Core features: `player`, `track_list`, `transcript`, `settings`, `parental_mode`, `wakelock`
- Shared code in `lib/src/common_widgets/`, `lib/src/routing/`, `lib/src/themes/`

### State Management
- **Riverpod with code generation**: Use `@riverpod` annotation for providers
- **Generated files**: Run `dart run build_runner build` after adding/modifying providers
- **Provider patterns**: Repositories use `@Riverpod(keepAlive: true)` for singletons
- **App startup**: Critical services initialized in `appStartupProvider` (main.dart)

### Responsive Design
```dart
// Responsive breakpoints defined in Config class
- Small: < 590px (mobile - track list only)  
- Medium: 590-1000px (tablet - track list + player)
- Large: > 1000px (desktop - track list + player + transcript)
```

### Configuration System
- **Central config**: All app settings in `lib/config.dart` 
- **Feature flags**: Enable/disable features via `Config.use*Feature` bools
- **Parental mode**: Feature access controlled by `Config.*IsParentalMode` bools
- **Responsive values**: Breakpoints, dimensions, and durations centralized

## Key Development Workflows

### Adding New Features
1. Create feature directory: `lib/src/features/<feature>/{data,domain,presentation}/`
2. Define domain models in `domain/` (simple classes/enums)
3. Implement repository in `data/` with `@riverpod` provider
4. Add to `appStartupProvider` if critical for app initialization
5. Create presentation widgets, use Riverpod `Consumer*` for state access

### Internationalization (i18n)
- **ARB files**: Add translations to `lib/l10n/app_*.arb` 
- **Generate**: Run `flutter gen-l10n` to update localizations
- **Hardcoded strings**: Use `.hardcoded` extension for placeholder text
- **Locale switching**: Interface and translation locales controlled separately

### Audio Integration
- **Audio service**: Managed through `audio_handler_service.dart`
- **Background playback**: Uses `audio_service` package for system integration
- **State sync**: Player state synced between UI and background service
- **Media items**: Tracks converted to MediaItem for system player

## Code Conventions

### File Naming & Organization
- Use snake_case for files: `track_list_screen.dart`
- Generated files have `.g.dart` suffix (commit these to version control)
- Domain objects are simple data classes without business logic
- Repositories handle data fetching and caching

### Widget Patterns
```dart
// Responsive layout example
class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > Config.largeBreakpoint) {
        return const LargeLayout();  // 3-pane
      } else if (constraints.maxWidth > Config.mediumBreakpoint) {
        return const MediumLayout(); // 2-pane  
      } else {
        return const TrackListScreen(); // 1-pane
      }
    });
  }
}
```

### Riverpod State Management
```dart
// Repository pattern with keepAlive
@Riverpod(keepAlive: true)
FutureOr<List<Track>> tracksRepository(Ref ref) async {
  // Load from assets, cache in memory
}

// Feature service pattern
@riverpod
class PlayerService extends _$PlayerService {
  // Stateful business logic
}
```

### Asset Management
- **Demo assets**: External package `../demo_assets/` for fonts, tracks, images
- **Asset paths**: Use `Config.assetsDir` and `Config.assetsPackage` 
- **JSON data**: Track metadata loaded from `assets/tracks.json`

## Testing & Quality

### Test Structure
- Mirror lib structure in `test/src/features/`
- Mock external dependencies in `test/mocks/`
- Widget tests for presentation layer, unit tests for data/domain

### Linting & Analysis
- **Flutter lints**: Standard linting with `flutter_lints` package
- **Custom lint**: Additional rules via `custom_lint` plugin  
- **Riverpod lint**: Specialized rules for Riverpod patterns
- **Code generation**: Always run `dart run build_runner build` after changes

### Build Commands
```bash
# Standard development
flutter run

# Code generation (required after provider changes)
dart run build_runner build

# Internationalization (after ARB changes)  
flutter gen-l10n

# Testing
flutter test

# Analysis
flutter analyze
```

## External Dependencies

### Core Audio Stack
- `just_audio`: Primary audio playback engine
- `audio_service`: Background playback and system integration
- `audio_session`: iOS/Android audio session management

### Key UI Libraries  
- `go_router`: Declarative routing with responsive redirects
- `flex_color_scheme`: Material 3 theming system
- `flutter_animate`: Smooth animations and transitions
- `scrollable_positioned_list`: Transcript line-by-line navigation

### Data & Utilities
- `shared_preferences`: Settings persistence
- `path_provider`: File system access for caching
- `package_info_plus`: App version and metadata

## Common Gotchas

- **Generated files**: Always run `dart run build_runner build` after modifying `@riverpod` providers
- **Responsive routing**: Player route auto-redirects to home on larger screens  
- **Feature flags**: Check `Config.use*Feature` before implementing feature UI
- **Parental mode**: Verify `Config.*IsParentalMode` for feature access control
- **Asset loading**: Use `Config.assetsPackage` prefix for external demo assets
- **Localization**: Update both interface and content locales independently