import 'package:auto_route/auto_route.dart' hide CupertinoPageRoute;
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/src/core/utils/values/colors.dart';
import 'package:flutter_app/src/features/graph/presentations/pages/graph_page.dart';
import 'package:flutter_app/src/features/insights/presentations/pages/insights_page.dart';
import 'package:flutter_app/src/features/medications/presentations/pages/medications_page.dart';
import 'package:flutter_app/src/features/home/presentation/pages/history_page.dart';
import 'package:flutter_app/src/features/settings/pages/settings_page.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  final int? tabIndex;

  const HomePage({super.key, @queryParam this.tabIndex});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late int _currentIndex;
  String title = '';
  late final CupertinoTabController _tabController;
  final List<Widget> _pages = [
    HistoryPage(),
    InsightsPage(),
    GraphPage(),
    MedicationsPage(),
    const SettingsPage(),
  ];

  final List<String> _titles = [
    'History',
    'Insights',
    'Graph',
    'Medications',
    'Settings',
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.tabIndex ?? 0;
    _tabController = CupertinoTabController(initialIndex: _currentIndex);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (_tabController.index == 4) {
      // Settings tab
      // When returning from settings, refresh the history page
      setState(() {
        _pages[0] = HistoryPage(); // Recreate the history page
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var bottomBarItems = [
      BottomNavigationBarItem(
        icon: const Icon(CupertinoIcons.clock, size: 24),
        label: _titles[0],
      ),
      BottomNavigationBarItem(
        icon: const Icon(CupertinoIcons.doc_text_search, size: 24),
        label: _titles[1],
      ),
      BottomNavigationBarItem(
        icon: const Icon(CupertinoIcons.graph_square, size: 24),
        label: _titles[2],
      ),
      BottomNavigationBarItem(
        icon: const Icon(CupertinoIcons.bandage, size: 24),
        label: _titles[3],
      ),
      BottomNavigationBarItem(
        icon: const Icon(CupertinoIcons.settings, size: 24),
        label: _titles[4],
      ),
    ];
    return CupertinoTabScaffold(
      controller: _tabController,
      tabBar: CupertinoTabBar(
        activeColor: primary1,
        items: bottomBarItems,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            return CupertinoPageScaffold(
              child: Container(
                color: primary1,
                child: SafeArea(
                  child: _pages[index],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
