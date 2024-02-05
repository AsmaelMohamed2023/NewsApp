import 'package:dio/dio.dart';
import 'package:news_app/models/article_model.dart';

class NewsService {
  final Dio dio;

  NewsService(this.dio);
  //مثال عن كل الاخبار العربية والمصرية من api
  Future<List<ArticleModel>> getNews() async {
    //لطلب الريكوست
    try {
      Response response = await dio.get(
          'https://newsapi.org/v2/top-headlines?country=us&apiKey=4a698d2958594812a520f9dce1e3bd20');
      //لاستخراج الداتا من الريسبوني
      Map<String, dynamic> jsonData = response.data;
      //لاستخراج المقلات نفسها من api
      List<dynamic> articles = jsonData["articles"];
      List<ArticleModel> articlesList = [];
      for (var article in articles) {
        ArticleModel articleModel = ArticleModel(
          image: article['urlToImage'],
          title: article['title'],
          subTitle: article['description'],
        );
        articlesList.add(articleModel);
      }
      return articlesList;
    } on Exception {
      return [];
    }
  }
}
