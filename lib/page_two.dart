import 'package:flutter/material.dart';
import 'package:flutter_2/widgets/custom_button_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_2/classes/Post.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
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

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.purple.shade100,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            posts.value.isNotEmpty
                ? Container(
                    padding: const EdgeInsets.only(top: 15),
                    child: const Text(
                      'Data: ',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colors.pink),
                    ),
                  )
                : CustomButton(onPressed: () => callAPI(), title: 'Get Data'),
            AnimatedBuilder(
              animation: Listenable.merge(
                [posts, isLoading],
              ),
              builder: (_, __) => isLoading.value
                  ? Container(
                      padding: const EdgeInsets.all(10),
                      child: const CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: posts.value.length,
                      itemBuilder: (_, i) => ListTile(
                        title: Text(posts.value[i].title),
                      ),
                    ),
            ),
            Center(
              child: CustomButton(
                  onPressed: () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop('Return');
                    }
                  },
                  title: 'Go back to page one. $args'),
            ),
          ],
        ),
      ),
    );
  }
}
