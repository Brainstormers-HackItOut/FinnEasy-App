// Flutter imports:
import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/ui/stock_analysis/search_picker.dart';
import 'package:finneasy/src/ui/stock_analysis/stock_game/stock_game_screen.dart';
import 'package:finneasy/src/ui/stock_analysis/store/stock_store.dart';
import 'package:finneasy/src/widget/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StockMarketScreen extends StatefulWidget {
  const StockMarketScreen({Key? key}) : super(key: key);

  @override
  _StockMarketScreenState createState() => _StockMarketScreenState();
}

class _StockMarketScreenState extends State<StockMarketScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late StockStore _store;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _store = StockStore(context);
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      key: _scaffoldKey,
      appBar: Appbar(
        title: "Stock Market",
        trailingIcon: const Icon(Icons.play_arrow),
        trailingFunction: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const StockGameScreen())),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.symmetric(vertical: 0.01 * screenHeight),
              elevation: 5,
              shadowColor: AppColors.primaryColor,
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPicker(header: "Search", store: _store,)))
                },
                child: Container(
                    width: 0.8 *  MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    child: Center(
                      child: Text("Search in Listed Stocks",
                          style: TextStyle(
                              fontSize: 0.02 *  MediaQuery.of(context).size.height,
                              color: AppColors.black
                          )
                      ),
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}