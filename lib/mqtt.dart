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
        "wss://a1t8p573k2ghg7-ats.iot.ap-south-1.amazonaws.com/mqtt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA42OTEBJ4MUH5PN55%2F20250728%2Fap-south-1%2Fiotdevicegateway%2Faws4_request&X-Amz-Date=20250728T135136Z&X-Amz-SignedHeaders=host&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEGYaCmFwLXNvdXRoLTEiRjBEAiBJqGyDdbbxyyiFTPbceRu8a%2FFgofMHHY58o9W42zbh4QIgIP876tOpPOWsPAdvkjnU7GjlSUfVAavMQMeQdRbGuKkquQUIj%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARAAGgw4ODE0NDc5MzA0ODgiDHh%2FAhOWmg8FdLIyfyqNBbVsKB48N%2FUqJctGmrZ3WkwCY%2BiL51YVF9d3%2BaCJHxycNwnWnaOVg6MCBO3AIj67Ar6bDQ2Kr%2FE49JrMH7ntYUSyoAImveSSvZf6NL6LaXoEeA6PFzu9yuLhNzxvdyc4BxcWSwp4r%2Fiaa4Y5NqKndBixOV%2Fu9T3msQqJeDpYKFIgPYfegGvgT1%2B0kIlEf1Zv9JFWga1d7rqh%2FnDUQAmNUxWArBPSoUfLE3nL5YGbqaC8VeQ8aQmhWb1KbA4h3pklk16gKrR%2BXACNdI4QeB3jNCPqkTz9Q18TscvrODb30yCGrvnpDU%2FIMLsH8MFjQBOeAl2Lqs4yzpjcjLWRB%2FieEHRWi56dYyWZ1JVClLR5cZDMmsQZvW3DOxi%2BpGebAxUQqV1UdTjPBrDG%2FnyJ4oJmd%2B4vNW1%2FGsGIYFw4gFMpPKrMZ8MS8Wg2Ls%2BhQf8vLcFXMedTReN9zxnwtzs7ymY6VMUW6mxCoL2qterkUDTFMrMaH2pNx0RX98ksfLsZe1q2NUHs5BpG7psSpY3NJs7jNRRcigQc3M9qAzESJWIRaBvkKT1hH6M3MD5s%2BTnY13RZHC1EU9kHu989DMCD0O%2FmrbcnNEJPtispBUeoudnfn6iDJrbE3ze8ewb7EGdRs%2FL5%2F5UVIxM3Gd7NQhVe2XP08BGqjORaRJ%2BRVLK2IFdwWpOVRLBksXViEXaxC9zA5QwE4EZfCNkX%2BqrGhuKnB1qEpdBj5Xhek7oufbmbEaF9o7MQQgaOdipGNmoja0Th8bbawKyV1uggt2Ad%2BOEJNFq%2Bw%2FPn7mAQJ0wc1l7dA%2BRfC35UBjTVkBy5RFuUU7c%2FXKukNNKgyKWkGON0VvGXlOzw6fF5TKhOBh9o6i%2BvT1pxMOiAnsQGOt8CmLLVflV6dsp%2BdZgcQ625r%2Fy%2FU4wE7zryd15FWYsFJDAlPe%2BI3%2FHKl9oyT0Sbi2ep%2BOaWB6z6cZPI%2Bb0azX319GgkZu%2BE%2FkNK4%2B6h6fQAQoXh38Tw8kGIg0rgHjgzJPkajzt%2F0o4jGcZK8WXZo59NCdk%2BBM0GCQMTAva5gDx34IUWm%2Bznn42eGzekHK6BeKCYKIukdAKVB1QHPQ0LASh44k1V0pMoBudtaeaDavX2tjsq3gkAPzhrbDFkVO3sW%2BnJKKmV%2FpDHdksM9yIIgObcIKKmK5SZuCJRyeDCSQ%2BlYvQqbSTk0M88AcQRSqwd4d5Gv0S3%2FsXPBWQPfM5wnYHnZJr6pawjIN65r8orJ9Zr%2BETfXx%2Bjm5PsxgpzDrMQBoYi6r%2BiNy4WWIONmpzyhp%2F%2BfZv%2FaWMrvaaGSWhLhZvWHPGgcMQxlEfVRdgoqf853jhcEbPfhME7rd0s2fzGWdFo&X-Amz-Signature=dc8de12ee4d09c6d8e21680f7c142cff25ca8d326c0cd9f6dc3ca2eaa9a35794";
    // const int port = 8883;
final clientId = 'flutter-client-22';
 client = MqttBrowserClient(host, clientId,);
client.websocketProtocols = ['mqtt'];
client.setProtocolV311(); 
client.keepAlivePeriod=20; 
  // Configure client properties

client.port = 443; // for wss
client.logging(on: true);
   // <-- This sets protocol name to MQTT and version to 4

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