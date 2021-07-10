import 'dart:convert';

import 'package:assessment_test_tokoin/models/news.dart';
import 'package:assessment_test_tokoin/settings/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class NewsService {

  // Fetch headlines from API
  Future<List<News>> fetchHeadlineList({int page = 1, ValueChanged<int>? setTotalPage}) async {
    var url = Uri.parse("$API_URL/top-headlines");
    Map<String, dynamic> params = {
      "apiKey": API_KEY,
      "country": "us",
      "pageSize": "10",
      "page": "$page"
    };
    var response = await http.get(url.replace(queryParameters: params));
    Map<String, dynamic> responseJson = json.decode(response.body);
    // If the call is successful, return news list
    if(responseJson["status"] == "ok") {
      List<News> resultList = [];
      if(setTotalPage != null) {
        setTotalPage((responseJson["totalResults"]/10 as double).ceil());
      }
      responseJson["articles"].forEach((_item) {
        resultList.add(News.fromJson(_item));
      });
      return resultList;
    }
    // If failed, return empty list
    return [];
  }

  // Fetch news by keyword from API
  Future<List<News>> fetchNewsListByKeyword({int page = 1, required String keyword, ValueChanged<int>? setTotalPage}) async {
    var url = Uri.parse("$API_URL/everything");
    Map<String, dynamic> params = {
      "apiKey": API_KEY,
      "q": keyword,
      "pageSize": "10",
      "page": "$page"
    };
    var response = await http.get(url.replace(queryParameters: params));
    Map<String, dynamic> responseJson = json.decode(response.body);
    // If the call is successful, return news list
    if(responseJson["status"] == "ok") {
      List<News> resultList = [];
      if(setTotalPage != null) {
        setTotalPage((responseJson["totalResults"]/10 as double).ceil());
      }
      responseJson["articles"].forEach((_item) {
        resultList.add(News.fromJson(_item));
      });
      return resultList;
    }
    // If failed, return empty list
    return [];
  }

}