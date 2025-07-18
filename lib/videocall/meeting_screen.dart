import 'package:chatbot/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:videosdk/videosdk.dart';

import '../../../../videocall/participant.dart';
import '../components/multiline_textbox.dart';
import '../theme/apptheme.dart';

class MeetingScreen extends StatefulWidget {
  final String meetingId;
  final String token;

  const MeetingScreen(
      {super.key, required this.meetingId, required this.token});

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  late Room _room;
  bool micEnabled = true;
  bool camEnabled = true;
  String selectedTab = "vitals";
  Map<String, Participant> participants = {};

  @override
  void initState() {
    super.initState();

    // Create and join room
    _room = VideoSDK.createRoom(
      roomId: widget.meetingId,
      token: widget.token,
      displayName: "Doctor",
      micEnabled: micEnabled,
      defaultCameraIndex: 1,
      camEnabled: camEnabled,
    );

    setMeetingEventListener();
// _room.join();
  }

  void setMeetingEventListener() {
  _room.on(Events.roomJoined, () {
  setState(() {
    participants[_room.localParticipant.id] = _room.localParticipant;
  });

  // 🔁 Listen to own stream updates (optional)
  _room.localParticipant.on(Events.streamEnabled, (Stream stream) {
    setState(() {});
  });
});

     _room.on(Events.participantJoined, (Participant participant) {
      setState(() {
        participants[participant.id] = participant;
      });

      participant.on(Events.streamEnabled, (_) => setState(() {}));
      participant.on(Events.streamDisabled, (_) => setState(() {}));
    });

    _room.on(Events.participantLeft, (String participantId) {
      setState(() {
        participants.remove(participantId);
      });
    });

    _room.on(Events.roomLeft, () {
      participants.clear();
      Navigator.pop(context);
    });

    _room.join();
  }

  Future<bool> _onWillPop() async {
    _room.leave();
    return true;
  }

  List tabsLIst = [
    "Summary",
    "Timeline",
    "Concerns",
    "Lab Results",
    "Medications"
  ];
  int selectTabs = 0;
  @override
  Widget build(BuildContext context) {
     final local = _room.localParticipant;
    final remoteParticipants = participants.values
        .where((p) => p.id != local.id)
        .toList();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(242, 246, 255, 1),
          // appBar: AppBar(
          //   title: const Text(
          //     "Doctor Appointment",
          //     style: TextStyle(fontSize: 16),
          //   ),
          //   centerTitle: true,
          //   backgroundColor: const Color.fromARGB(255, 211, 231, 248),
          //   elevation: 0,
          //   leading: IconButton(
          //     icon: const Icon(Icons.menu, color: Colors.black),
          //     onPressed: () {},
          //   ),
          // ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(children: [
              // Video Call Section
              Expanded(
                flex: 7,
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child:// participants.length > 1
                                  // ? Positioned.fill(
                                  //     child: ParticipantTile(
                                  //       key: Key(_room.localParticipant.id),
                                  //       participant: _room.localParticipant,
                                  //     ),
                                  //   )
                                  // : 
                                  // Container(
                                  //     decoration: BoxDecoration(
                                  //         color: AppTheme.blackColor),
                                  //     child: Center(
                                  //         child: Text("Waiting for join...",
                                  //             style: GoogleFonts.rubik(
                                  //                 color: AppTheme
                                  //                     .whiteBackgroundColor,
                                  //                 fontSize: 12,
                                  //                 fontWeight:
                                  //                     FontWeight.w500))),
                                  //   ),
                                
                                  ParticipantTile(
                                        key: Key(_room.localParticipant.id),
                                        participant: local,
                                      ),
                                    
                            ),
                          ),

