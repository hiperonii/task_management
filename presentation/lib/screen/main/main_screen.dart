import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:presentation/screen/main/model/task_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late final List<TaskTab> _taskTabs = Status.values.map((s) => TaskTab(s)).toList();
  late final TabController _tabController = TabController(vsync: this, length: _taskTabs.length);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            _buildHeader(),
            Positioned(
              bottom: -12,
              left: 0,
              right: 0,
              child: _buildTabBar(),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Expanded(child: _buildTabBarView()),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Text('Hi!',
              style: TextStyle(
                fontSize: 24,
                height: 1.5,
                color: Colors.brown,
                fontWeight: FontWeight.bold,
              )),
          Text('Welcome back',
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.brown,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: const BorderRadius.all(Radius.circular(40)),
      ),
      child: TabBar(
        labelColor: Colors.brown,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.transparent,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(color: Colors.brown.shade50),
        controller: _tabController,
        tabs: _taskTabs.map((t) => Tab(key: ValueKey(t.title) ,text: t.title)).toList(),
      ),
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: _taskTabs.map((t) => t.screen).toList(),
    );
  }
}
