import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import 'package:todo/features/todo/screens/HomePage/home_page.dart';
import 'package:todo/features/todo/screens/VerifyPage/resend_code.dart';

import '../../../../common/custom_elevated_button.dart';
import '../../../../utils/constants/texts.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Container(height: 300,width: double.infinity,child: Image.asset("assets/images/verify.png"),),
            const SizedBox(height: 50),
            const Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                Texts.VerificatoinTitle,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomLeft,
              child: RichText(
                  text:
               const    TextSpan(
                    text: Texts.VerificationSubTtitle,style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                          text: "support@gmail.com",
                          style: TextStyle(color: Colors.black))])),
            ),
            const SizedBox(height: 50),
           OTPTextField(
                length: 5,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 50,
                style: const TextStyle(
                  fontSize: 17,
                ),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.box,
                onCompleted: (pin) {
                  print("Completed: " + pin);
                },
              ),
            const SizedBox(height: 50),
                          CustomElevatedbutton(
                  hSize: 150,
                  vSize: 15,
                  onPressed:_verifyCode,
                  name: "Verify",
                  textColor: Colors.white),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(Texts.ReceiveCode),
                TextButton(
                    onPressed: _resendCode,
                    child: const Text(
                      "Resend",
                      style: TextStyle(color: Colors.blue),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _verifyCode() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  void _resendCode() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ResendCode()));
  }
}
