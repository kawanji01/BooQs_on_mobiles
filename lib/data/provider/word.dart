import 'package:booqs_mobile/data/remote/words.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wordSearchKeywordProvider = StateProvider<String?>((ref) => null);

final wordsProvider = StateProvider<List<Word>>((ref) => []);

final wordProvider = StateProvider<Word?>((ref) => null);
final wordIdProvider = StateProvider<int?>((ref) => null);
final asyncWordProvider = FutureProvider<Word?>((ref) async {
  final int? id = ref.watch(wordIdProvider);
  if (id == null) return null;
  final Map? resMap = await RemoteWords.show(id);
  if (resMap == null) return null;
  final Word word = Word.fromJson(resMap['word']);
  ref.read(wordProvider.notifier).state = word;
  return word;
});

// ref: https://riverpod.dev/ja/docs/concepts/modifiers/family
// 【重要】 オブジェクトが一定ではない場合は autoDispose 修飾子との併用が望ましい
// family を使って検索フィールドの入力値をプロバイダに渡す場合、その入力値は頻繁に変わる上に同じ値が再利用されることはありません。
// おまけにプロバイダは参照されなくなっても破棄されないのがデフォルトの動作であるため、この場合はメモリリークにつながります。
final asyncWordFamily =
    FutureProvider.autoDispose.family<Word?, int>((ref, wordId) async {
  final Map? resMap = await RemoteWords.show(wordId);
  if (resMap == null) return null;
  final Word word = Word.fromJson(resMap['word']);
  ref.read(wordProvider.notifier).state = word;
  return word;
});

// 辞書編集画面の例文
final wordSentenceProvider = StateProvider<Sentence?>((ref) => null);
