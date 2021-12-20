import 'package:djangoapp/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CreatePage extends StatefulWidget {
  final Client client;
  const CreatePage({
    Key? key,
    required this.client,
  }) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar"),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
          ),
          ElevatedButton(
              onPressed: () {
                widget.client.post(Uri.parse(retrieveUrl + 'criar/'),
                    body: {'body': controller.text});
                Navigator.pop(context);
              },
              child: Text("Criar nota")),
        ],
      ),
    );
  }
}
