import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive Demo',
      home: DashboardHome(),
    );
  }
}

const kDesktopBreakpoint = 1024.0;

class DashboardHome extends StatefulWidget {
  @override
  _DashboardHomeState createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  int _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, dimens) => Scaffold(
        drawer: dimens.maxWidth < kDesktopBreakpoint ? buildDrawer() : null,
        appBar: buildDeskAppBar(),
        body: Row(
          children: <Widget>[
            if (dimens.maxWidth >= kDesktopBreakpoint) buildDrawer(0),
            Expanded(
                child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Center(
                      child: Container(
                        alignment: Alignment.topCenter,
                        child: buildBody(dimens.maxWidth),
                      ),
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget buildBody(double width) {
    double elevation = 10;

    return Scrollbar(
      
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowGlow();
          return false;
        },
        child: ListView(
          children: [
            Wrap(
              //start
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              runSpacing: 13,
              spacing: 13,

              children: <Widget>[
                Card(
                  elevation: elevation,
                  child: Container(
                    color: Colors.indigo,
                    height: 250.0,
                    //take all X space
                    // width: double.infinity,
                  ),
                ),
                Card(
                  elevation: elevation,
                  child: Container(
                    color: Colors.pink,
                    height: 300,
                    width: 362,
                  ),
                ),
                Card(
                  elevation: elevation,
                  child: Container(
                    color: Colors.purple,
                    width: 362,
                    height: 300,
                  ),
                ),
              ],
            ),
            Card(
              elevation: elevation,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black38,
                    width: 2.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      //si 1 es solido por eso usamos 15
                      blurRadius: 15,
                      spreadRadius: 3,

                      color: Colors.white10,
                    ),
                  ],
                ),
                //color: Colors.indigo,

                height: 60.0,
                //take all X space
                // width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildDeskAppBar() {
    return AppBar(
      backgroundColor: Colors.blueGrey.shade600,
      centerTitle: true,
      title: Text(
        'HomePage',
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget buildDrawer([double elevation = 15.0]) {
    return Container(
      width: 265,
      child: Drawer(
        elevation: elevation,
        child: Container(
          color: Colors.blueGrey.shade700,
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 130,
                      decoration:
                          BoxDecoration(color: Colors.blueGrey.shade900),
                      child: Center(
                        child: CircleAvatar(
                            radius: 35.0,
                            backgroundImage: NetworkImage(
                                'https://i.pinimg.com/474x/a8/6e/26/a86e26dffbcd0f8ffd0b7a6a4809ec68.jpg')),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Gerson Morales",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  buildListTile(0, Icons.home, 'Home'),
                  buildListTile(1, Icons.inbox, 'Inbox'),
                  buildListTile(2, Icons.delete, 'Trash'),
                  buildListTile(3, Icons.info, 'Spam'),
                  buildListTile(4, Icons.chat, 'Forums'),
                  buildListTile(5, Icons.flag, 'Updates'),
                  buildListTile(6, Icons.label, 'Promos'),
                  buildListTile(7, Icons.shopping_cart, 'Purchases'),
                  buildListTile(8, Icons.people, 'Social'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildListTile(int index, IconData iconData, String name) {
    final isHovered = index == _hoveredIndex;
    final iconColor =
        isHovered ? Colors.grey.shade600 : Colors.blueGrey.shade300;
    final textColor =
        isHovered ? Colors.grey.shade800 : Colors.blueGrey.shade200;
    return MouseRegion(
      onEnter: (_) => _setHoverIndex(index),
      onExit: (_) => _setHoverIndex(null),
      child: Container(
        color: isHovered ? Color(0xFF4BA1B5) : null,
        child: ListTile(
          leading: Icon(iconData, color: iconColor),
          title: Text(
            name,
            style: TextStyle(color: textColor),
          ),
          onTap: () {
            Navigator.maybePop(context);
          },
        ),
      ),
    );
  }

  void _setHoverIndex(int index) {
    if (mounted)
      setState(() {
        _hoveredIndex = index;
      });
  }
}
