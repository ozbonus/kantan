import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kantan/config.dart';
import 'package:kantan/src/features/parental_mode/data/equations_repository.dart';
import 'package:kantan/src/features/parental_mode/domain/equation.dart';

part 'math_challenge_service.g.dart';

@riverpod
class MathChallengeService extends _$MathChallengeService {
  @override
  Equation build() {
    return ref.watch(equationsRepositoryProvider);
  }

  void getNewEquation() {
    ref.read(equationsRepositoryProvider.notifier).getRandomEquation();
  }

  bool checkAnswer(String userAnswer) {
    if (userAnswer == Config.parentalModeBypassCode) return true;
    return userAnswer == state.ans;
  }
}
