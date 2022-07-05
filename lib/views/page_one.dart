import 'package:flutter/material.dart';
import 'package:flutter_2/widgets/custom_button_widget.dart';
import 'dart:math';

class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  final ValueNotifier<int> _randomValue = ValueNotifier<int>(0);

  void randomize() async {
    for (int i = 0; i < 10; i++) {
      await Future.delayed(const Duration(seconds: 1));
      _randomValue.value = Random().nextInt(100000);
    }
  }

  @override
  // ignore: unused_element
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder(
              valueListenable: _randomValue,
              builder: (_, targetValue, __) => Text(
                'The value is: $targetValue',
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/pageTwo', arguments: 'test');
              },
              title: 'Go to second page',
              isDisabled: false,
            ),
          ],
        ),
      ),
    );
  }
}
