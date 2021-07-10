import 'package:assessment_test_tokoin/models/news.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:assessment_test_tokoin/services/news_service.dart';

class FeedsController extends ControllerMVC {
  factory FeedsController([StateMVC? state]) => _this ??= FeedsController._(state);
  FeedsController._(StateMVC? state) : super(state);
  static FeedsController? _this;

  int currentPage = 1;
  int totalPages = 1;
  bool isLoadingMore = false;
  bool isLoading = false;
  List<News> headlineList = [];
  ScrollController listScrollController = ScrollController();

  // Get headline list
  void getHeadlineList() {
    setState(() {
      isLoading = true;
      currentPage = 1;
      headlineList.clear();
    });
    NewsService().fetchHeadlineList(page: currentPage, setTotalPage: (_pages) {
      setState(() => totalPages = _pages);
    }).then((_list) {
      headlineList.addAll(_list);
      setState(() => isLoading = false);
    });
  }

  // Load more headlines
  void getMoreHeadlineList() {
    if(currentPage < totalPages) {
      setState(() {
        currentPage++;
        isLoadingMore = true;
      });
      NewsService().fetchHeadlineList(page: currentPage).then((_list) {
        for (var _item in _list) {
          headlineList.add(_item);
        }
        setState(() => isLoadingMore = false);
      });
    }
  }
}