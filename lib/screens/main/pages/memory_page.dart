import 'package:flutter/material.dart';
import 'package:quranapp/screens/tab_pages/dua_tab.dart';
import 'package:quranapp/screens/tab_pages/zikr_tab.dart';

class MemoryPage extends StatefulWidget {
  const MemoryPage({super.key});

  @override
  State<MemoryPage> createState() => _MemoryPageState();
}

class _MemoryPageState extends State<MemoryPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Memorize'),
          bottom: TabBar(
            indicatorColor: Colors.greenAccent,
            dividerColor: Colors.grey,
            tabs: [
              Tab(text: 'Dua'),
              Tab(text: 'Zikr'),
            ],
          ),
        ),
        body: TabBarView(children: [DuaTab(), ZikrTab()]),
      ),
    );
  }
}
