import 'package:currency/provider/bookmark_provider.dart';
import 'package:currency/provider/theme_changer_provider.dart';
import 'package:currency/view/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'helper/api.helper.dart';

void main() async{

  await APIHelper.apiHelper.getCurrency();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeController(),
        ),
        ChangeNotifierProvider(
          create: (context) => BookMarkProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        routes: {
          '/': (context) => const HomePage(),
        },
      ),
    ),
  );
}
