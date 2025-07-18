import 'package:chatbot/controller/DoctorController.dart';
import 'package:chatbot/models/DoctorModelMeeting.dart';
import 'package:chatbot/videocall/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/apptheme.dart';
import '../utils/constant.dart';
import 'meeting_screen.dart';

class DoctorJoinScreen extends StatelessWidget {
  final _controller = Get.put<Doctorcontroller>(Doctorcontroller());

  DoctorJoinScreen({super.key});

  // void onCreateButtonPressed(BuildContext context) async {
  //   // call api to create meeting and then navigate to MeetingScreen with meetingId,token
  //   await createMeeting().then((meetingId) {
  //     if (!context.mounted) return;
  //     Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (context) => MeetingScreen(
  //           meetingId: meetingId,
  //           token: token,
  //         ),
  //       ),
  //     );
  //   });
  // }

  void onJoinButtonPressed(BuildContext context) {
    //   String meetingId = _meetingIdController.text;
    var re = RegExp("\\w{4}\\-\\w{4}\\-\\w{4}");
    // // check meeting id is not null or invaild
    // // if meeting id is vaild then navigate to MeetingScreen with meetingId,token
    // if (meetingId.isNotEmpty && re.hasMatch(meetingId)) {
    //   _meetingIdController.clear();
    //   Navigator.of(context).push(
    //     MaterialPageRoute(
    //       builder: (context) => MeetingScreen(
    //         meetingId: meetingId,
    //         token: token,
    //       ),
    //     ),
    //   );
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //     content: Text("Please enter valid meeting id"),
    //   ));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.whiteBackgroundColor,
          title: const Text('Doctor’s Dashboard'),
          titleSpacing: 30,
          centerTitle: false,
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.only(right: 20),
          //     child: GestureDetector(
          //         onTap: () {
          //           Get.back();
          //         },
          //         child: SvgPicture.asset("assets/svg/cross.svg")),
          //   ),
          // ],
        ),
        body: GetBuilder<Doctorcontroller>(builder: (controller) {
            return SingleChildScrollView(
              child: Column(children: [
                // SizedBox(
                //   height: 20,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     GestureDetector(
                //         onTap: () {
                //           Get.back();
                //         },
                //         child: SvgPicture.asset("assets/svg/cross.svg")),
                //   ],
                // ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(color: AppTheme.backGround),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Row(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            "assets/images/profile.png",
                            height: 80,
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Dr. Prashant\'s Clinic',
                              style: GoogleFonts.rubik(
                                color: AppTheme.blackColor,
                                fontSize: Constant.smallbody(context),
                                fontWeight: FontWeight.w700,
                              )),
                          SizedBox(
                            height: 2,
                          ),
                          Text('General Physician',
                              style: GoogleFonts.rubik(
                                color: AppTheme.blackColor,
                                fontSize: Constant.smallbody(context),
                                fontWeight: FontWeight.w400,
                              )),
                          SizedBox(
                            height: 2,
                          ),
                          Text("1 Appointments today",
                              style: GoogleFonts.rubik(
                                color: AppTheme.linkColor,
                                fontSize: Constant.smallbody(context),
                                fontWeight: FontWeight.w500,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
            
                SizedBox(
                  height: 20,
                ),
              //  if(controller.isLoaded)
               // if(controller.resposeList.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 1,
                  primary: false,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: AppTheme.whiteTextColor,
                          borderRadius: BorderRadius.circular(12)),
                      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Raj Kumar",
                                  style: GoogleFonts.rubik(
                                    color: AppTheme.blackColor,
                                    fontSize: Constant.smallbody(context),
                                    fontWeight: FontWeight.w700,
                                  )),
                              GestureDetector(
                                onTap: () {
                                  Get.to(MeetingScreen(
                                      meetingId: 
                                      "nbog-jc1c-g15a", token: token));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppTheme.powderBlue,
                                      borderRadius: BorderRadius.circular(8)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  child: Text("Connect",
                                      style: GoogleFonts.rubik(
                                        color: AppTheme.whiteTextColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      )),
                                ),
                              )
                            ],
                          ),
                          Text("I have fever with cough , sneezing symptons",
                              style: GoogleFonts.rubik(
                                color: AppTheme.blackColor,
                                fontSize: Constant.smallbody(context),
                                fontWeight: FontWeight.w400,
                              )),
                          SizedBox(
                            height: 4,
                          ),
                          Text("17 July 2025 , 2:00 pm",
                              style: GoogleFonts.rubik(
                                color: AppTheme.linkColor,
                                fontSize: Constant.smallbody(context),
                                fontWeight: FontWeight.w500,
                              )),
                        ],
                      ),
                    );
                  },
                )
                // body: Padding(
                //   padding: const EdgeInsets.all(12.0),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       ElevatedButton(
                //         onPressed: () => onCreateButtonPressed(context),
                //         child: const Text('Create Meeting'),
                //       ),
                //       Container(
                //         margin: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                //         child: TextField(
                //           decoration: const InputDecoration(
                //             hintText: 'Meeting Id',
                //             border: OutlineInputBorder(),
                //           ),
                //           controller: _meetingIdController,
                //         ),
                //       ),
                //       ElevatedButton(
                //         onPressed: () => onJoinButtonPressed(context),
                //         child: const Text('Join Meeting'),
                //       ),
                //     ],
                //   ),
                // ),
              ]),
            );
          }
        ));
  }
}
