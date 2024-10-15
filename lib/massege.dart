import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:http/http.dart' as http;
import 'dart:convert';

class MessageWidget extends StatefulWidget {
  const MessageWidget({super.key});

  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  final TextEditingController _controller = TextEditingController();
  final String _key = 'my32lengthsupersecretnooneknows1'; // 32 байта
  List<String> messages = [];
  List<String> sender = [];
  List<String> created = [];
  final ScrollController _scrollController = ScrollController();

  void _sendMessage(String message) async {
    const senderIn = 'Вы';
    const createdAt = '0.0';
    final iv = encrypt.IV.fromLength(16);
    final encrypter =
        encrypt.Encrypter(encrypt.AES(encrypt.Key.fromUtf8(_key)));

    // Шифрование сообщения
    final encrypted = encrypter.encrypt(message, iv: iv);

    // Отправка на сервер
    await http.post(
      Uri.parse('https://anchih.e-rec.ru/api/store_message.php'),
      body: json.encode({
        'message': encrypted.base64,
        'iv': iv.base64,
        'sender': '666666666',
      }),
      headers: {'Content-Type': 'application/json'},
    );

    setState(() {
      sender.add(senderIn);
      messages.add(message);
      created.add(createdAt);
    });

    // Прокрутка вниз после отправки сообщения
    _scrollToBottom();
  }

  void _fetchMessages() async {
    final response = await http
        .get(Uri.parse('https://anchih.e-rec.ru/api/get_messages.php'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonMessages = json.decode(response.body);
      for (var jsonMessage in jsonMessages) {
        final iv = encrypt.IV.fromBase64(jsonMessage['iv']);
        final encryptedMessage = jsonMessage['message'];
        final senderIn = jsonMessage['sender'];
        final createdAt = jsonMessage['created_at'];

        // Дешифрование сообщения
        final encrypter =
            encrypt.Encrypter(encrypt.AES(encrypt.Key.fromUtf8(_key)));
        final decrypted = encrypter.decrypt64(encryptedMessage, iv: iv);

        setState(() {
          sender.add(senderIn);
          messages.add(decrypted);
          created.add(createdAt);
        });
      }
    }

    // Прокрутка вниз после загрузки сообщений
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Сообшения')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(8),
                itemCount: messages.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        sender[index],
                        style:
                            const TextStyle(fontSize: 10, color: Colors.blue),
                      ),
                      subtitle: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  messages[index], // Время
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '', // Время
                                style:
                                    TextStyle(fontSize: 8, color: Colors.grey),
                              ),
                              Text(
                                created[index], // Дата
                                style: const TextStyle(
                                    fontSize: 8, color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration:
                        const InputDecoration(hintText: 'Введите сообщение..'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _sendMessage(_controller.text);
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
