// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StockStore on _StockStore, Store {
  final _$isLoadingAtom = Atom(name: '_StockStore.isLoading');

  @override
  NetworkState get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(NetworkState value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$priceAtom = Atom(name: '_StockStore.price');

  @override
  double get price {
    _$priceAtom.reportRead();
    return super.price;
  }

  @override
  set price(double value) {
    _$priceAtom.reportWrite(value, super.price, () {
      super.price = value;
    });
  }

  final _$userwealthAtom = Atom(name: '_StockStore.userwealth');

  @override
  double get userwealth {
    _$userwealthAtom.reportRead();
    return super.userwealth;
  }

  @override
  set userwealth(double value) {
    _$userwealthAtom.reportWrite(value, super.userwealth, () {
      super.userwealth = value;
    });
  }

  final _$number_of_sharesAtom = Atom(name: '_StockStore.number_of_shares');

  @override
  int get number_of_shares {
    _$number_of_sharesAtom.reportRead();
    return super.number_of_shares;
  }

  @override
  set number_of_shares(int value) {
    _$number_of_sharesAtom.reportWrite(value, super.number_of_shares, () {
      super.number_of_shares = value;
    });
  }

  final _$totalnumofshareAtom = Atom(name: '_StockStore.totalnumofshare');

  @override
  int get totalnumofshare {
    _$totalnumofshareAtom.reportRead();
    return super.totalnumofshare;
  }

  @override
  set totalnumofshare(int value) {
    _$totalnumofshareAtom.reportWrite(value, super.totalnumofshare, () {
      super.totalnumofshare = value;
    });
  }

  final _$sharesboughtAtom = Atom(name: '_StockStore.sharesbought');

  @override
  int get sharesbought {
    _$sharesboughtAtom.reportRead();
    return super.sharesbought;
  }

  @override
  set sharesbought(int value) {
    _$sharesboughtAtom.reportWrite(value, super.sharesbought, () {
      super.sharesbought = value;
    });
  }

  final _$highAtom = Atom(name: '_StockStore.high');

  @override
  double get high {
    _$highAtom.reportRead();
    return super.high;
  }

  @override
  set high(double value) {
    _$highAtom.reportWrite(value, super.high, () {
      super.high = value;
    });
  }

  final _$lowAtom = Atom(name: '_StockStore.low');

  @override
  double get low {
    _$lowAtom.reportRead();
    return super.low;
  }

  @override
  set low(double value) {
    _$lowAtom.reportWrite(value, super.low, () {
      super.low = value;
    });
  }

  final _$tweetsAtom = Atom(name: '_StockStore.tweets');

  @override
  StockTweets get tweets {
    _$tweetsAtom.reportRead();
    return super.tweets;
  }

  @override
  set tweets(StockTweets value) {
    _$tweetsAtom.reportWrite(value, super.tweets, () {
      super.tweets = value;
    });
  }

  final _$cashFlowAtom = Atom(name: '_StockStore.cashFlow');

  @override
  Map<String, dynamic> get cashFlow {
    _$cashFlowAtom.reportRead();
    return super.cashFlow;
  }

  @override
  set cashFlow(Map<String, dynamic> value) {
    _$cashFlowAtom.reportWrite(value, super.cashFlow, () {
      super.cashFlow = value;
    });
  }

  final _$stockTweetAnalysisAsyncAction =
      AsyncAction('_StockStore.stockTweetAnalysis');

  @override
  Future<void> stockTweetAnalysis(String query) {
    return _$stockTweetAnalysisAsyncAction
        .run(() => super.stockTweetAnalysis(query));
  }

  final _$cashFlowAnalysisAsyncAction =
      AsyncAction('_StockStore.cashFlowAnalysis');

  @override
  Future<void> cashFlowAnalysis(List<Map<String, dynamic>> messages) {
    return _$cashFlowAnalysisAsyncAction
        .run(() => super.cashFlowAnalysis(messages));
  }

  final _$buyAsyncAction = AsyncAction('_StockStore.buy');

  @override
  Future<void> buy(String companyCode, String companyName, double stockPrice) {
    return _$buyAsyncAction
        .run(() => super.buy(companyCode, companyName, stockPrice));
  }

  final _$sellAsyncAction = AsyncAction('_StockStore.sell');

  @override
  Future<void> sell(String companyCode, String companyName, double stockPrice) {
    return _$sellAsyncAction
        .run(() => super.sell(companyCode, companyName, stockPrice));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
price: ${price},
userwealth: ${userwealth},
number_of_shares: ${number_of_shares},
totalnumofshare: ${totalnumofshare},
sharesbought: ${sharesbought},
high: ${high},
low: ${low},
tweets: ${tweets},
cashFlow: ${cashFlow}
    ''';
  }
}
