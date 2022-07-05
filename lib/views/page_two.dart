import 'package:flutter/material.dart';
import 'package:flutter_2/controllers/posts_controller.dart';
import 'package:flutter_2/widgets/custom_button_widget.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  final PostsController _controller = PostsController();

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
            _controller.posts.value.isNotEmpty
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
                : CustomButton(
                    onPressed: () => _controller.callAPI(), title: 'Get Data'),
            AnimatedBuilder(
              animation: Listenable.merge(
                [_controller.posts, _controller.isLoading],
              ),
              builder: (_, __) => _controller.isLoading.value
                  ? Container(
                      padding: const EdgeInsets.all(10),
                      child: const CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _controller.posts.value.length,
                      itemBuilder: (_, i) => ListTile(
                        title: Text(_controller.posts.value[i].title),
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
