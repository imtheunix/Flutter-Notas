import 'package:djangoapp/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UpdatePage extends StatefulWidget {
  final Client client;
  final int id;
  final String nota;
  const UpdatePage({
    Key? key,
    required this.client,
    required this.id,
    required this.nota,
  }) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController controller = TextEditingController();

  initState() {
    controller.text = widget.nota;
    super.initState();
  }

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
            maxLines: 10,
          ),
          ElevatedButton(
              onPressed: () {
                widget.client.put(
                    Uri.parse(retrieveUrl + '$widget.id' '/modificar/'),
                    body: {'body': controller.text});
                Navigator.pop(context);
              },
              child: Text("Modificar nota")),
        ],
      ),
    );
  }
}
