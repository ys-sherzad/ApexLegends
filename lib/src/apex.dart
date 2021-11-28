import 'package:apex/src/scale-animation.dart';
import 'package:apex/src/utils/arrow_direction.dart';
import 'package:apex/src/widgets/arrow_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const powers = [
  {
    "nickName": "Mirage",
    "punchLine":  "I don't take myself too seriously. I don't take myself anywhere. I need to get out more",
    'realName' : "Elliot Witt",
    "age": "30",
    "homeWorld": "Solace",
    "tactical": {
      "name": "Psyche Out",
      "description": "Send out a holographic decoy to confuse the enemy."
    },
    "passive": {
      "name": "Now You See Mee...",
      "description": "Automatically cloak when using Respawn Beacons and reviving teammates."
    },
    "ultimate": "Life of the Party"
  },
  {
    "nickName": "Mirage",
    "punchLine":  "I don't take myself too seriously. I don't take myself anywhere. I need to get out more",
    'realName' : "Elliot Witt",
    "age": "30",
    "homeWorld": "Solace",
  },
  {
    "nickName": "Mirage",
    "punchLine":  "I don't take myself too seriously. I don't take myself anywhere. I need to get out more",
    'realName' : "Elliot Witt",
    "age": "30",
    "homeWorld": "Solace",
  },
  {
    "nickName": "Mirage",
    "punchLine":  "I don't take myself too seriously. I don't take myself anywhere. I need to get out more",
    'realName' : "Elliot Witt",
    "age": "30",
    "homeWorld": "Solace",
  },
  {
    "nickName": "Mirage",
    "punchLine":  "I don't take myself too seriously. I don't take myself anywhere. I need to get out more",
    'realName' : "Elliot Witt",
    "age": "30",
    "homeWorld": "Solace",
  },

];

class Apex extends HookWidget {
  const Apex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ctrl = usePageController(initialPage: 0, viewportFraction: 0.8);
    final _currentPageIndex = useState(0);
    final _isScrolling = useState(false);

    // final _pageAnimation = Tween()

    // final _currentOffset = useState(0);

    useEffect(() {
      // FIXME: There must be a better way to detect
      // the start and end of a scroll.
      _ctrl.addListener(() {
        if (_ctrl.page?.toInt() != _ctrl.page) {
          if (_isScrolling.value) return;
          _isScrolling.value = true;
        } else {
          if (!_isScrolling.value) return;
          _isScrolling.value = false;
        }
      });

      return _ctrl.dispose;
    }, [_ctrl]);

    // print('isScrolling >> ${_isScrolling.value}');
    print('currentIndex >> ${_currentPageIndex.value}');

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

    void onArrowTap(ArrowDirection direction) {
      if (direction == ArrowDirection.up) {
        if (_currentPageIndex.value != 0) {
          _currentPageIndex.value--;
          _ctrl.animateToPage(
            _currentPageIndex.value,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        }
      } else {
        if (_currentPageIndex.value != _list.length - 1) {
          _currentPageIndex.value++;
          _ctrl.animateToPage(
            _currentPageIndex.value,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        }
      }
    }

    print('currentIndex >>>>>> ${_currentPageIndex.value}');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff2d374d),
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
                  children: _list,
                  scrollDirection: Axis.vertical,
                  controller: _ctrl,
                  onPageChanged: (int index) {
                    _currentPageIndex.value = index;
                  },
                ),
              ),
              Positioned(
                top: 18,
                left: 0,
                right: 0,
                child: ScaleAnimation(
                  show: !_isScrolling.value,
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
              ),
              Positioned(
                bottom: 50,
                right: 30,
                child: Container(
                    height: 175,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (_currentPageIndex.value != 0)
                          ArrowButton(
                              direction: ArrowDirection.up,
                              onTap: onArrowTap,
                              image: Image.asset('assets/arrow-up.png')),
                        Container(),
                        if (_currentPageIndex.value != _list.length - 1)
                          ArrowButton(
                            onTap: onArrowTap,
                            direction: ArrowDirection.down,
                            image: Image.asset('assets/arrow-down.png'),
                          ),
                        // Container(
                        //   height: 49,
                        // )
                      ],
                    )),
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
