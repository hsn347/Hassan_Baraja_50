import 'package:flutter/material.dart';

void main() {
  runApp(const SebhaApp());
}

class SebhaApp extends StatelessWidget {
  const SebhaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'المسبحة الإلكترونية',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const SebhaHome(),
    );
  }
}

class SebhaHome extends StatefulWidget {
  const SebhaHome({super.key});

  @override
  State<SebhaHome> createState() => _SebhaHomeState();
}

class _SebhaHomeState extends State<SebhaHome> {
  final List<String> azkarList = [
    'الله أكبر',
    'سبحان الله',
    'الحمد لله',
    'لا إله إلا الله',
  ];

  late Map<String, int> zikrCount;
  String currentZikr = 'الله أكبر';

  @override
  void initState() {
    super.initState();
    zikrCount = {for (var item in azkarList) item: 0};
  }

  void increaseCount() {
    setState(() {
      zikrCount[currentZikr] = (zikrCount[currentZikr] ?? 0) + 1;
    });
  }

  void resetCount() {
    setState(() {
      zikrCount[currentZikr] = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final count = zikrCount[currentZikr] ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'المسبحة الإلكترونية',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.tealAccent],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // القائمة المنسدلة لاختيار الذكر
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: DropdownButton<String>(
                value: currentZikr,
                items: azkarList
                    .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: const TextStyle(fontSize: 20)),
                ))
                    .toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() => currentZikr = val);
                  }
                },
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 40),

            // العداد
            Container(
              padding: const EdgeInsets.all(45),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(2, 4),
                  )
                ],
              ),
              child: Text(
                '$count',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // الأزرار
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: increaseCount,
                  icon: const Icon(Icons.add),
                  label: const Text('تسبيح', style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 25),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: resetCount,
                  icon: const Icon(Icons.refresh),
                  label: const Text('تصفير', style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 25),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
