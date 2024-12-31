import 'package:flutter/material.dart';

class PageProvider extends ChangeNotifier {
  String _paginaCorrente = '';

  PageProvider(this._paginaCorrente);

  String get paginaCorrente => _paginaCorrente;

  ///Set Current Page
  void setCurrentPage(String page) {
    _paginaCorrente = page;
    notifyListeners();
  }
}
