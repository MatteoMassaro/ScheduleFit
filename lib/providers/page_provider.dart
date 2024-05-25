import 'package:flutter/foundation.dart';

class PageProvider extends ChangeNotifier {
  String _currentPage = '';

  PageProvider(this._currentPage);

  String get currentPage => _currentPage;

  void setCurrentPage(String page) {
    _currentPage = page;
    notifyListeners();
  }
}
