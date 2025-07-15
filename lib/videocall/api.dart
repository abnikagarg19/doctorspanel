import 'dart:convert';
import 'package:http/http.dart' as http;

//Auth token we will use to generate a meeting and connect to it
String token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiI3NmQxZjQ2NC05YWIwLTQ4ZTAtOWFiMC05MGU2ODVlMjI1ZDgiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTc0NzM5MzA5NiwiZXhwIjoxNzU1MTY5MDk2fQ.kdRxOkrNtkFIvWlMk7lPHsYySJZHH72rdRZAeUCJUkI";

// API call to create meeting
Future<String> createMeeting() async {
  final http.Response httpResponse = await http.post(
    Uri.parse("https://api.videosdk.live/v2/rooms"),
    headers: {'Authorization': token},
  );

  final responseBody = json.decode(httpResponse.body);
  String meetingId = responseBody['roomId'];

  // Print the Meeting ID for debugging
  print("Generated Meeting ID: $meetingId");

  return meetingId;
}

