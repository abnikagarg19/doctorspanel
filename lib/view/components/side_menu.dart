import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../components/input_field.dart';
import '../../responsive.dart';
import '../../theme/apptheme.dart';
import 'package:intl/intl.dart';
import '../../utils/constant.dart';
import '../home/dashboard.dart';

class SideMenu extends StatefulWidget {
  SideMenu({super.key});

  @override
  State<SideMenu> createState() => _DashboardState();
}

class _DashboardState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ResponsiveLayout(
          desktop:
              _buildWidget(context, MediaQuery.of(context).size.width * .8),
          tablet: _buildWidget(context, MediaQuery.of(context).size.width * .9),
          mobile:
              _buildWidget(context, MediaQuery.of(context).size.width * .9)),
    );
  }

  List dashboardlist = [
    "assets/svg/dashboard.svg",
    "assets/svg/calender.svg",
    "assets/svg/chat.svg",
    "assets/svg/setting.svg",
    "assets/svg/logout.svg"
  ];

  _buildWidget(context, width) {
    return LayoutBuilder(
        // If our width is more than 1100 then we consider it a desktop
        builder: (context, constraints) {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              "assets/images/sidebar_bg.png",
              height: Get.height / 1.2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                ...List.generate(
                  dashboardlist.length,
                  (index) {
                    return SvgPicture.asset(dashboardlist[index]);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            )
          ],
        ),
        SizedBox(
          width: 60,
        ),
        _buildSwitchPage(context, 0),
        SizedBox(
          width: 60,
        ),
      ]);
    });
  }

  _buildSwitchPage(context, selectIndex) {
    if (selectIndex == 3) {
      return Container();
    }
    switch (selectIndex) {
      case 0:
        return Dashboard(
            // constraints: constraints,
            );
      case 1:
        return Dashboard(
            // constraints: constraints,
            );
    }
  }
}
