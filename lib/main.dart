import 'package:flutter/material.dart';
import 'home/homepage.dart';
import 'erp/bus.dart';
import 'erp/pp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ERP Consortium',
      theme: ThemeData(primarySwatch: Colors.indigo),
      // กำหนดเส้นทางหน้าจอ (Routes)
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/business_units': (context) => BusinessUnitsPage(),
        '/proposal': (context) => SalesProposalPage(),
      },
    );
  }
}
