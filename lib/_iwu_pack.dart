import 'package:_iwu_pack/setup/app_base.dart';
import 'package:_iwu_pack/setup/app_setup.dart';
import 'package:firebase_core/firebase_core.dart';

import 'src/constants/constants.dart';
import 'src/utils/utils.dart';

imagineeringwithusPackSetup() {
  AppSetup.initialized(
    value: AppSetup(
      env: AppEnv.preprod,
      appColors: AppColors.instance,
      appPrefs: AppPrefs.instance,
    ),
  );
}

const FirebaseOptions firebaseOptionsPREPROD = FirebaseOptions(
 apiKey: "AIzaSyCj_q7hxbGjNozi1oavONisJqIMUHlYX_Q",
  authDomain: "admin-4c88d.firebaseapp.com",
  projectId: "admin-4c88d",
  storageBucket: "admin-4c88d.appspot.com",
  messagingSenderId: "663250349005",
  appId: "1:663250349005:web:b6364c47bd98ea0305b284",
  measurementId: "G-JDWFWRMDBP"

);
