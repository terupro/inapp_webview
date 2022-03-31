import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_view/provider.dart';
import 'package:web_view/web_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _provider = ref.watch(provider.notifier);
    final valueController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('InApp Browser'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: valueController,
                onChanged: (value) {
                  _provider.state = value; // 入力した内容を取得する
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (valueController.text == "") {
                    showOkAlertDialog(
                      context: context,
                      title: 'URLを入力してください',
                    );
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => WebPage()));
                  }
                },
                child: const Text('Open Website'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
