import 'package:finneasy/resources/colors.dart';
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

  // Product currentSearch;

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
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: TextField(
                    autofocus: true,
                    decoration:InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter company name",
                        hintStyle: TextStyle(
                            color: AppColors.primaryColor,
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
          // FutureBuilder(
          //   future: pattern.length < 4 ? null : StockApi.searchStock(pattern),
          //   builder: (context, snapshot) => pattern.length < 4 ? Container() :
          //   snapshot.hasData ? Expanded(
          //       child: ListView.builder(
          //         itemBuilder: (context, index) => GestureDetector(
          //           onTap: () {
          //             setState(() {
          //               currentSearch = snapshot.data![index];
          //             });
          //             print(currentSearch);
          //             Navigator.push(context, MaterialPageRoute(builder: (context) => WebPageView(
          //               title: snapshot.data![index].name,
          //               url: "https://in.tradingview.com/chart/?symbol=NSE%3A" + snapshot.data![index].name,
          //               icon: const Icon(Icons.shopping_bag_outlined),
          //               function: (){
          //                 showModalBottomSheet<dynamic>(
          //                   isScrollControlled: true,
          //                   context: context,
          //                   elevation: 1.0,
          //                   backgroundColor: Colors.transparent,
          //                   builder: (buildContext) {
          //                     return ShoppingBottomSheet(store: widget.store, stockname: snapshot.data![index].name,);
          //                   },
          //                 );
          //               },
          //             )));
          //           },
          //           child: Container(
          //               padding: EdgeInsets.all(15),
          //               child: Text(snapshot.data![index].name,
          //                   style: TextStyle(
          //                       fontSize: 16
          //                   )
          //               )
          //           ),
          //         ),
          //         itemCount: snapshot.data!.length,
          //       )
          //   ) : const Center(
          //     child: CircularProgressIndicator(
          //       color: AppColors.primaryColor,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}