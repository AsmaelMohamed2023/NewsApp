import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/widgets/news_list_veiw.dart';
import '../services/news_services.dart';

class NewsListViewBuilder extends StatefulWidget {
  const NewsListViewBuilder({
    super.key,
    required this.category,
  });
  final String category;
  @override
  State<NewsListViewBuilder> createState() => _NewsListViewBuilderState();
}

class _NewsListViewBuilderState extends State<NewsListViewBuilder> {
  // ignore: prefer_typing_uninitialized_variables
  var future;

  @override
  void initState() {
    super.initState();
    future = NewsService(Dio()).getNews(category: widget.category);
  }

  @override
  Widget build(BuildContext context) {
    //FuttereBuilder تستخدم لجلب بيانات في المستقبل
    return FutureBuilder<List<ArticleModel>>(
      future: future,
      //Snapshot تستقبل ليست بالبيانات
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return NewsListView(
            articles: snapshot.data ?? [],
          );
        } else if (snapshot.hasError) {
          return const SliverToBoxAdapter(
            child: Text('OOPS thre was an error, try latter'),
          );
        } else {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
