import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_2/models/post_model.dart';

class PostsController {
  ValueNotifier<List<Post>> posts = ValueNotifier<List<Post>>([]);
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  callAPI() async {
    var client = http.Client();
    try {
      isLoading.value = true;
      var response = await client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      var decodedResponse = jsonDecode(response.body) as Iterable;
      posts.value = decodedResponse.map((e) => Post.fromJson(e)).toList();
    } finally {
      client.close();
      isLoading.value = false;
    }
  }
}
