import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MenuItem {
  final String name;
  final double price;

  MenuItem({required this.name, required this.price});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Food Order App',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: MenuScreen(),
    );
  }
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final List<MenuItem> items = [
    MenuItem(name: "Σουβλάκι", price: 2),
    MenuItem(name: "Σουτζουκάκι", price: 2),
    MenuItem(name: "Λουκάνικο", price: 2),
    MenuItem(name: "Τζατζίκι", price: 2),
    MenuItem(name: "Τυροκαυτερή", price: 2),
    MenuItem(name: "Σαλάτα", price: 2),
    MenuItem(name: "Ψωμάκι", price: 0.5),
    MenuItem(name: "Γεωργιάδη", price: 3.5),
    MenuItem(name: "Βασιλική", price: 4),
    MenuItem(name: "Μπύρα", price: 2.5),
    MenuItem(name: "Coca-Cola", price: 2),
    MenuItem(name: "Αναψυκτικό", price: 1),
    MenuItem(name: "Νερό", price: 0.5)
  ];

  final Map<MenuItem, int> cart = {};

  double get total => cart.entries
      .fold(0, (sum, entry) => sum + entry.key.price * entry.value);

  void addItem(MenuItem item) {
    setState(() {
      cart[item] = (cart[item] ?? 0) + 1;
    });
  }

  void removeItem(MenuItem item) {
    setState(() {
      if (cart.containsKey(item)) {
        if (cart[item]! > 1) {
          cart[item] = cart[item]! - 1;
        } else {
          cart.remove(item);
        }
      }
    });
  }

  void clearCart() {
    setState(() {
      cart.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Παρχαράκης",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final qty = cart[item] ?? 0;
          return ListTile(
            title: Text(
              item.name,
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            subtitle: Text(
              "€${item.price.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove, size: 24),
                  onPressed: qty > 0 ? () => removeItem(item) : null,
                ),
                Container(
                  width: 30,
                  child: Text(
                    qty.toString(),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add, size: 24),
                  onPressed: () => addItem(item),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  "Σύνολο: €${total.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)
              ),
              if (cart.isNotEmpty)
                ElevatedButton(
                  onPressed: clearCart,
                  child: Text("Καθαρισμός"),
                ),
            ],
          ),
        ),
      ),
    );
  }
}