import 'package:chatbot/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/apptheme.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.whiteBackgroundColor,
      ),
      //  decoration: BoxDecoration(
      //   gradient: SweepGradient(
      //     colors: [
      //       Color.fromARGB(255, 245, 239, 238),
      //       Color.fromARGB(255, 245, 239, 238),

      //       Color.fromARGB(255, 245, 239, 238),
      //       Color(0xFFF4E2Ed),
      //       Color(0xFFF0EDFA),
      //       //  Colors.red, // Top-left
      //       // Colors.orange, // Top-right
      //       // Colors.yellow, // Center
      //       // Colors.green, // Bottom-left
      //       // Colors.blue, // Bottom-right
      //       //    Colors.red, // Top-left
      //       // const Color(0xFFFEBA64).withOpacity(0.3),
      //       // const Color(0xFFFBA56F).withOpacity(0.3),
      //       // const Color(0xFFFEBA64).withOpacity(0.3),
      //       // const Color(0xFFF56F8A).withOpacity(0.3),
      //       // const Color(0xFFFEBA64).withOpacity(0.3),
      //     ],
      //     center: Alignment.center,
      //     stops: [
      //       0.0, // Red
      //       0.25, // Orange
      //       0.5, // Yellow (center)
      //       0.75, // Green
      //       1.0, // Blue
      //     ],

      //     transform: GradientRotation(45 * 3.14 / 180),
      //     //       begin: Alignment(-1.0, -1.0),
      //     // end: Alignment(2.0, 4.0),)
      //   ),
      // ),
      child: Container(
        //  width: _isSidebarOpen ? 0 : 0,
        decoration: BoxDecoration(
          color: const Color.fromARGB(253, 255, 255, 255),
          //   color: Color.fromARGB(70, 250, 220, 238),

          boxShadow: [
            BoxShadow(
                color: const Color.fromARGB(78, 255, 255, 255),
                spreadRadius: 4,
                blurRadius: 12)
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!ResponsiveLayout.isLargeScreen(context))
                SizedBox(
                  height: 30,
                ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //       horizontal: 2, vertical: 10),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       InkWell(
              //         onTap: () {
              //           Get.to(Login());
              //         },
              //         child: Row(
              //           children: [
              //             ClipRRect(
              //                 borderRadius: BorderRadius.circular(50),
              //                 child: Image.asset(
              //                   "assets/images/aa.jpg",
              //                   height: 40,
              //                   width: 40,
              //                   fit: BoxFit.cover,
              //                 )),
              //             Text(
              //               "  Abnika Garg",
              //               style: GoogleFonts.roboto(
              //                 color: AppTheme.bodyTextColor,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             )
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        "assets/images/a1.png",
                        height: 30,
                        width: 30,
                        fit: BoxFit.cover,
                      )),
                  Flexible(
                    child: Text(
                      "  Explore AI Chatbot",
                      style: GoogleFonts.roboto(
                        color: AppTheme.bodyTextColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 35,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0XFF77CCFF),
                        Color(0XFF55AAFF),
                        Color(0XFF3388FF),
                        Color(0XFF0066FF),
                        Color(0XFF0044FF),
                        // const Colo
                      ],

                      //       begin: Alignment(-1.0, -1.0),
                      // end: Alignment(2.0, 4.0),)
                    ),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.add,
                      color: AppTheme.whiteBackgroundColor,
                      size: 16,
                    ),
                    Text(
                      "  New chat",
                      style: GoogleFonts.roboto(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.whiteBackgroundColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Text(
                "Today",
                style: GoogleFonts.roboto(
                  color: AppTheme.blackColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ...List.generate(
                2,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          color: AppTheme.blackColor,
                          size: 16,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Flexible(
                          child: Text(
                            "How are you?.....",
                            style: GoogleFonts.roboto(
                              color: Color.fromRGBO(106, 105, 105, 1),
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Yesterday",
                style: GoogleFonts.roboto(
                  color: AppTheme.blackColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ...List.generate(
                1,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          color: AppTheme.blackColor,
                          size: 16,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Flexible(
                          child: Text(
                            "How are you?.....",
                            style: GoogleFonts.roboto(
                              color: Color.fromRGBO(106, 105, 105, 1),
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Spacer(),
              Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: Color.fromRGBO(59, 74, 239, 1),
                    size: 16,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Flexible(
                    child: Text(
                      "Logout",
                      style: GoogleFonts.roboto(
                        color: Color.fromRGBO(59, 74, 239, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
