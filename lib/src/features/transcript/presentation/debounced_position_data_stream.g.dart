// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debounced_position_data_stream.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$debouncedPositionStreamHash() =>
    r'2ef89d7d9447211c349da224dccbb4e51f5bb81d';

/// Returns a new value from the position data stream only if the delta from the
/// previous value is larger than the value defined in the config file. This
/// lowers the frequency of rebuilds while allowing the auto scrolling
/// transcript to appear responsive.
///
/// Copied from [debouncedPositionStream].
@ProviderFor(debouncedPositionStream)
final debouncedPositionStreamProvider =
    AutoDisposeStreamProvider<PositionData>.internal(
      debouncedPositionStream,
      name: r'debouncedPositionStreamProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$debouncedPositionStreamHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DebouncedPositionStreamRef = AutoDisposeStreamProviderRef<PositionData>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
