import 'package:flutter/material.dart';

class NumberOfTenantScreen extends StatefulWidget {
  const NumberOfTenantScreen({super.key});

  @override
  State<NumberOfTenantScreen> createState() => _NumberOfTenantScreenState();
}

class _NumberOfTenantScreenState extends State<NumberOfTenantScreen> {
  String? _selected;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color.fromARGB(255, 0, 0, 0),),
          onPressed: () => {},
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center();
        }
      ),
    );
  }
}
