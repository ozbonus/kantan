// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enable_auto_scroll_switch_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$enableAutoScrollSwitchControllerHash() =>
    r'521d2defaa56f62c751b5a963402adfa8fa183ed';

/// Provides a state for the [EnableAutoScrollSwitch] widget in the player
/// controls of the transcript screen.
///
/// Depending on the state, the switch may be active or inactive, on or off.
///
/// Returns a [EnableAutoScrollSwitchState] which is a record comprising two
/// boolean values, [isActive] and [value]. [isActive] will be true if the
/// current track has timestamps available. [value] corresponds to whether
/// auto scroll is enabled or not.
///
/// Copied from [EnableAutoScrollSwitchController].
@ProviderFor(EnableAutoScrollSwitchController)
final enableAutoScrollSwitchControllerProvider =
    AutoDisposeNotifierProvider<
      EnableAutoScrollSwitchController,
      EnableAutoScrollSwitchState
    >.internal(
      EnableAutoScrollSwitchController.new,
      name: r'enableAutoScrollSwitchControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$enableAutoScrollSwitchControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$EnableAutoScrollSwitchController =
    AutoDisposeNotifier<EnableAutoScrollSwitchState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
