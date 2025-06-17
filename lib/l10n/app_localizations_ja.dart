// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String aboutAndInfoTileLabel(String appName) {
    return '情報と詳細';
  }

  @override
  String get appLanguageDescription =>
      'アプリのインターフェース言語を変更します。トランスクリプトの翻訳先言語は変わりません。';

  @override
  String get appLanguageListTileLabel => 'インターフェースの言語';

  @override
  String get cancelButtonLabel => 'キャンセル';

  @override
  String get noTranscriptMessage => 'No transcript for this track.';

  @override
  String get canSeeTranscriptTileLabel => 'トランスクリプトを表示する';

  @override
  String get canSeeTranslationTileLabel => '翻訳を表示する';

  @override
  String get changeTextSizeTooltip => '文字サイズの変更';

  @override
  String get checkAnswerButtonText => '答を見る';

  @override
  String get closeSettingsAndInfoTileLabel => '閉じる';

  @override
  String get darkTheme => 'ダークテーマ';

  @override
  String get defaultLanguageOptionLabel => 'デバイスの言語設定';

  @override
  String get deviceTheme => 'デバイスのテーマ';

  @override
  String get disableModeWindowTitle => 'モードを無効にする';

  @override
  String get disableParentTeacherModeConfirmationText => '保護者・教師モードを無効にしますか？';

  @override
  String get discObject => 'CD';

  @override
  String get exitFullscreenTooltip => '全画面表示の終了';

  @override
  String get fastForwardButtonTooltip => '5秒進む';

  @override
  String get lightTheme => 'ライトテーマ';

  @override
  String get loadingButtonTooltip => '読み込み中';

  @override
  String get loadingLabel => '読み込み中…';

  @override
  String get mathChallengeWarning => '再び有効にするには数学の問題を解く必要があります。';

  @override
  String get noTranslationLanguageOptionLabel => '指定なし';

  @override
  String get okButtonText => 'OK';

  @override
  String get openPlayerControlsTooltip => 'プレーヤーコントロールを開く';

  @override
  String get parentAndTeacherModeTileLabel => '保護者・教師モード';

  @override
  String get parentTeacherModeActivatedPopup => '保護者・教師モードが有効になりました。';

  @override
  String get parentTeacherModeWindowTitle => '保護者・教師向け';

  @override
  String get pauseButtonTooltip => '一時停止';

  @override
  String get playButtonTooltip => '再生';

  @override
  String get progressSliderTooltip => '特定の位置に移動';

  @override
  String get repeatModeButtonTooltip => 'リピートモードの変更';

  @override
  String get replayButtonTooltip => '全てリプレイ';

  @override
  String get replayIntroduction => 'イントロダクションのリプレイ';

  @override
  String get rewindButtonTooltip => '5秒戻る';

  @override
  String get settingsAndInfoMenuTitle => '設定';

  @override
  String get showTranslationTooltip => '翻訳の表示/非表示';

  @override
  String sizeMultiplierSymbol(String size) {
    return '$size倍';
  }

  @override
  String get skipNextButtonTooltip => '次にスキップ';

  @override
  String get skipPreviousButtonTooltip => '前にスキップ';

  @override
  String get solveForX => 'xを求めよ';

  @override
  String speedMultiplierSymbol(String speed) {
    return '$speed倍速';
  }

  @override
  String get speedSliderTooltip => 'スピードの変更';

  @override
  String get themeMenuTitle => 'テーマ';

  @override
  String get trackObject => 'トラック';

  @override
  String get transcriptButtonLabel => 'トランスクリプト';

  @override
  String get transcriptFullscreenTooltip => '全画面表示の開始';

  @override
  String get translationLanguageDescription =>
      'トランスクリプトの翻訳先としてはこれらの言語が利用可能です。トランスクリプト画面に表示する言語を選択してください。アプリのインターフェース言語は変わりません。';

  @override
  String get translationLanguageListTileLabel => '翻訳先言語';

  @override
  String get wakelockTileLabel => '画面をオンのままにしてください';
}
