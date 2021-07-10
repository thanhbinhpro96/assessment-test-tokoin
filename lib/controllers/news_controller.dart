import 'package:assessment_test_tokoin/models/category.dart';
import 'package:assessment_test_tokoin/models/news.dart';
import 'package:assessment_test_tokoin/services/news_service.dart';
import 'package:assessment_test_tokoin/settings/const.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class NewsController extends ControllerMVC {
  factory NewsController([StateMVC? state]) => _this ??= NewsController._(state);
  NewsController._(StateMVC? state) : super(state);
  static NewsController? _this;
  
  int currentPage = 1;
  int totalPages = 1;
  Category currentCategory = newsCategories.first;
  bool isLoadingMore = false;
  bool isLoading = false;
  List<News> newsList = [];
  ScrollController listScrollController = ScrollController();

  // Get news list
  void getNewsList() {
    setState(() {
      isLoading = true;
      currentPage = 1;
      newsList.clear();
    });
    Future.delayed(const Duration(seconds: 1));
    NewsService().fetchNewsListByKeyword(keyword: currentCategory.keyword, page: currentPage, setTotalPage: (_pages) {
      setState(() => totalPages = _pages);
    }).then((_list) {
      newsList.addAll(_list);
      setState(() => isLoading = false);
    });
  }

  // Load more news
  void getMoreNewsList() {
    if(currentPage < totalPages) {
      setState(() {
        currentPage++;
        isLoadingMore = true;
      });
      NewsService().fetchNewsListByKeyword(keyword: currentCategory.keyword, page: currentPage).then((_list) {
        for (var _item in _list) {
          newsList.add(_item);
        }
        setState(() => isLoadingMore = false);
      });
    }
  }

  // Switch tab
  void switchTab(Category _category) {
    setState(() {
      currentCategory = _category;
      isLoading = true;
    });
  }
}