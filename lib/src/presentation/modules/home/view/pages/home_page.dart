import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fresh_recipes/src/presentation/modules/home/view/pages/home_controller.dart';
import 'package:fresh_recipes/src/presentation/modules/home/widgets/recipes_for_you.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final tabController = TabController(length: 2, vsync: this);

  final HomePageController _controller = Modular.get<HomePageController>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: const Color(0xffFDFFFD),
          extendBody: true,
          body: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Image.asset(
                    'assets/img/refitness.png',
                    height: 20,
                  ),
                  centerTitle: true,
                  bottom: TabBar(
                    controller: tabController,
                    tabs: const [
                      Tab(
                        text: 'Recipes for you',
                      ),
                      Tab(
                        text: 'Following chefs',
                      ),
                    ],
                    isScrollable: false,
                    indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelColor: Colors.black54,
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: tabController,
              children: [
                RecipesForYou(controller: _controller),
                RecipesForYou(controller: _controller),
              ],
            ),
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
