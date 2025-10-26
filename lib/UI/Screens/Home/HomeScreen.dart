
import 'package:events/UI/Common/tab_bar_item.dart';
import 'package:events/UI/Provider/AppAuthProvider.dart';
import 'package:events/UI/Screens/Home/tabs/home_tab/home-tab.dart';
import 'package:events/extensions/context-extension.dart';
import 'package:events/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTabIndex = 0;
  int currentBottomNavIndex = 0;
  List<Widget> tabs = [HomeTab(), HomeTab(), HomeTab(), HomeTab()];
  @override
  Widget build(BuildContext context) {
    AppAuthProvider provider = Provider.of<AppAuthProvider>(context);
    Size size = MediaQuery.of(context).size;
    var user = provider.getUser();
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                provider.logout();
                Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.LoginScreen.name,
                );
              },
              icon: Icon(Icons.logout, color: Colors.white),
            ),
          ],
          centerTitle: false,
          backgroundColor: context.appColors.primary,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (user?.name?.isEmpty == false) ...[
                Text(
                  "welcome back",
                  style: context.fonts.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontFamily: GoogleFonts.inter().fontFamily,
                    fontSize: 14,
                  ),
                ),
                Text(
                  user?.name ?? "",
                  style: context.fonts.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/map.svg'),
                    SizedBox(height: 8),
                    Text(
                      'Cairo',
                      style: context.fonts.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: GoogleFonts.inter().fontFamily,
                      ),
                    ),
                  ],
                ),
              ] else
                CircularProgressIndicator(),
            ],
          ),
          bottom: TabBar(
            indicatorColor: Colors.transparent,
            padding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            onTap: (index) {
              setState(() {
                currentTabIndex = index;
              });
            },
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            dividerColor: Colors.transparent,
            tabs: [
              TabBarItem(
                icon: FontAwesome.compass,
                currentIndex: currentTabIndex,
                title: "All",
                index: 0,
              ),
              TabBarItem(
                icon: FontAwesome.bicycle_solid,
                currentIndex: currentTabIndex,
                title: "Sport",
                index: 1,
              ),
              TabBarItem(
                icon: FontAwesome.playstation_brand,
                currentIndex: currentTabIndex,
                title: "Gaming",
                index: 2,
              ),
              TabBarItem(
                icon: Icons.work_outline_rounded,
                currentIndex: currentTabIndex,
                title: "Workshop",
                index: 3,
              ),
              TabBarItem(
                icon: Icons.calendar_today,
                currentIndex: currentTabIndex,
                title: "Birthday",
                index: 4,
              ),
            ],
          ),
          toolbarHeight: 120,
        ),
        body: tabs[currentBottomNavIndex],
        bottomNavigationBar: Theme(
          data: ThemeData(useMaterial3: false),
          child: BottomAppBar(
            shape: CircularNotchedRectangle(),
            color: context.appColors.primary,
            notchMargin: 5,
            child: BottomNavigationBar(
              backgroundColor: context.appColors.primary,
              currentIndex: currentBottomNavIndex,
              showSelectedLabels: true,
              onTap: (index) {
                setState(() {
                  currentBottomNavIndex = index;
                });
              },
              showUnselectedLabels: true,
              elevation: 0,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/icons/home.svg'),
                  label: 'Home',
                  activeIcon: SvgPicture.asset('assets/icons/home_fill.svg'),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/icons/map.svg'),
                  label: 'Maps',
                  activeIcon: SvgPicture.asset('assets/icons/maps_fill.svg'),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/icons/heart.svg'),
                  label: 'Favourite',
                  activeIcon: SvgPicture.asset('assets/icons/heart_fill.svg'),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/icons/user.svg'),
                  label: 'Profile',
                  activeIcon: SvgPicture.asset('assets/icons/user_fill.svg'),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(360),
            side: BorderSide(color: Colors.white, width: 4),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.AddEvent.name);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
