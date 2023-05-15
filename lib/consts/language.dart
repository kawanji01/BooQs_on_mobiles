// ※ l10nのarbでは - は利用できないので、-を-に変換している。
const Map<String, int> languageCodeMap = {
  'undefined': 0,
  'af': 1,
  'sq': 2,
  'am': 3,
  'ar': 4,
  'hy': 5,
  'az': 6,
  'eu': 7,
  'be': 8,
  'bn': 9,
  'bs': 10,
  'bg': 11,
  'ca': 12,
  'ceb': 13,
  'zh-CN': 14,
  'zh-Hans': 14,
  'zh-TW': 15,
  'zh-Hant': 15,
  'co': 16,
  'hr': 17,
  'cs': 18,
  'da': 19,
  'nl': 20,
  'en': 21,
  'eo': 22,
  'et': 23,
  'fi': 24,
  'fr': 25,
  'fy': 26,
  'gl': 27,
  'ka': 28,
  'de': 29,
  'el': 30,
  'gu': 31,
  'ht': 32,
  'ha': 33,
  'haw': 34,
  'he': 35,
  'iw': 35,
  'hi': 36,
  'hmn': 37,
  'hu': 38,
  'is': 39,
  'ig': 40,
  'id': 41,
  'ga': 42,
  'it': 43,
  'ja': 44,
  'jv': 45,
  'kn': 46,
  'kk': 47,
  'km': 48,
  'rw': 49,
  'ko': 50,
  'ku': 51,
  'ky': 52,
  'lo': 53,
  'la': 54,
  'lv': 55,
  'lt': 56,
  'lb': 57,
  'mk': 58,
  'mg': 59,
  'ms': 60,
  'ml': 61,
  'mt': 62,
  'mi': 63,
  'mr': 64,
  'mn': 65,
  'my': 66,
  'ne': 67,
  'no': 68,
  'ny': 69,
  'or': 70,
  'ps': 71,
  'fa': 72,
  'pl': 73,
  'pt': 74,
  'pa': 75,
  'ro': 76,
  'ru': 77,
  'sm': 78,
  'gd': 79,
  'sr': 80,
  'st': 81,
  'sn': 82,
  'sd': 83,
  'si': 84,
  'sk': 85,
  'sl': 86,
  'so': 87,
  'es': 88,
  'su': 89,
  'sw': 90,
  'sv': 91,
  'tl': 92,
  'fil': 92,
  'tg': 93,
  'ta': 94,
  'tt': 95,
  'te': 96,
  'th': 97,
  'tr': 98,
  'tk': 99,
  'uk': 100,
  'ur': 101,
  'ug': 102,
  'uz': 103,
  'vi': 104,
  'cy': 105,
  'xh': 106,
  'yi': 107,
  'yo': 108,
  'zu': 109,
  'zh': 110,
};
// 多言語化(i18n)に対応している言語番号
const List<int> supportedLangNumbers = [21, 44];
