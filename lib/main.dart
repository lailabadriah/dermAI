import 'package:flutter/material.dart';

import 'app.dart';
import 'core/services/firebase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await FirebaseService.initialize();
  } catch (_) {
    // Firebase config is optional during local prototype and early development stages.
  }

  runApp(const DermAIApp());
}

