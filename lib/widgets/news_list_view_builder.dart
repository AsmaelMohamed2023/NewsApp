import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/widgets/news_list_veiw.dart';

import '../models/article_model.dart';
import '../services/news_services.dart';

class NewsListViewBuilder extends StatefulWidget {
  const NewsListViewBuilder({
    super.key,
  });

  @override
  State<NewsListViewBuilder> createState() => _NewsListViewBuilderState();
}

class _NewsListViewBuilderState extends State<NewsListViewBuilder> {
  List<ArticleModel> articles = [];
  //iniitState is one do in the program
  @override
  void initState() {
    super.initState();
    getGeneralNews();
  }

  bool isLoading = true;
  Future<void> getGeneralNews() async {
    articles = await NewsService(Dio()).getNews();
    isLoading = false;
    //لكي يعمل ريبيلد للبرنامج حتي يحصل علي المعلومات
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : articles.isNotEmpty
            ? NewsListView(
                articles: articles,
              )
            : const SliverToBoxAdapter(
                child: Text('Obs Please try again'),
              );
  }
}
