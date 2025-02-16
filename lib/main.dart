import 'package:duo_duo_to_do/widgets/task_edit_page.dart';
import 'package:flutter/material.dart';
import 'myFont.dart';
import 'pages/list_page.dart';
import 'pages/personal_center_page.dart';
import 'database/database_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.limeAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Todo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ListPageState> listPageKey = GlobalKey<ListPageState>();
  var _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentPage;
    switch(_selectedIndex){
      case 0:
        currentPage = Placeholder();
        break;
      case 1:
        currentPage = Placeholder();
        break;
      case 2:
        currentPage = ListPage(key: listPageKey);
        break;
      case 3:
        currentPage = PersonalCenterPage();
        break;
      default:
        throw UnimplementedError('no widget for $_selectedIndex');
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onPrimary,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(myFont.game),
            label: '游戏',
          ),
          const BottomNavigationBarItem(
            icon: Icon(myFont.ranking_list),
            label: '排行',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: _selectedIndex == 2
                      ? TaskEditPage(listPageKey: listPageKey)
                      : Icon(myFont.xin_jian),
                ),
              ],
            ),
            label: '新建',
          ),
          const BottomNavigationBarItem(
              icon: Icon(myFont.xiao_lian),
              label: '个人'
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}