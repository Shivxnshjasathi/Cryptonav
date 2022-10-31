import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


currencies1() async {
  List currencies = await getCurrencies();
  print(currencies);
}

Future<List> getCurrencies() async {
  String apiUrl = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false';
  http.Response response = await http.get(Uri.parse(apiUrl));
  return json.decode(response.body);
}