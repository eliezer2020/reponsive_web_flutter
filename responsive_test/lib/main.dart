import 'package:flutter/material.dart';

void main() => runApp(MyApp());

const kDesktopBreakpoint = 1024.0;
bool largeScreen;

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

class DashboardHome extends StatefulWidget {
  @override
  _DashboardHomeState createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  @override
  Widget build(BuildContext context) {
    largeScreen = (MediaQuery.of(context).size.width >= kDesktopBreakpoint)
        ? true
        : false;
    return LayoutBuilder(
      builder: (context, dimens) => Scaffold(
        //drawe es el que se oculta
        drawer: !largeScreen ? buildDrawer() : null,
        appBar: buildDeskAppBar(),
        body: Row(
          children: <Widget>[
            if (largeScreen) buildDrawer(),
            Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                child: buildBody(dimens.maxWidth, dimens.maxHeight),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBody(double width, height) {
    double elevation = 10;

    print(height);
    double customSpacer =
        (height > 960) ? (height - (250 + 300 + 60 + 100)) : 20;

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
              //horizonral aligment WrapAlignment.spaceAround,
              alignment: (largeScreen)
                  ? WrapAlignment.start
                  : WrapAlignment.spaceAround,
              //vertical aligment
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
            Container(
              height: customSpacer,
            ),
            crearFooter(),
          ],
        ),
      ),
    );
  }

  AppBar buildDeskAppBar() {
    return AppBar(
      // backgroundColor: Colors.blueGrey.shade600,
      backgroundColor: Colors.blueAccent,
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

  Widget buildDrawer() {
    double elevation = 15.0;
    return Container(
      width: 265,
      child: Drawer(
        elevation: elevation,
        child: Container(
          color: Colors.blueAccent,
          // Colors.blueGrey.shade700,
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 130,
                      decoration: BoxDecoration(
                          color: //Colors.blueGrey.shade900
                              Colors.blueAccent[700]),
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
    Color textColor = Colors.white;
    Color iconColor = Colors.blue[900];
    return Container(
      child: ListTile(
        title: FlatButton(
          hoverColor: Colors.blueAccent[700],
          onPressed: () {
            //set index
            Navigator.maybePop(context);
          },
          child: Row(
            children: [
              Icon(iconData, color: iconColor),
              SizedBox(
                width: 20.0,
              ),
              Text(
                name,
                style: TextStyle(color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  crearFooter() {
    return Card(
      elevation: 15.0,
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
    );
  }
}

/*
 Widget buildListTile(int index, IconData iconData, String name) {
    final isHovered = index == _hoveredIndex;
    final iconColor =
        // isHovered ? Colors.grey.shade600 : Colors.blueGrey.shade300;
        isHovered ? Colors.blueAccent : Colors.blueAccent[700];
    final textColor = isHovered ? Colors.white10 : Colors.white;
    //Colors.grey.shade800 : Colors.blueGrey.shade200;
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
*/
