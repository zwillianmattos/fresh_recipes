import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fresh_recipes/src/domain/entities/account.dart';
import 'package:fresh_recipes/src/presentation/modules/account/account_controller.dart';
import 'package:fresh_recipes/src/presentation/modules/account/recipes/my_recipes.dart';
import 'package:fresh_recipes/src/presentation/modules/account/recipes/my_recipes_controller.dart';
import 'package:fresh_recipes/src/presentation/modules/recipes/create/create_recipe_page.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> with SingleTickerProviderStateMixin {
  final AccountPageController _controller = Modular.get<AccountPageController>();
  late final MyRecipeController _myRecipeController;
  late final TabController tabController = TabController(length: 1, vsync: this);
  @override
  void initState() {
    super.initState();
    _myRecipeController = MyRecipeController(_controller.state.dataNotifier.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Log out'),
              onTap: _controller.logOut,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ValueListenableBuilder<Account>(
        valueListenable: _controller.state.dataNotifier,
        builder: (BuildContext context, Account account, Widget? child) {
          return (account.isChef != null && account.isChef!)
              ? FloatingActionButton(
                  backgroundColor: Colors.green,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateRecipePage(),
                      ),
                    );
                  },
                  child: const Icon(
                    FontAwesomeIcons.plus,
                    color: Colors.white,
                  ),
                )
              : Container();
        },
      ),
      body: NestedScrollView(
        physics: const ClampingScrollPhysics(),
        headerSliverBuilder: (context, value) {
          return [
            ValueListenableBuilder<bool>(
                valueListenable: _controller.state.loadingNotifier,
                builder: (context, loading, child) {
                  return SliverAppBar(
                    elevation: 0,
                    title: const Text('My Account'),
                    centerTitle: true,
                    floating: false,
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(FontAwesomeIcons.bell),
                      ),
                    ],
                    bottom: PreferredSize(
                      preferredSize: !loading ? Size.fromHeight(MediaQuery.sizeOf(context).height / 2.6) : const Size.fromHeight(0),
                      child: ValueListenableBuilder<Account>(
                        valueListenable: _controller.state.dataNotifier,
                        builder: (context, account, child) {
                          if (loading) return const Center();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      _createProfilePicture(account.profilePhoto!),
                                      Text(
                                        account.name!,
                                        style: GoogleFonts.quicksand(fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        account.email!,
                                        style: GoogleFonts.quicksand(fontSize: 16, fontWeight: FontWeight.normal),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton.icon(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.green.withOpacity(0.2),
                                    ),
                                    icon: const Icon(
                                      FontAwesomeIcons.pencil,
                                      size: 16,
                                    ),
                                    label: Text(
                                      'Edit profile',
                                      style: GoogleFonts.quicksand(),
                                    ),
                                    onPressed: () {},
                                  ),
                                  TextButton.icon(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.green.withOpacity(0.2),
                                    ),
                                    icon: const Icon(
                                      FontAwesomeIcons.share,
                                      size: 16,
                                    ),
                                    label: Text(
                                      'Share profile',
                                      style: GoogleFonts.quicksand(),
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TabBar(
                                controller: tabController,
                                tabs: const [
                                  Tab(
                                    text: 'Recipes',
                                  ),
                                  // Tab(
                                  //   text: 'Drafts',
                                  // ),
                                ],
                                isScrollable: false,
                                indicatorSize: TabBarIndicatorSize.label,
                                unselectedLabelColor: Colors.black54,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                }),
          ];
        },
        body: ValueListenableBuilder<bool>(
          valueListenable: _controller.state.loadingNotifier,
          builder: (context, loading, child) {
            if (loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ValueListenableBuilder<String?>(
              valueListenable: _controller.state.errorNotifier,
              builder: (context, error, child) {
                if (error != null) {
                  return Center(
                    child: Text('Error $error'),
                  );
                }

                return ValueListenableBuilder<Account>(
                  valueListenable: _controller.state.dataNotifier,
                  builder: (context, account, child) {
                    return Column(
                      children: [
                        Expanded(
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              ProfileMyRecipesTab(
                                controller: _myRecipeController,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  _createProfilePicture(url) {
    var finalUrl = url;
    if (url == 'default') {
      finalUrl = 'https://st3.depositphotos.com/19428878/36416/v/450/depositphotos_364169666-stock-illustration-default-avatar-profile-icon-vector.jpg';
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: CachedNetworkImage(
          imageUrl: finalUrl,
          fit: BoxFit.cover,
          width: 86,
          height: 86,
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
