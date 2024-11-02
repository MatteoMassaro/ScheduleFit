import 'package:flutter/foundation.dart';

class PageProvider extends ChangeNotifier {
  String _paginaCorrente = '';

  PageProvider(this._paginaCorrente);

  String get paginaCorrente => _paginaCorrente;

  void setCurrentPage(String page) {
    _paginaCorrente = page;
    notifyListeners();
  }
}
