
import 'package:currency/modal/bookmark_modal.dart';
import 'package:currency/modal/currency_modal.dart';
import 'package:flutter/material.dart';

class BookMarkProvider extends ChangeNotifier{
  Bookmark bookmark = Bookmark(data: []);

  add({required AllCurrency allCurrency})
  {
    bookmark.data.add(allCurrency);
    notifyListeners();
  }

  remove({required AllCurrency allCurrency})
  {
    bookmark.data.remove(allCurrency);
    notifyListeners();
  }
}