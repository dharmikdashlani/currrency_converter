import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import '../../provider/theme_changer_provider.dart';

class Convert extends StatefulWidget {
  const Convert({Key? key}) : super(key: key);

  @override
  State<Convert> createState() => _ConvertState();
}

class _ConvertState extends State<Convert> {
  final TextEditingController _controller = TextEditingController();
  String _fromCurrency = '';
  String _toCurrency = '';
  List<String> _currencies = [];
  String _result = '';

  @override
  void initState() {
    super.initState();
    _fetchCurrencies();
  }

  void _fetchCurrencies() async {
    final response = await http
        .get(Uri.parse('https://openexchangerates.org/api/currencies.json'));
    final data = jsonDecode(response.body);
    setState(() {
      _currencies = data.keys.toList();
      _fromCurrency = _currencies[0];
      _toCurrency = _currencies[1];
    });
  }

  void _convertCurrency() async {
    final response = await http.get(
        Uri.parse('https://api.exchangerate-api.com/v4/latest/$_fromCurrency'));
    final data = jsonDecode(response.body);

    final rate = data['rates'][_toCurrency];
    final amount = double.parse(_controller.text);
    final result = amount * rate;

    setState(() {
      _result = '${result.toStringAsFixed(2)} $_toCurrency';
    });
  }

  bool A = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width / 0.7,
              decoration: BoxDecoration(
                // color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color:
                          (Provider.of<ThemeController>(context, listen: true)
                                  .t
                                  .isDark)
                              ? Colors.deepOrange
                              : Colors.greenAccent,
                      blurRadius: 1,
                      spreadRadius: -2),
                  const BoxShadow(
                      color: Colors.white38, blurRadius: 40, spreadRadius: -20),
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 100,
                          child: DropdownButton<String>(
                            value: _fromCurrency,
                            items: _currencies.map((currency) {
                              return DropdownMenuItem(
                                alignment: Alignment.center,
                                value: currency,
                                child: Text(currency),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _fromCurrency = value!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 160,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            height: 25,
                            width: 300,
                            child: TextFormField(
                              controller: _controller,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(
                                    // borderSide: BorderSide(color: Colors.green),
                                    // borderRadius: BorderRadius.circular(15),
                                    ),
                                hintText: 'Enter amount',
                                // labelText: 'Amount',
                                // focusColor: Colors.green,
                                // fillColor: Colors.amber,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width / 0.7,
              decoration: BoxDecoration(
                // color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color:
                          (Provider.of<ThemeController>(context, listen: true)
                                  .t
                                  .isDark)
                              ? Colors.deepOrange
                              : Colors.greenAccent,
                      blurRadius: 1,
                      spreadRadius: -2),
                  const BoxShadow(
                      color: Colors.white38, blurRadius: 40, spreadRadius: -20),
                ],
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // SizedBox(width: 40,),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Select Convert Currency",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      children: [
                        DropdownButton<String>(
                          value: _toCurrency,
                          items: _currencies.map((currency) {
                            return DropdownMenuItem(
                              value: currency,
                              child: Text(currency),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _toCurrency = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        (_controller.text.isNotEmpty)
                            ? Text(
                                _result,
                                style: const TextStyle(fontSize: 20),
                              )
                            : const Text(
                                "Result",
                                style: TextStyle(fontSize: 20),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                (Provider.of<ThemeController>(context, listen: true).t.isDark)
                    ? Colors.deepOrangeAccent
                    : Colors.greenAccent,
              ),
            ),
            onPressed: _convertCurrency,
            child: const Text(
              'Convert',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
