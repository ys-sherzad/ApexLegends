import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// const List<>

class Apex extends HookWidget {
  const Apex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ctrl = usePageController(initialPage: 0);
    final _currentPageIndex = useState(0);
    final _isScrolling = useState(false);

    // final _currentOffset = useState(0);

    useEffect(() {
      var unsubscribe = _ctrl.addListener(() {
        if (_ctrl.page?.toInt() != _ctrl.page) {
          if (_isScrolling.value) return;
          print('SETTING ISSCROLLING TRUE <<<<<<<');
          _isScrolling.value = true;
        } else {
          if (!_isScrolling.value) return;
          print('SETTING ISSCROLLING FALSE <<<<<<<');
          _isScrolling.value = false;
          _currentPageIndex.value = _ctrl.page?.toInt() ?? 0;
        }
      });

      return () => unsubscribe;
    }, [_ctrl]);

    // print('isScrolling >> ${_isScrolling.value}');
    // print('currentIndex >> ${_currentPageIndex.value}');

    List<Widget> _list = <Widget>[
      const Page(
        path: 'assets/Wraith.png',
      ),
      const Page(
        path: 'assets/Mirage.png',
      ),
      const Page(
        path: 'assets/Valkyrie.png',
      ),
    ];

    Widget _buildAbility(String path, String name) {
      return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: const Color(0xff222a3d),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(path),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    // print('value >>>> ${_ctrl.position.isScrollingNotifier.value}');

    // print('isScrolling >>> ${_isScrolling.value}');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2d374d),
        elevation: 0.0,
        toolbarHeight: 0.0, // status bar color
      ),
      body: SafeArea(
        // top: false,
        bottom: false,
        left: false,
        right: false,
        child: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [Color(0xff454d5e), Color(0xff2d374d)],
            ),
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned.fill(
                child: PageView(
                  // pageSnapping: false,
                  children: _list,

                  // physics: const BouncingScrollPhysics(),
                  // dragStartBehavior: DragStartBehavior.down,
                  scrollDirection: Axis.vertical,
                  controller: _ctrl,
                  // onPageChanged: (int index) {
                  //   print("Page Changed: $index");
                  //   // _currentPageIndex.value = index;
                  // },
                ),
              ),
              Positioned(
                top: 18,
                left: 0,
                right: 0,
                child: Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildAbility('assets/Wraith-Tactical.png', 'Tactical'),
                      const SizedBox(width: 8.0),
                      _buildAbility('assets/Wraith-Passive.png', 'Passive'),
                      const SizedBox(width: 8.0),
                      _buildAbility('assets/Wraith-Ultimate.png', 'Ultimate'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Page extends StatelessWidget {
  const Page({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * .55,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage(path),
            ),
          ),
        ),
      ),
    );
  }
}