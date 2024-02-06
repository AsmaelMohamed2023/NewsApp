import 'package:dio/dio.dart';
import 'package:news_app/models/article_model.dart';

class NewsService {
  final Dio dio;

  NewsService(this.dio);

  // مثال عن استرجاع كل الأخبار العربية والمصرية من API
  Future<List<ArticleModel>> getNews({required String category}) async {
    // لإرسال طلب الـ request
    try {
      Response response = await dio.get(
          'https://newsapi.org/v2/top-headlines?country=us&apiKey=4a698d2958594812a520f9dce1e3bd20&category=$category');
      // لاستخراج البيانات من الاستجابة
      Map<String, dynamic> jsonData = response.data;
      // لاستخراج المقالات نفسها من API
      List<dynamic> articles = jsonData["articles"];
      List<ArticleModel> articlesList = [];
      for (var article in articles) {
        ArticleModel articleModel = ArticleModel.fromJson(article);
        articlesList.add(articleModel);
      }
      return articlesList;
    } on Exception {
      return [];
    }
  }
}
