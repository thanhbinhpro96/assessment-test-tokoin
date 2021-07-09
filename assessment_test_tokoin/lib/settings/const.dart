import 'package:assessment_test_tokoin/models/category.dart';

// ignore: constant_identifier_names
const String API_KEY = "02461fdec83448ba9bbc59593f413a17";
// ignore: constant_identifier_names
const String API_URL = "https://newsapi.org/v2";
const Map<String, dynamic> sampleNewsItem = {
  "source": {
    "id": "bbc-news",
    "name": "BBC News"
  },
  "author": "https://www.facebook.com/bbcnews",
  "title": "Gang behind huge cyber-attack demands \$70m in Bitcoin",
  "description": "The authors of a \"colossal\" ransomware attack demand the sum in Bitcoin in return for a key to unlock all files.",
  "url": "https://www.bbc.co.uk/news/technology-57719820",
  "urlToImage": "https://ichef.bbci.co.uk/news/1024/branded_news/4532/production/_119241771_gettyimages-645051326.jpg",
  "publishedAt": "2021-07-05T12:14:34Z",
  "content": "image copyrightGetty Images\r\nThe gang behind a \"colossal\" ransomware attack has demanded \$70m (£50.5m) paid in Bitcoin in return for a \"universal decryptor\" that it says will unlock the files of all … [+4140 chars]"
};
List<Category> newsCategories = [
  Category(
    keyword: "Bitcoin"
  ),
  Category(
    keyword: "Apple"
  ),
  Category(
    keyword: "Earthquake"
  ),
  Category(
    keyword: "Animal"
  )
];