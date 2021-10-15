// Flutter imports:
import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/core/network_state/network_state.dart';
import 'package:flutter/material.dart';

class ObserverNetworkState extends StatelessWidget {
  final NetworkState networkState;
  final Widget taskToBeDone;
  Widget errorOccured;
  Widget loading;

  ObserverNetworkState({
    required this.networkState,
    required this.taskToBeDone,
    this.loading = const Center(
      child: CircularProgressIndicator(
          color: AppColors.primaryColor
      ),
    ),
    this.errorOccured = const Text(
      'Error occurred while loading! \nPlease try again later',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: AppColors.primaryColor
      ),
    )
  });

  late double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return getWidget(context);
  }
  getWidget(BuildContext context){
    switch (networkState) {
      case NetworkState.initial:
        return SizedBox.shrink();
      case NetworkState.loading:
        return loading;
      case NetworkState.completed:
        return taskToBeDone;
      case NetworkState.error:
        return errorOccured;
      default:
        return SizedBox.shrink();
    }
  }
}