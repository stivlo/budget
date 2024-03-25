// Not used yet, it's here just as example code and will be changed later

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import '../helper/date_time_helper.dart';

class BackgroundWorker {
  static const allocateBudgetTaskName = 'allocate-budget';

  void init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // var uniqueId = DateTime.now().toIso8601String();
    final workmanager = Workmanager();
    workmanager.cancelAll();

    await workmanager.initialize(callbackDispatcher);
    await workmanager.registerPeriodicTask(
      allocateBudgetTaskName,
      allocateBudgetTaskName,
      frequency: const Duration(minutes: 15),
      initialDelay: const Duration(minutes: 1),
    );
  }

  void callbackDispatcher() {
    Workmanager().executeTask((taskName, inputData) async {
      switch (taskName) {
        case allocateBudgetTaskName:
          print('background task start v1: ${DateTime.now().toIso8601String()} ');
          var prefs = await SharedPreferences.getInstance();
          String cronJson = prefs.getString('cron') ?? '[]';
          cronJson = '[]';
          List executions = json.decode(cronJson);
          executions.add(DateTimeHelper.formattedTime());
          cronJson = json.encode(executions);
          prefs.setString('cron', cronJson);
          print('background task end v1: $cronJson');
          break;
      }
      return true;
    });
  }

  void sharedPrefs() async {
    var prefs = await SharedPreferences.getInstance();
    var keys = prefs.getKeys();
    print('Prefs keys: $keys');
    for (var key in keys) {
      print('$key: ${prefs.get(key)}');
    }
  }
}
