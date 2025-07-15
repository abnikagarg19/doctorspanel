import 'package:chatbot/controller/signupController.dart';
import 'package:flutter/material.dart';
import '../../../components/input_field.dart' show MyTextField;
import '../../../theme/apptheme.dart';
import 'label_common.dart';

class PersonalForm extends StatelessWidget {
  const PersonalForm({
    super.key, required this.controller,
  });
  final SignUpController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
              horizontal: 20),
      child: Column(
        children: [
          buildLable(context,
              "Full Name (as per medical registration)"),
          SizedBox(
            height: 8,
          ),
          MyTextField(
              textEditingController:
                  controller.email,
              validation: (value) {
                if (value == null ||
                    value.isEmpty) {
                  return 'Required';
                  // }
                }
                return null;
              },
              hintText:
                  "Enter your name",
              color: const Color(
                  0xff585A60)),
          SizedBox(
            height: 20,
          ),
          buildLable(
              context, "Date of Birth"),
          SizedBox(
            height: 8,
          ),
          MyTextField(
              textEditingController:
                  controller.password,
              validation: (value) {
                if (value == null ||
                    value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
              hintText: 'dd/mm/yyyy',
              color: const Color(
                  0xff585A60)),
          SizedBox(
            height: 20,
          ),
          buildLable(context, "Gender"),
          SizedBox(
            height: 8,
          ),
          MyTextField(
              textEditingController:
                  controller.password,
              validation: (value) {
                if (value == null ||
                    value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
              icon: Icon(
                Icons
                    .keyboard_arrow_down,
                color: AppTheme
                    .lightHintTextColor,
              ),
              hintText: 'Choose One',
              color: const Color(
                  0xff585A60)),
          SizedBox(
            height: 20,
          ),
          buildLable(context,
              "Mobile Number (with OTP verification)"),
          SizedBox(
            height: 8,
          ),
          MyTextField(
              textEditingController:
                  controller.password,
              validation: (value) {
                if (value == null ||
                    value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
              hintText:
                  'Enter your number',
              color: const Color(
                  0xff585A60)),
          SizedBox(
            height: 20,
          ),
          buildLable(context,
              "Emergency Contact (optional)"),
          SizedBox(
            height: 8,
          ),
          MyTextField(
              textEditingController:
                  controller.password,
              validation: (value) {
                if (value == null ||
                    value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
              hintText:
                  'Enter your number',
              color: const Color(
                  0xff585A60)),
          SizedBox(
            height: 20,
          ),
          buildLable(context,
              "Email Address (with OTP verification)"),
          SizedBox(
            height: 8,
          ),
          MyTextField(
              textEditingController:
                  controller.password,
              validation: (value) {
                if (value == null ||
                    value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
              hintText:
                  'Enter your email',
              color: const Color(
                  0xff585A60)),
          SizedBox(
            height: 20,
          ),
          buildLable(
              context, "Address"),
          SizedBox(
            height: 8,
          ),
          MyTextField(
              textEditingController:
                  controller.password,
              validation: (value) {
                if (value == null ||
                    value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
              hintText:
                  'Enter your  address',
              color: const Color(
                  0xff585A60)),
        ],
      ),
    );
  }
}
