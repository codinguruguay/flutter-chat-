import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  final List<ChatMessage> _messages = [];

  bool _writing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1.0,
          title: Column(
            children: [
              CircleAvatar(
                maxRadius: 14.0,
                backgroundColor: Colors.blueAccent.shade200,
                child: const Text('MV', style: TextStyle(fontSize: 12)),
              ),
              const SizedBox(height: 3.0),
              const Text(
                'Martín Verde',
                style: TextStyle(color: Colors.black, fontSize: 11.0),
              )
            ],
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Flexible(
                child: ListView.builder(
                    itemCount: _messages.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (_, i) => _messages[i],
                    reverse: true)),
            const Divider(height: 1.0),
            //caja de texto para escribir mensajes
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ));
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
              child: TextField(
            controller: _textController,
            onSubmitted: _handleSubmit,
            onChanged: (String text) {
              setState(() {
                if (text.trim().isNotEmpty) {
                  _writing = true;
                } else {
                  _writing = false;
                }
              });
            },
            decoration:
                const InputDecoration.collapsed(hintText: 'Escribir mensaje'),
            focusNode: _focusNode,
          )),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Platform.isIOS
                ? CupertinoButton(
                    onPressed: _writing
                        ? () => _handleSubmit(_textController.text.trim())
                        : null,
                    child: const Text('Enviar'))
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconTheme(
                      data: const IconThemeData(color: Colors.blue),
                      child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: _writing
                              ? () => _handleSubmit(_textController.text.trim())
                              : null,
                          icon: const Icon(Icons.send)),
                    ),
                  ),
          )
        ],
      ),
    ));
  }

  _handleSubmit(String text) {
    if (text.isEmpty) return;

    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      text: text,
      uid: '123',
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 300)),
    );

    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _writing = false;
    });
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }

    super.dispose();
  }
}
