import 'dart:convert';

import 'package:finneasy/src/models/model_utilities.dart';

class StockSearch {

  StockSearch({
    this.symbol,
    this.nameOfCompany,
    this. series,
    this. dateOfListing,
    this. paidUpValue,
    this. marketLot,
    this. isinNumber,
    this. faceValue,
    this.score,
  });

  factory StockSearch.fromJson(Map<String, dynamic> jsonRes)=>StockSearch(
      symbol: asT<String?>(jsonRes['SYMBOL']),
      nameOfCompany : asT<String?>(jsonRes['NAME OF COMPANY']),
  series : asT<String?>(jsonRes[' SERIES']),
  dateOfListing : asT<String?>(jsonRes[' DATE OF LISTING']),
  paidUpValue : asT<int?>(jsonRes[' PAID UP VALUE']),
  marketLot : asT<int?>(jsonRes[' MARKET LOT']),
  isinNumber : asT<String?>(jsonRes[' ISIN NUMBER']),
  faceValue : asT<int?>(jsonRes[' FACE VALUE']),
  score : asT<int?>(jsonRes['score']),);

  String? symbol;
  String? nameOfCompany;
  String?  series;
  String?  dateOfListing;
  int?  paidUpValue;
  int?  marketLot;
  String?  isinNumber;
  int?  faceValue;
  int? score;

  @override
  String  toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'SYMBOL': symbol,
    'NAME OF COMPANY': nameOfCompany,
    ' SERIES':  series,
    ' DATE OF LISTING':  dateOfListing,
    ' PAID UP VALUE':  paidUpValue,
    ' MARKET LOT':  marketLot,
    ' ISIN NUMBER':  isinNumber,
    ' FACE VALUE':  faceValue,
    'score': score,
  };
}