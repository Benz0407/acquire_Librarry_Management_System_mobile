// ignore_for_file: use_build_context_synchronously

import 'package:acquire_lms_mobile_app/provider/otp_provider.dart';
import 'package:acquire_lms_mobile_app/screens/otp_screen.dart';
import 'package:acquire_lms_mobile_app/utils/spaces.dart';
import 'package:auto_route/auto_route.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SendEmailOtp extends StatefulWidget {
  const SendEmailOtp({super.key});

  @override
  State<SendEmailOtp> createState() => _SendEmailOtpState();
}

class _SendEmailOtpState extends State<SendEmailOtp> {
  final TextEditingController schoolIdController = TextEditingController();
  EmailOTP myauth = EmailOTP();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 125,
          leading: TextButton(
          onPressed: () {
           context.back(); 
          },
          child: const Text(
            'Back',
            style: TextStyle(color: Colors.red),
          ),
        ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset('assets/bookmark-5-128.png'),
            ],
          ),),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          verticalSpacing(50),
          Row(
            children: [
              SizedBox(
                height: 75,
                child: Image.asset(
                  'assets/Logo.png',
                  fit: BoxFit.contain,
                ),
              ),
              horizontalSpacing(25),
              const Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'A',
                          style: TextStyle(
                            color: Color(0xFFCC0000),
                            fontSize: 50,
                            fontFamily: 'League Spartan',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: 'CQUIRE',
                          style: TextStyle(
                            color: Color(0xFF3D3D3D),
                            fontSize: 50,
                            fontFamily: 'League Spartan',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Library Management System',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'League Spartan',
                      fontWeight: FontWeight.w400,
                      height: 0.12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          verticalSpacing(200),
          const SizedBox(
            height: 60,
            child: Text(
              "Enter your School ID to get Code",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.withOpacity(.2)),
          
                child: TextFormField(
                  controller: schoolIdController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 20.0), 
                    prefixIcon: const Icon(Icons.school),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      onPressed: () async {
                        String schoolId = schoolIdController.text;
                        String? email =
                            await OtpProvider().getEmailFromSchoolId(schoolId);
                        if (email != null) {
                          myauth.setConfig(
                            appEmail: "benedickclerigo@gmail.com",
                            appName: "Email OTP",
                            userEmail: email,
                            otpLength: 4,
                            otpType: OTPType.digitsOnly,
                          );
                          if (await myauth.sendOTP() == true) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("OTP has been sent"),
                            ));
                
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OtpScreen(
                                    myauth: myauth, schoolId: schoolId),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("School ID not found"),
                          ));
                        }
                      },
                      icon: const Icon(
                        Icons.send_rounded,
                        color: Colors.red,
                      ),
                    ),
                    hintText: "School ID",
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
