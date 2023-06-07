import 'package:flutter/material.dart';

class CommentView extends StatefulWidget {
  const CommentView({super.key});

  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comments"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Positioned(top: 400,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _textEditingController,
                  cursorColor: Colors.black,
                  maxLength: 20,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
