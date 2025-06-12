
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(SoloLevelingApp());
}

class SoloLevelingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solo Leveling System',
      theme: ThemeData.dark(),
      home: MainMenu(),
    );
  }
}

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Solo Leveling")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("🏆 Quests"),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => QuestScreen())),
            ),
            ElevatedButton(
              child: Text("🎯 Boss Fight"),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BossFightScreen())),
            ),
            ElevatedButton(
              child: Text("🧠 Skill Tree"),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SkillTreeScreen())),
            ),
            ElevatedButton(
              child: Text("🎒 Inventory"),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => InventoryScreen())),
            ),
          ],
        ),
      ),
    );
  }
}

class QuestScreen extends StatefulWidget {
  @override
  _QuestScreenState createState() => _QuestScreenState();
}

class _QuestScreenState extends State<QuestScreen> {
  int xp = 0;

  @override
  void initState() {
    super.initState();
    _loadXP();
  }

  void _loadXP() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      xp = prefs.getInt('xp') ?? 0;
    });
  }

  void _addXP(int amount) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      xp += amount;
      prefs.setInt('xp', xp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quests")),
      body: Column(
        children: [
          Text("XP: $xp", style: TextStyle(fontSize: 24)),
          ElevatedButton(
            onPressed: () => _addXP(10),
            child: Text("Complete Easy Quest (+10 XP)"),
          ),
          ElevatedButton(
            onPressed: () => _addXP(50),
            child: Text("Complete Hard Quest (+50 XP)"),
          )
        ],
      ),
    );
  }
}

class BossFightScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Boss Fight")),
      body: Center(
        child: Text("🧟‍♂️ Boss fight coming soon...", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

class SkillTreeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Skill Tree")),
      body: ListView(
        children: [
          ListTile(title: Text("📈 Double XP"), subtitle: Text("(Locked)")),
          ListTile(title: Text("🤖 Auto Quest"), subtitle: Text("(Locked)")),
          ListTile(title: Text("🩹 Heal Boost"), subtitle: Text("(Locked)")),
        ],
      ),
    );
  }
}

class InventoryScreen extends StatelessWidget {
  final List<String> items = ["Health Potion", "Iron Sword", "Armor Fragment"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Inventory")),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => ListTile(
          leading: Icon(Icons.backpack),
          title: Text(items[index]),
        ),
      ),
    );
  }
}
