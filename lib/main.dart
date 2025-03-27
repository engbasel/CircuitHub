import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/Core/Services/custom_block_observer.dart';
import 'package:store/Core/Services/shared_preferences_sengleton.dart';

import 'package:store/SmartStore.dart';
import 'package:store/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = CustomBlockObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Prefs.init();
  // setupGetit();
  runApp(const SmartStore());
}
