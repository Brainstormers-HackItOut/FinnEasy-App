import 'dart:convert';

import 'package:finneasy/src/models/model_utilities.dart';

class StockTweets {
  StockTweets({
    this.globalPolarity,
    this.twList,
    this.twPol,
    this.pos,
    this.neg,
    this.neutral,
  });

  factory StockTweets.fromJson(Map<String, dynamic> jsonRes) {
    final List<String>? twList = jsonRes['tw_list'] is List ? <String>[] : null;
    if (twList != null) {
      for (final dynamic item in jsonRes['tw_list']!) {
        if (item != null) {
          twList.add(asT<String>(item)!);
        }
      }
    }
    return StockTweets(
      globalPolarity: asT<double?>(jsonRes['global_polarity']),
      twList: twList,
      twPol: asT<String?>(jsonRes['tw_pol']),
      pos: asT<int?>(jsonRes['pos']),
      neg: asT<int?>(jsonRes['neg']),
      neutral: asT<int?>(jsonRes['neutral']),
    );
  }

  double? globalPolarity;
  List<String>? twList;
  String? twPol;
  int? pos;
  int? neg;
  int? neutral;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'global_polarity': globalPolarity,
    'tw_list': twList,
    'tw_pol': twPol,
    'pos': pos,
    'neg': neg,
    'neutral': neutral,
  };
}
