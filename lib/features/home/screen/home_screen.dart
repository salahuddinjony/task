import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../task2_product/screen/product_screen.dart';
import '../../task3_note_crud/screen/note_list_screen.dart';
import '../controller/theme_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RxInt _selectedIndex = 0.obs;
  final themeController = Get.find<ThemeController>();

  final List<Widget> _screens = [
    ProductScreen(),
    NoteListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text(_selectedIndex.value == 0 ? 'Products' : 'Notes'),
            actions: [
              IconButton(
                icon: Icon(themeController.themeMode.value == ThemeMode.dark
                    ? Icons.light_mode
                    : Icons.dark_mode),
                onPressed: themeController.toggleTheme,
                tooltip: 'Toggle Theme',
              ),
            ],
          ),
          body: _screens[_selectedIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex.value,
            onTap: (i) => _selectedIndex.value = i,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag),
                label: 'Products',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.note),
                label: 'Notes',
              ),
            ],
          ),
        ));
  }
} 