                         if (remoteParticipants.isNotEmpty)
                          Positioned(
                            top: 16,
                            left: 16,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                width: 150,
                                height: 180,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ParticipantTile(
                                   participant: remoteParticipants.first,
                                  smallView: true,
                                ),
                              ),
                            ),
                          )
                          else
                            Positioned(
                              top: 16,
                              left: 16,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                    width: 150,
                                    height: 180,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      border: Border.all(
                                          color: AppTheme.backGround),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                        child: Text("No Video",
                                            style: GoogleFonts.rubik(
                                                color: AppTheme
                                                    .whiteBackgroundColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500)))),
                              ),
                            ),
                          Positioned(
                              top: 16,
                              right: 16,
                              child: Column(
                                children: [
                                  Container(
                                    width: 100,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color:
                                            Color.fromRGBO(244, 244, 244, 0.7)),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/images/temp.png",
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text("Temperature",
                                            style: GoogleFonts.rubik(
                                                color: AppTheme.blackColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500)),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text("100",
                                            style: GoogleFonts.rubik(
                                                color: Color.fromRGBO(
                                                    237, 70, 57, 1),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    width: 100,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color:
                                            Color.fromRGBO(244, 244, 244, 0.7)),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/images/heart.png",
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text("Pulse Rate",
                                            style: GoogleFonts.rubik(
                                                color: AppTheme.blackColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500)),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text("76 BPM",
                                            style: GoogleFonts.rubik(
                                                color: Color.fromRGBO(
                                                    54, 166, 29, 1),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    width: 100,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color:
                                            Color.fromRGBO(244, 244, 244, 0.7)),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/images/lings.png",
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text("SPO2",
                                            style: GoogleFonts.rubik(
                                                color: AppTheme.blackColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500)),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text("76 %",
                                            style: GoogleFonts.rubik(
                                                color: Color.fromRGBO(
                                                    54, 166, 29, 1),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    width: 100,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color:
                                            Color.fromRGBO(244, 244, 244, 0.7)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/BP (1).png",
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("120",
                                                style: GoogleFonts.rubik(
                                                    color: Color.fromRGBO(
                                                        54, 166, 29, 1),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            SizedBox(
                                              width: 6,
                                            ),
                                            Text("SYS",
                                                style: GoogleFonts.rubik(
                                                    color: AppTheme.blackColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("60",
                                                style: GoogleFonts.rubik(
                                                    color: Color.fromRGBO(
                                                        54, 166, 29, 1),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            SizedBox(
                                              width: 6,
                                            ),
                                            Text("DIA",
                                                style: GoogleFonts.rubik(
                                                    color: AppTheme.blackColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    width: 100,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color:
                                            Color.fromRGBO(244, 244, 244, 0.7)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Blood\nSugar",
                                                style: GoogleFonts.rubik(
                                                    color: AppTheme.blackColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("140mg/dL",
                                                style: GoogleFonts.rubik(
                                                    color: Color.fromRGBO(
                                                        54, 166, 29, 1),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )),
                          // Meeting Controls
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                _controlButton(
                                  micEnabled ? Icons.mic : Icons.mic_off,
                                  micEnabled ? Colors.grey : Colors.red,
                                  () {
                                    micEnabled
                                        ? _room.muteMic()
                                        : _room.unmuteMic();
                                    setState(() => micEnabled = !micEnabled);
                                  },
                                ),
                                const SizedBox(width: 20),
                                _controlButton(
                                  camEnabled
                                      ? Icons.videocam
                                      : Icons.videocam_off,
                                  camEnabled ? Colors.grey : Colors.red,
                                  () {
                                    camEnabled
                                        ? _room.disableCam()
                                        : _room.enableCam();
                                    setState(() => camEnabled = !camEnabled);
                                  },
                                ),
                                const SizedBox(width: 20),
                                _controlButton(Icons.call_end, Colors.red, () {
                                  _room.leave();
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InputTextFieldMaxlines(
                            //  textEditingController: _controller.body1,
                            hintText: "Medecins:",
                            counterText: "1000",

                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                            maxLines: 6,
                            maxlength: 1000,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: InputTextFieldMaxlines(
                            //  textEditingController: _controller.body1,
                            hintText: "Complete transcribe:",
                            counterText: "1000",

                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                            maxLines: 6,
                            maxlength: 1000,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 20),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Patient Summary",
                        style: GoogleFonts.rubik(
                            color: Color.fromRGBO(54, 100, 188, 1),
                            fontSize: Constant.subHeading(context),
                            fontWeight: FontWeight.w700)),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: List.generate(
                        tabsLIst.length,
                        (index) {
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectTabs = index;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                    color: selectTabs == index
                                        ? Color.fromRGBO(60, 150, 255, 1)
                                        : AppTheme.whiteTextColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromARGB(
                                            132, 149, 147, 147),
                                        spreadRadius: 1,
                                        offset: const Offset(0, 6),
                                        blurRadius: 10,
                                      )
                                    ],
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    )),
                                child: Center(
                                  child: Text("${tabsLIst[index]}",
                                      style: GoogleFonts.rubik(
                                          color: selectTabs == index
                                              ? Color.fromRGBO(255, 255, 255, 1)
                                              : Color.fromRGBO(
                                                  142, 142, 142, 1),
                                          fontSize:
                                              Constant.verysmallbody(context),
                                          fontWeight: FontWeight.w500)),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 255, 255, 1),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text("Patient name: Raj Kumar",
                                            style: GoogleFonts.rubik(
                                                color: AppTheme.blackColor,
                                                fontSize: Constant.twetysixtext(
                                                    context),
                                                fontWeight: FontWeight.w700)),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                            "23y old male patient presents with a mild-grade febrile illness accompanied by a productive cough yielding white, odorless, non-blood-tinged sputum. Symptoms have been gradual in onset, with no associated chills, dyspnea, chest pain, or systemic complaints. There is no past medical history suggestive of diabetes, hypertension, thyroid dysfunction, or tuberculosis. Personal and lifestyle history are unremarkable.",
                                            style: GoogleFonts.quicksand(
                                                color: AppTheme.blackColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500)),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text("Symptoms:",
                                            style: GoogleFonts.rubik(
                                                color: AppTheme.blackColor,
                                                fontSize:
                                                    Constant.smallbody(context),
                                                fontWeight: FontWeight.w700)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            """Pain: A headache, back pain, stomachache.
Fatigue: Feeling unusually tired or weak.
Nausea: Feeling sick to your stomach, with an urge to vomit.
Fever: An elevated body temperature.
Muscle aches: Pain or soreness in the muscles.
Coughing: A reflex action to clear the airways.
Night sweats: Excessive sweating during sleep.
""",
                                            style: GoogleFonts.quicksand(
                                                color: AppTheme.blackColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 80,
                                  ),
                                  Image.asset("assets/images/full_body.png")
                                ],
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //   children: [
                              //     _infoButton(
                              //         "Patient Vitals", selectedTab == "vitals", () {
                              //       setState(() => selectedTab = "vitals");
                              //     }),
                              //     _infoButton(
                              //         "Patient Summary", selectedTab == "summary",
                              //         () {
                              //       setState(() => selectedTab = "summary");
                              //     }),
                              //   ],
                              // ),
                              // const SizedBox(height: 20),
                              // Expanded(
                              //     child: selectedTab == "vitals"
                              //         ? PatientVitalsWidget(height, width)
                              //         : PatientSummaryWidget(height, width))
                            ])),
                  ],
                ),
              ),
              //  ],
            ]),
          ),
        ));
  }

  Widget PatientVitalsWidget(double height, double width) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width * 0.015)),
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02, vertical: height * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  _infoText("Name:", "Rajesh Kumar"),
                  SizedBox(height: 20),
                  _infoText("Age:", "52"),
                  SizedBox(height: 20),
                  _infoText("Gender:", "Male"),
                  SizedBox(height: 20),
                  _infoText(
                      "Medical History:", "Type 2 Diabetes, Hypertension"),
                  SizedBox(height: 20),
                  _infoText("Medications:", "Metformin 500 mg"),
                  SizedBox(height: 20),
                  _infoText("Surgeries:", "Appendix, Vasectomy"),
                  SizedBox(height: 20),
                  Divider(
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _infoText("Allergies:", "\nPeanut, Soy, Pollen, Dairy"),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  _infoText("Patient Summery:\n",
                      "23y old female patient presents with a mild-grade febrile illness accompanied by a productive cough yielding white, odorless, non-blood-tinged sputum. Symptoms have been gradual in onset, with no associated chills, dyspnea, chest pain, or systemic complaints. There is no past medical history suggestive of diabetes, hypertension, thyroid dysfunction, or tuberculosis. Personal and lifestyle history are unremarkable."),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget PatientSummaryWidget(double height, double width) {
    return Container(
        child: SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                vitalCard(
                  title: "Heart Rate",
                  value: "72",
                  status: "Normal",
                  bgColor: Colors.green.shade100,
                  width: width,
                  height: height,
                  cwidth: width * 0.13,
                  titleStyle: TextStyle(
                      fontSize: Constant.smallbody(Get.context!),
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  valueStyle: TextStyle(
                      fontSize: width * 0.034,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  statusStyle: TextStyle(
                      fontSize: Constant.verysmalltwelve(Get.context!),
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  iconSize: width * 0.01,
                  borderRadius: BorderRadius.circular(12),
                ),
                vitalCard(
                  title: "Blood Pressure",
                  value: "98",
                  status: "Critical",
                  bgColor: Colors.yellow.shade100,
                  width: width,
                  height: height,
                  cwidth: width * 0.13,
                  titleStyle: TextStyle(
                      fontSize: Constant.smallbody(Get.context!),
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  valueStyle: TextStyle(
                      fontSize: width * 0.034,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  statusStyle: TextStyle(
                      fontSize: Constant.verysmalltwelve(Get.context!),
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  iconSize: width * 0.01,
                  borderRadius: BorderRadius.circular(12),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                vitalCard(
                  title: "Tempreture",
                  value: "97",
                  status: "Danger",
                  bgColor: Colors.red.shade100,
                  width: width,
                  height: height,
                  cwidth: width * 0.13,
                  titleStyle: TextStyle(
                      fontSize: Constant.smallbody(Get.context!),
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  valueStyle: TextStyle(
                      fontSize: width * 0.034,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  statusStyle: TextStyle(
                      fontSize: Constant.verysmalltwelve(Get.context!),
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  iconSize: width * 0.01,
                  borderRadius: BorderRadius.circular(12),
                ),
                vitalCard(
                  title: "Oxygen",
                  value: "72",
                  status: "Normal",
                  bgColor: Colors.green.shade100,
                  width: width,
                  height: height,
                  cwidth: width * 0.13,
                  titleStyle: TextStyle(
                      fontSize: Constant.smallbody(Get.context!),
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  valueStyle: TextStyle(
                      fontSize: width * 0.034,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  statusStyle: TextStyle(
                      fontSize: Constant.verysmalltwelve(Get.context!),
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  iconSize: width * 0.01,
                  borderRadius: BorderRadius.circular(12),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Text('ECG Graph',
                style: TextStyle(
                    fontSize: Constant.smallbody(Get.context!),
                    fontWeight: FontWeight.w500)),
            SizedBox(
              height: height * 0.01,
            ),
            //  ECGGraph(),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                vitalCard(
                  title: "Cvs",
                  value: "S2 S2",
                  status: "Heared",
                  bgColor: Colors.green.shade100,
                  width: width,
                  height: height,
                  cwidth: width * 0.125,
                  titleStyle: TextStyle(
                      fontSize: Constant.verysmalltwelve(Get.context!),
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  valueStyle: TextStyle(
                      fontSize: width * 0.035,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  statusStyle: TextStyle(
                      fontSize: Constant.verysmalltwelve(Get.context!),
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  iconSize: width * 0.01,
                  borderRadius: BorderRadius.circular(12),
                  showPlayIcon: true,
                ),
                vitalCard(
                  title: "Rs",
                  value: "NVBS",
                  status: "Heared",
                  bgColor: Colors.green.shade100,
                  width: width,
                  height: height,
                  cwidth: width * 0.125,
                  titleStyle: TextStyle(
                      fontSize: Constant.verysmalltwelve(Get.context!),
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  valueStyle: TextStyle(
                      fontSize: width * 0.035,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  statusStyle: TextStyle(
                      fontSize: Constant.verysmalltwelve(Get.context!),
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  iconSize: width * 0.01,
                  borderRadius: BorderRadius.circular(12),
                  showPlayIcon: true,
                ),
              ],
            ),
          ]),
    ));
  }

  Widget vitalCard({
    required String title,
    required String value,
    required String status,
    required Color bgColor,
    required double height,
    required double width,
    double? cwidth,
    TextStyle? titleStyle,
    TextStyle? valueStyle,
    TextStyle? statusStyle,
    double? iconSize,
    BorderRadius? borderRadius,
    bool showPlayIcon = false,
  }) {
    return Container(
      width: cwidth ?? width * 0.33,
      padding: EdgeInsets.all(width * 0.01),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: borderRadius ?? BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle ??
                TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: width * 0.04,
                ),
          ),
          Text(
            value,
            style: valueStyle ??
                TextStyle(
                  fontSize: width * 0.05, // Default dynamic size
                  fontWeight: FontWeight.bold,
                ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.circle,
                size: iconSize ?? width * 0.03,
                color: status == "Danger" ? Colors.red : Colors.green,
              ),
              SizedBox(
                width: width * 0.0025,
              ),
              Text(
                status,
                style: statusStyle ??
                    TextStyle(
                      fontSize: width * 0.03,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              if (showPlayIcon) ...[
                Spacer(),
                Icon(
                  Icons.play_arrow,
                  color: Colors.black,
                  size: width * 0.012,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget infoCard(double width, double height,
      {required String title, required Widget content, double? cwidth}) {
    return Container(
      width: cwidth ?? width * 0.22,
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.03, vertical: height * 0.035),
      decoration: BoxDecoration(
        color: const Color(0xFFD9E5FF),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: Constant.twetysixtext(Get.context!),
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
          SizedBox(height: height * 0.01),
          content,
        ],
      ),
    );
  }
}

Widget _controlButton(IconData icon, Color color, VoidCallback onPressed) {
  return CircleAvatar(
    radius: 24,
    backgroundColor: color,
    child:
        IconButton(icon: Icon(icon, color: Colors.white), onPressed: onPressed),
  );
}

Widget _infoButton(String title, bool isSelected, VoidCallback onTap,
    {double? width, double? height}) {
  return TextButton(
    style: TextButton.styleFrom(
      backgroundColor: isSelected ? Colors.black : Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      minimumSize: Size(width ?? 200, height ?? 40),
    ),
    onPressed: onTap,
    child: Text(
      title,
      style: TextStyle(
        fontSize: Constant.smallbody(Get.context!),
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget _infoText(String title, String value) {
  if (!value.contains('\n')) {
    // Case: No \n → Show in a single line
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          text: "$title ",
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: value,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        textAlign: TextAlign.start,
      ),
    );
  } else {
    // Case: Contains \n → Split into multiple lines with spacing
    List<String> lines = value.split('\n');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: lines
                .map((line) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        line,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w400),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
