import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CronTest extends StatefulWidget {
  const CronTest({super.key});

  @override
  State<CronTest> createState() => _CronTestState();
}

class _CronTestState extends State<CronTest> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: FutureBuilder(
        future: findExecutions(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
            return const Column(children: [
              SizedBox(height: 20),
              Center(child: CircularProgressIndicator()),
              SizedBox(height: 20),
            ]);
          }
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              shrinkWrap: true,
              children: snapshot.data!.map((e) => Text(e)).toList(),
            ),
          );
        },
      ),
    );
  }

  Future<List<String>> findExecutions() async {
    var prefs = await SharedPreferences.getInstance();
    String cronJson = prefs.getString('cron') ?? '[]';
    try {
      List<dynamic> executions = json.decode(cronJson);
      return executions.map((e) => e.toString()).toList();
    } catch (err) {
      print(err);
    }
    return [];
  }
}
