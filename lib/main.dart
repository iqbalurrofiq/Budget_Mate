import 'package:flutter/material.dart';
import 'page/home.dart';
import 'page/transaksi.dart';
import 'page/history.dart';
import 'page/statistik.dart';

void main() {
  runApp(const BudgetMateApp());
}

class BudgetMateApp extends StatelessWidget {
  const BudgetMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BudgetMate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> transactions = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addTransaction(String title, double amount, bool isIncome) {
    setState(() {
      transactions.add({
        'title': title,
        'amount': amount,
        'isIncome': isIncome,
        'date': DateTime.now(),
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(transactions: transactions),
      AddTransactionPage(onAdd: _addTransaction),
      HistoryPage(transactions: transactions),
      StatisticsPage(transactions: transactions),
      const HomePage(),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: "Home"),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            label: "Tambah",
          ),
          NavigationDestination(icon: Icon(Icons.history), label: "Riwayat"),
          NavigationDestination(
            icon: Icon(Icons.bar_chart),
            label: "Statistik",
          ),
        ],
      ),
    );
  }
}
