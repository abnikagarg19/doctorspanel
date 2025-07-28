import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:path_provider/path_provider.dart';


class AWSIoTService {
  late MqttBrowserClient client;
  Function(String message)? onMessageReceived;

  Future<void> connect(String topic) async {
    const String host =
        "wss://a1t8p573k2ghg7-ats.iot.ap-south-1.amazonaws.com/mqtt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA42OTEBJ4OMDOGW2X%2F20250728%2Fap-south-1%2Fiotdevicegateway%2Faws4_request&X-Amz-Date=20250728T111616Z&X-Amz-SignedHeaders=host&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEGMaCmFwLXNvdXRoLTEiSDBGAiEA2b2VQpG4raJ3xHKKYhMFtNIWC50%2FRlUKMYVkZQrvbl0CIQCoA6K0%2F7mnpVu0wpYVx8D3pUcS6qWCSNcjFa4F1LUjYyq7BQiM%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F8BEAAaDDg4MTQ0NzkzMDQ4OCIMtzlMaXkEse5IzaopKo8FXYRq8B6%2BvUkNQoV7U41uXxivNNKTP1OmcPd9Gh8f5Y6xANBV1NiJj7P5P3n%2FU4VB%2FVnO1Y1tjur3bNROU7lnNOEo9GU0IKJwubDeXvhN9tLJOqFhG8nfa5%2BZSQnRV31QBBsiAlSZEkaywzEXN3SfXsUJlR1eFD3uESncJAcx0U8jia03ibD2vlQ07Z6lXow1VChVMAO7KZ99VfMIFz1LYF7TCwZMsRNGDcXn33g6xrwLxHWs7s5iHq2UdkfxbDJqs9ihI5RcvKp1huXiUeUMm%2B%2BRgKPYi8fUhYgVMU%2FLL3nRx9NL1QlTCl0YCHbj6gM%2FLuGtDSRFC557dTRHpDroOXV%2BP7E699a%2Bft2mZDNhtbiKtsq6UZipFnW1BBbUwZUCItTP%2BZx7II%2FqCb5fTNmoZJJSXAx3E52gVDv9GCmAikRuBpDOTm3k4me9O7rO0oMS5n6NJyZIlf5wh6Mqom5yVIvukn9JeHummTakTYWbKiqM7bisRr3heFoHAUVLx78fO%2BgceJSP6Kxhm3isl4PZJ5Oo1gzdHPHOzM1SVoeuiqburUwTurxwekawvq6HVtsyqqiZXn%2B%2B8FQfoVkbdYsMJ37r1y%2BhbHYIleknio9OoPfUOq8qSSqJ14x6SKpkO3xTXQrNSfsK4gOw8yBOyb4xyteMHFckli2fI7Z8I2gzGtLWFZbMlUOl%2BrmMFy9cmvq8sGGQFB%2BCNBwu%2FI4Fr7wLWYs3c%2FVkvH5nE0Q3JJmjq2ikvtTKHPersPceCtHyAodig2n4a64JaYwETMIX6k8aso9Zr265%2B%2BdcSmeoyC1iwBwlIWxAruxw8E5Ma2DoKqxAViBXS%2F3ErWlfAb1%2FQMOHHyWELM6rT%2BegbO3KDXcpGzCAuJ3EBjrbAtFzZyE2E%2B3f5WvCP5u%2FDnmq4qwxao9MrnkOn4eAiY%2Bei0pxCGb1KN48JCh2O%2BCq9Vkw3D%2Be3s0YLX%2B7xwKbHuq5hYFF1klFiYZ6BtHxt%2B6ST84Bh91A4T4btGxzKcWXHdWQ7P4ZrK1oKDon15NePL5dHeOMF4ZvGeAwto9OewXE%2BRioyA1dQ0aXj%2BxQ9INKRpwo57uDs5gu5P%2F2OOZ6vcT55F9aRIR%2BS9r3ev%2FtllYniDHmkF5Bo2jYlzziPvamZsLjDcuLef8q%2FgnjyX8cYC0ApYFPSEz8kN%2BbTZVlBfiB8QEPU01Y3CUx5AQkFG6uzie1cG9O%2BbDh2Go%2BQCa%2BPU37onKkuY1KhN6ksnWEiVgSJzpdUeoJH0URmuXc1VT%2FmtT0J0yWhLkbKf7e0ukPqeHwHa8wvhDxpLgcXs0IRuPWnklikYhdlYh0ZbnOFI6L%2Btbf%2BDUj3gqzadYE&X-Amz-Signature=3d16b4ba154accce400dcb7c959d68df275d14882bb5fae39fc68dbdaa29e1c5"; // e.g., a1b2c3d4e5f6g7-ats.iot.ap-south-1.amazonaws.com
    // const int port = 8883;
final clientId = 'flutter-client-${DateTime.now().millisecondsSinceEpoch}';
 client = MqttBrowserClient(host, clientId,);
client.websocketProtocols = ['mqtt'];
  // Configure client properties

client.port = 443; // for wss
client.logging(on: true);
   client.setProtocolV311(); // <-- This sets protocol name to MQTT and version to 4

    //client.logging(on: false);
    ByteData rootCa =
        await rootBundle.load('assets/aws_jul_25/AmazonRootCA1.pem');
    ByteData deveicCrt = await rootBundle.load(
        'assets/aws_jul_25/2538f8d29c441136f25f93c4026690bad9c5ed6b6e1224565f78f1ca6aa70c2b-certificate.pem.crt');
    ByteData provateKey = await rootBundle.load(
        'assets/aws_jul_25/2538f8d29c441136f25f93c4026690bad9c5ed6b6e1224565f78f1ca6aa70c2b-private.pem.key');

    // final context = SecurityContext.defaultContext;
    // context.useCertificateChainBytes(deveicCrt.buffer.asUint8List());
    // context.usePrivateKeyBytes(provateKey.buffer.asUint8List());
    // context.setClientAuthoritiesBytes(rootCa.buffer.asUint8List());

    //client.securityContext = context;
   

    client.onConnected = () => print('✅ Connected');
    client.onDisconnected = () => print('❌ Disconnected');
    client.onSubscribed = (t) => print('🔔 Subscribed to $t');

    try {
      final connMessage = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .startClean(); // or .withCleanSession(false) if needed
    client.connectionMessage = connMessage;

    await client.connect(); // 🔄 Async connect
    print('✅ Connected to AWS IoT');
    } catch (e) {
      print('Connection error: $e');
      client.disconnect();
      return;
    }

    client.subscribe("ecg_data/stethoscope", MqttQos.atMostOnce);
    // client.subscribeBatch([
    //   BatchSubscription(topic, MqttQos.atMostOnce),
    //   BatchSubscription("audio/raw-data", MqttQos.atMostOnce)
    // ]);
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> messages) {
      final recMsg = messages[0].payload as MqttPublishMessage;
      final message =
          MqttPublishPayload.bytesToStringAsString(recMsg.payload.message);
      print('📥 Message received: $message');

      if (onMessageReceived != null) {
      //  / streamPcmChunk(message);
        onMessageReceived!(message);
      }
    });
    //   for (final msg in messages) {
    //     final topic = msg.topic;
    //     final recMsg = msg.payload as MqttPublishMessage;
    //     final payload =
    //         MqttPublishPayload.bytesToStringAsString(recMsg.payload.message);

    //     print('📥 Topic: $topic');
    //     print('📦 Payload: $payload');

    //     if (onMessageReceived != null) {
    //       if (topic == 'audio/raw-data') {
    //         playBase64Audio(payload);
    //       }
    //       // Optionally include topic in the callback
    //       onMessageReceived!('[$topic] $payload');
    //     }
    //   }
    // });
  }

  bool _isPlayerInited = false;

  //final FlutterSoundPlayer _player = FlutterSoundPlayer();
  Future<void> initPlayer() async {
  //  try {
     /// await _player.openPlayer();
      // await _player.startPlayerFromStream(
      //   codec: Codec.pcm16io,
      //   numChannels: 1,
      //   sampleRate: 44100,
      //   bufferSize: 4096,
      //   interleaved: false,
      
      // );

      // Add stream data
      // ... (e.g., from a network request) ...
      // _mPlayer.foodSink?.add(yourAudioData);
    // } catch (e) {
    //   print("Error playing from stream: $e");
    // }
    // if (!_isPlayerInited) {
    //   print("🟡 Opening player...");
    //   await _player.openPlayer();
    //   print("🟢 Player opened!");
    //   await _player.startPlayerFromStream(
    //     codec: Codec.pcm16,
    //     numChannels: 1,
    //     sampleRate: settings.sampleRate,
    //     bufferSize: 4096,
    //     interleaved: false,
    //   );
    //   _isPlayerInited = true;
    // }
  }

  // Call this for each new message from MQTT
