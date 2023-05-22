import 'package:flutter/material.dart';

import 'mqtt.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var textEditingController = TextEditingController();
  MqttHandler mqttHandler = MqttHandler();

  @override
  void initState() {
    super.initState();
    mqttHandler.connect(mqttHandler.myTopic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Text("Hello ${mqttHandler.myTopic}"),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: textEditingController,
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                mqttHandler.publishMessage(textEditingController.text, mqttHandler.otherTopic);
              },
              child: Text("Send")),
          const SizedBox(
            height: 10,
          ),
          ValueListenableBuilder<String>(
            builder: (BuildContext context, String value, Widget? child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(value,
                      style: const TextStyle(
                          color: Colors.deepPurpleAccent, fontSize: 35))
                ],
              );
            },
            valueListenable: mqttHandler.data,
          )
        ],
      )),
    );
  }
}
