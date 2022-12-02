import 'package:flutter/material.dart';

String lorem =
    "Lorem Ipsum, kısaca Lipsum, masaüstü yayıncılık ve basın yayın sektöründe kullanılan taklit yazı bloğu olarak tanımlanır. Lipsum, oluşturulacak şablon ve taslaklarda içerik yerine geçerek yazı bloğunu doldurmak için kullanılır.";

Map haberler = {};
List sonHaberler = [];

ScrollController mainController = ScrollController();

String myLinkedin = 'https://www.linkedin.com/company/skyloopc/';
String newsApi =
    "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=3e8768244d22445ebd4382aed8d7c5fa";
