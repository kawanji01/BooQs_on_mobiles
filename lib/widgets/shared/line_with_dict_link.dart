import 'package:booqs_mobile/pages/dictionary/word_search_results.dart';
import 'package:booqs_mobile/widgets/markdown/markdown_without_dict_link.dart';
import 'package:flutter/material.dart';

class LineWithDictLink extends StatelessWidget {
  const LineWithDictLink(
      {Key? key,
      required this.line,
      required this.dictionaryId,
      required this.autoLinkEnabled})
      : super(key: key);
  final String line;
  final int? dictionaryId;
  final bool autoLinkEnabled;

  @override
  Widget build(BuildContext context) {
    // 辞書IDが設定されていないなら、
    if (dictionaryId == null) {
      return MarkdownWithoutDictLink(
        text: line,
        textStyle:
            const TextStyle(fontSize: 16, height: 1.6, color: Colors.black87),
        selectable: true,
      );
    }

    final ButtonStyle buttonStyle = ButtonStyle(
      // paddingを消す
      padding: MaterialStateProperty.all(EdgeInsets.zero),
      minimumSize: MaterialStateProperty.all(Size.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );

    Future _goToWordSearchPage(keyword) async {
      await DictionaryWordSearchResultsPage.push(
          context, dictionaryId!, keyword);
    }

    // 記法なしの単語
    // 自動でリンクをつけるならtrue, 記法でのみリンクをつける場合はfalse
    Widget _plainWord(String word) {
      if (autoLinkEnabled) {
        return TextButton(
          style: buttonStyle,
          onPressed: () => _goToWordSearchPage(word),
          // splitで削除した空白を追加する
          child: Text('$word ',
              style: const TextStyle(
                  color: Colors.green, fontSize: 16, height: 1.6)),
        );
      }
      //return Text('$word ',
      //    style: const TextStyle(
      //        fontSize: 16, height: 1.6, color: Colors.black87));
      return MarkdownWithoutDictLink(
        text: '$word ',
        textStyle:
            const TextStyle(fontSize: 16, height: 1.6, color: Colors.black87),
        selectable: true,
      );
    }

    Widget _wordWithDictLink(String word) {
      final linkedWord = word.replaceFirst('[[', '').replaceFirst(']]', '');
      Color textColor = Colors.green;
      // オートリンクの場合は、オートリンクとwiki記法のリンクの区別がつかないので、wiki記法のリンクの色をオレンジにする。
      if (autoLinkEnabled) {
        textColor = Colors.orange;
      }

      // [[diplayedWord|searchedWord]]の場合
      if (linkedWord.contains('|')) {
        final displayedWord = linkedWord.split('|')[0];
        final searchedWord = linkedWord.split('|')[1];
        return TextButton(
          style: buttonStyle,
          onPressed: () => _goToWordSearchPage(searchedWord),
          child: Text(displayedWord,
              style: TextStyle(color: textColor, fontSize: 16, height: 1.6)),
        );
      }
      // [[diplayedWord]]の場合
      return TextButton(
        style: buttonStyle,
        onPressed: () => _goToWordSearchPage(linkedWord),
        child: Text(linkedWord,
            style: TextStyle(color: textColor, fontSize: 16, height: 1.6)),
      );
    }

    // 単語のウィジェットを生成する。
    Widget _wordWidget(String word) {
      // 記法を持たない単語
      if (RegExp(r'(\[{2}.*?\]{2})').hasMatch(word) == false) {
        return _plainWord(word);
      }
      // 記法持ちの単語
      return _wordWithDictLink(word);
    }

    // 記法が使われたテキストと、そうでない通常のテキストを分けてリストにする
    // セパレーターを含んでテキストを分割する。参考： https://stackoverflow.com/questions/59547040/dart-split-string-using-regular-expression-and-include-delimiters?rq=1
    List<String> allMatchesWithSep(String text, RegExp exp, [int start = 0]) {
      var result = <String>[];
      // start（最初は0）で指定されたindex以降の文字列から、expの正規表現に一致するものを調べる。参考： https://api.flutter.dev/flutter/dart-core/String/substring.html
      for (var match in exp.allMatches(text, start)) {
        // (X): substring(前回に一致した文字列の最後のindex, 今回一致した文字列の最初のindex)を指定することで「一致しなかった文字列」を抜き出す。 参考： https://api.flutter.dev/flutter/dart-core/String/substring.html
        String notMatch = text.substring(start, match.start);
        // 「一致しなかった文字列」をリストに加える。
        // result.add(notMatch);
        // 英単語に自動でLinkをつけられるように、スペースで文字列を区切ってリストに加える
        notMatch.split(' ').forEach((element) {
          result.add(element);
        });
        // 一致した文字列[[text]]をリストに追加する。
        result.add(match[0]!);
        // 一致した文字列の最後のindexをstartを書き換えて、(X)を機能させる。
        start = match.end;
      }
      // 文字列のうち、一致しなかった最後尾の部分をリストに加える。
      //result.add(text.substring(start));
      text.substring(start).split(' ').forEach((element) {
        result.add(element);
      });
      return result;
    }

    // [[text]]や[[text|link]]を分ける。
    List<String?> _splitLineIntoWords(String textWithDictLinks) {
      final exp = RegExp(r'(\[{2}.*?\]{2})');
      final list = allMatchesWithSep(textWithDictLinks, exp);
      return list;
    }

    // 文字列を「リンク付き文字列」に変換する
    Widget _lineWithDictLink(String line) {
      List<Widget> wordWidgetList = <Widget>[];
      // テキストを単語に分割してリストにする。
      List<String?> wordList = _splitLineIntoWords(line);

      for (String? word in wordList) {
        Widget wordWidget = _wordWidget(word!);
        wordWidgetList.add(wordWidget);
      }

      // RowではなくWrapを使うことで、Widgetを横に並べたときに画面からはみ出す問題を防ぐ。
      return Wrap(
        children: wordWidgetList,
      );
    }

    return _lineWithDictLink(line);
  }
}
