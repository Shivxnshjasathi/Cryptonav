import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'coin.dart';
import 'coincarddesign.dart';
import 'cointiles.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends State<Home> {
  Future<List<Coin>> fetchCoin() async {
    coinList = [];
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));
    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            coinList.add(Coin.fromJson(map));
          }
        }
        setState(() {
          coinList;
        });
      }
      return coinList;
    } else {
      throw Exception('Failed to load coins');
    }
  }

  int _currentPage = 0;
  late Timer _timer;
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    fetchCoin();
    Timer.periodic(const Duration(seconds: 10), (timer) => fetchCoin());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xff252524),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 20,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height / 15 ,),
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    child: PageView(
                      controller: _pageController,
                      children: [
                        Container(
                          color: Colors.transparent,
                          child: Image.asset(
                            'image/chat_application_logo_design-removebg-preview.png',
                            height: 50,
                            width: 200,
                            fit: BoxFit.cover,
                            alignment:
                            Alignment.centerLeft,
                          ),
                        ),
                        Container(
                          color: Colors.transparent,
                          child: Center(
                            child: Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(image: AssetImage("image/Crypto_portfolio-rafiki-removebg-preview.png"))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 20 ,),


                ],
              ),

            ),
            Container(
              height: MediaQuery.of(context).size.height / 10,
              color: Colors.transparent,
              child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        isDismissible: true,
                        backgroundColor: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20))),
                        builder: (builder) {
                          return DraggableScrollableSheet(
                            initialChildSize: 0.78,
                            minChildSize: 0.3,
                            maxChildSize: 0.78,
                            builder: (_, controller) => Container(
                              decoration: const BoxDecoration(
                                  color: Color(0xfff2f0f2),
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20))),
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 8,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              25,
                                          color: Colors.transparent,
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              15,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Colors.transparent,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(1.0),
                                                child: Image.asset(
                                                  'image/logo.png',
                                                  height: 50,
                                                  width: 300,
                                                  fit: BoxFit.cover,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.6,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount: coinList.length,
                                          itemBuilder: (context, index) {
                                            return SingleChildScrollView(
                                              child: CointileDesign(
                                                name: coinList[index].name,
                                                symbol: coinList[index].symbol,
                                                imageUrl:
                                                    coinList[index].imageUrl,
                                                change: coinList[index]
                                                    .change
                                                    .toDouble(),
                                                changePercentage:
                                                    coinList[index]
                                                        .changePercentage
                                                        .toDouble(),
                                              ),
                                            );
                                          },
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 10,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                  )),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width / 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xfff2f0f2),
              ),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2.5,
                    width: MediaQuery.of(context).size.width / 1.05,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 100,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 15,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          20,
                                    ),
                                    Image.asset(
                                      'image/o.png',
                                      height: 50,
                                      width: 250,
                                      fit: BoxFit.cover,
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 40,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 3.5,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: coinList.length,
                              itemBuilder: (context, index) {
                                return SingleChildScrollView(
                                  child: CoinCardDesign(
                                    name: coinList[index].name,
                                    symbol: coinList[index].symbol,
                                    imageUrl: coinList[index].imageUrl,
                                    price: coinList[index].price.toDouble(),
                                  ),
                                );
                              },
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
