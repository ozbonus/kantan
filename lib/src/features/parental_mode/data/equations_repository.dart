import 'dart:math';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kantan/src/features/parental_mode/data/equations_list.dart';
import 'package:kantan/src/features/parental_mode/domain/equation.dart';

part 'equations_repository.g.dart';

@riverpod
class EquationsRepository extends _$EquationsRepository {
  late int _index;

  @override
  Equation build() {
    _index = Random().nextInt(equationsList.length);
    return equationsList[_index];
  }

  void getRandomEquation() {
    var newIndex = Random().nextInt(equationsList.length);
    while (newIndex == _index) {
      newIndex = Random().nextInt(equationsList.length);
    }
    _index = newIndex;
    state = equationsList[_index];
  }
}
