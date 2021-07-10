import 'package:assessment_test_tokoin/pages/feeds.dart';
import 'package:assessment_test_tokoin/pages/news.dart';
import 'package:assessment_test_tokoin/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class HomeController extends ControllerMVC {
  factory HomeController([StateMVC? state]) => _this ??= HomeController._(state);
  HomeController._(StateMVC? state) : super(state);
  static HomeController? _this;
  
  // Current bottom navigation tab
  int currentTab = 0;

  // Pages list
  List<Widget> pages = [
    const FeedsPage(),
    const NewsPage(),
    const ProfilePage()
  ];

  // Switch bottom navigation tab
  void switchTab(index) {
    setState(() {
      currentTab = index;
    });
  }
}