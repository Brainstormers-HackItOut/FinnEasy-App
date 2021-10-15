import 'package:mobx/mobx.dart';

enum NetworkState {
  initial,
  loading,
  completed,
  error
}

NetworkState getNetworkState(FutureStatus futureStatus) {
  switch (futureStatus) {
    case FutureStatus.pending:
      return NetworkState.loading;
    case FutureStatus.rejected:
      return NetworkState.error;
    case FutureStatus.fulfilled:
      return NetworkState.completed;
    default:
      return NetworkState.initial;
  }
}