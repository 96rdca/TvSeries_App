import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:seriestv_jobcity/common/http_certificate.dart';
import 'package:seriestv_jobcity/di/get_it.dart' as get_it;
import 'package:seriestv_jobcity/presentation/tvmaze_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  final appDirDocuments = await getApplicationDocumentsDirectory();
  Hive.init(appDirDocuments.path);

  unawaited(get_it.init());

  runApp(const TvMazeApp());
}
