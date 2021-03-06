import 'dart:developer';

import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/ui/stock_analysis/model/stock_search.dart';
import 'package:finneasy/src/ui/stock_analysis/store/stock_store.dart';
import 'package:finneasy/src/ui/stock_analysis/widget/stock_purchase_bottom_sheet.dart';
import 'package:finneasy/src/widget/appbar.dart';
import 'package:finneasy/src/widget/webview.dart';
import 'package:flutter/material.dart';

import 'api/stock_api.dart';

class SearchPicker extends StatefulWidget {
  final String header;
  final StockStore store;

  const SearchPicker({Key? key, required this.header, required this.store}) : super(key: key);
  @override
  _SearchPickerState createState() => _SearchPickerState();
}

class _SearchPickerState extends State<SearchPicker> {
  
  String pattern = "";
  final TextEditingController _typeAheadController1 = TextEditingController();

  List<StockSearch> currentSearch = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: Appbar(
        title: widget.header
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.20,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/search.png"),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter),
                ),
                child: null
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 0.1 * screenWidth, right: 0.1 * screenWidth, top: 0.05 * screenHeight),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: AppColors.primaryColor,
                    blurRadius: 15.0,
                    spreadRadius: -5
                ),
              ],
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: TextField(
                    autofocus: true,
                    decoration:InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter company name",
                        hintStyle: TextStyle(
                            color: AppColors.white,
                            fontSize: 18
                        )
                    ),
                    controller: _typeAheadController1,
                    onChanged: (value) {
                      setState(() {
                        pattern = value;
                      });
                    },
                  )
              ),
            ),
          ),
          FutureBuilder(
            future: pattern.length < 4 ? null : StockApi.searchStock(pattern),
            builder: (context, snapshot) {
              if (snapshot.data != null){
                    currentSearch = (snapshot.data as List<StockSearch>);
              }

              return pattern.length < 4 ? Container() :
              snapshot.hasData ? Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) =>
                        GestureDetector(
                          onTap: () {
                            log(currentSearch[index].toString());

                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    WebPageView(
                                      title: currentSearch[index].nameOfCompany!,
                                      url: "https://in.tradingview.com/chart/?symbol=NSE%3A" +
                                          currentSearch[index].symbol!,
                                      icon: const Icon(
                                          Icons.shopping_bag_outlined),
                                      widget: ShoppingBottomSheet(
                                        store: widget.store,
                                        stockName: currentSearch[index]
                                            .nameOfCompany!,
                                        symbol: currentSearch[index]
                                            .symbol!,
                                        stockPrice: currentSearch[index]
                                            .paidUpValue! + 0.0,
                                      )
                                    )));
                          },
                          child: Container(
                              padding: EdgeInsets.all(15),
                              child: Text(currentSearch[index].nameOfCompany!,
                                  style: TextStyle(
                                      fontSize: 16
                                  )
                              )
                          ),
                        ),
                    itemCount: currentSearch.length,
                  )
              ) : const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            }
          )
        ],
      ),
    );
  }
}