//   Future<void> streamPcmChunk(base64Chunk) async {
//  ///   if (!_isPlayerInited) await initPlayer();
//     final decodedJson = jsonDecode(base64Chunk);
//     final base64Audio = decodedJson['audio_chunk'] as String;
//     final pcmBytes = base64Decode(base64Audio);
//     _player.foodSink?.add(FoodData(pcmBytes));
//   }

// // Cleanup when done
//   Future<void> stopStreamPlayback() async {
//     await _player.stopPlayer();
//     await _player.closePlayer();
//     _isPlayerInited = false;
//   }
}

class IoTDashboard extends StatefulWidget {
  const IoTDashboard({Key? key}) : super(key: key);

  @override
  State<IoTDashboard> createState() => _IoTDashboardState();
}

class _IoTDashboardState extends State<IoTDashboard> {
  final AWSIoTService _awsIoTService = AWSIoTService();
  String message = 'Waiting for message...';

  final String topic =
      'ecg_data/stethoscope'; // 🔁 Replace with your topic name

  @override
  void initState() {
    super.initState();
    _awsIoTService.initPlayer();
    _awsIoTService.onMessageReceived = (msg) {
      setState(() {
        message = msg;
      });
    };

    _awsIoTService.connect(topic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: GestureDetector(
              onTap: () {}, child: const Text('AWS IoT Viewer'))),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            message,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}