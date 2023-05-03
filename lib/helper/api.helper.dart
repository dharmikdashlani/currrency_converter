// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import '../modal/currency_modal.dart';
//
// class APIHelper {
//   APIHelper._();
//
//   static final APIHelper apiHelper = APIHelper._();
//
//   Future<List<AllCurrency>?> getCurrency() async {
//     // int number = 100;
//     // String all = z;
//     String apikey = "TetTDAvF0k3S8Re90eKFQDTIAHBjOb0xgxH5QNdt";
//     String api = "https://api.currencyapi.com/v3/latest?apikey=$apikey";
//     http.Response res = await http.get(Uri.parse(api));
//
//     if (res.statusCode == 200) {
//       Map<String, dynamic> decodeData = jsonDecode(res.body);
//       List info = decodeData['hits'];
//       List<AllCurrency> allCurrency =
//           info.map((e) => AllCurrency.fromMap(data: e)).toList();
//       return allCurrency;
//     }
//     return null;
//     // return null;
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../modal/currency_modal.dart';

class APIHelper {
  APIHelper._();

  static final APIHelper apiHelper = APIHelper._();
  static   List<AllCurrency> list = [];
  static List<DropdownMenuEntry<dynamic>> list1 =[];
  Future<List<AllCurrency>?> getCurrency() async {
    String apiKey = "TetTDAvF0k3S8Re90eKFQDTIAHBjOb0xgxH5QNdt";
    String api = "https://api.currencyapi.com/v3/latest?apikey=$apiKey&base_currency=INR";


    http.Response res = await http.get(Uri.parse(api));

    if (res.statusCode == 200) {
      Map decodedData = jsonDecode(res.body);
           (decodedData['data'] as Map).forEach((key, value) {
        AllCurrency currency = AllCurrency.fromMap(data: value);
        list.add(currency);
        list1.add(DropdownMenuEntry(value: currency.code, label: currency.code));
      });

      return list;
    }
    return null;
  }
}
