


///
///     (╯ ͡❛ ͜ʖ ͡❛)╯┻━┻
/// **************************************************************
/// Instagram @ys.sherzad  *************************
/// Twitter @ys_sherzad  ********************
/// **************************************************************
/// "Make Everyday Count" 🇦🇫
///
///

import 'package:flutter/material.dart';
import 'package:apex/src/scale-animation.dart';
import 'package:apex/src/utils/arrow_direction.dart';
import 'package:apex/src/widgets/arrow_button.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

List<Map<String, dynamic>> legends = [
  {
    "nickname": "Wraith",
    "type": "Interdimensional Skirmisher",
    "punchLine":
        "There’s a thin line between life and death. You’ll find me there.",
    'realName': "Renee Blasey",
    "age": "32",
    "homeWorld": "Typhon",
    "abilities": [
      {
        "type": "Tactical Ability",
        "name": "Into the Void",
        "description":
            "Reposition quickly through the safety of void space. avoiding all damage.",
        "icon": "assets/images/Wraith-Tactical.png",
      },
      {
        "type": "Passive Ability",
        "name": "Voices from the Void",
        "description":
            "A voice warns you when danger approaches. As far as you can tell, it's on your side.",
        "icon": "assets/images/Wraith-Passive.png",
      },
      {
        "type": "Ultimate Ability",
        "name": "Dimensional Rift",
        "description":
            "Link two locations with portals for 60 seconds, allowing your entire team to use them",
        "icon": "assets/images/Wraith-Ultimate.png",
      }
    ]
  },
  {
    "nickname": "Mirage",
    "type": "Holographic Trickster",
    "punchLine":
        "I don't take myself too seriously. I don't take myself anywhere. I need to get out more",
    'realName': "Elliot Witt",
    "age": "30",
    "homeWorld": "Solace",
    "abilities": [
      {
        "type": "Tactical Ability",
        "name": "Psyche Out",
        "description": "Send out a holographic decoy to confuse the enemy.",
        "icon": "assets/images/Mirage-Tactical.png",
      },
      {
        "type": "Passive Ability",
        "name": "Now You See Me...",
        "description":
            "Automatically cloak when using Respawn Beacons and reviving teammates.",
        "icon": "assets/images/Mirage-Passive.png",
      },
      {
        "type": "Ultimate Ability",
        "name": "Life of the Party",
        "description": "Deploy a team of Decoys to distract enemies",
        "icon": "assets/images/Mirage-Ultimate.png",
      }
    ]
  },
  {
    "nickname": "Valkyrie",
    "type": "Winged Avenger",
    "punchLine": "The skies belong to me now.",
    'realName': "Kairi Imahara",
    "age": "30",
    "homeWorld": "Angelia",
    "abilities": [
      {
        "type": "Tactical Ability",
        "name": "Missile Swarm",
        "description":
            "Fire a swarm of mini-rockets that damage and disorient the enemy.",
        "icon": "assets/images/Valkyrie-Tactical.png",
      },
      {
        "type": "Passive Ability",
        "name": "VTOL Jets",
        "description":
            "Use jetpack to fly. Fuel is limited but refills overtime.",
        "icon": "assets/images/Valkyrie-Passive.png",
      },
      {
        "type": "Ultimate Ability",
        "name": "Skyward Dive",
        "description":
            "Launch into the air and sky dive. Allies can hook into take-off systems to join you.",
        "icon": "assets/images/Valkyrie-Ultimate.png",
      }
    ]
  },
];

class Apex extends HookWidget {
  const Apex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ctrl = usePageController(initialPage: 0);
    final _currentPageIndex = useState(0);
    final _isScrolling = useState(false);

    void _handleIsScrolling() {
      if (_ctrl.page?.toInt() != _ctrl.page) {
        // if _isScrolling is already true, don't do anything
        if (_isScrolling.value) return;
        _isScrolling.value = true;
      } else {
        // if _isScrolling is already false, don't do anything
        if (!_isScrolling.value) return;
        _isScrolling.value = false;
      }
    }

    useEffect(() {
      // FIXME: There must be a better way to detect
      // the start and end of a scroll.
      _ctrl.addListener(() {
        _handleIsScrolling();
      });

      return _ctrl.dispose;
    }, [_ctrl]);

    List<Widget> _list = <Widget>[
      const Page(
        path: 'assets/images/Wraith.png',
      ),
      const Page(
        path: 'assets/images/Mirage.png',
      ),
      const Page(
        path: 'assets/images/Valkyrie.png',
      ),
    ];

    Widget _buildAbility(String path, String name, String type) {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: const Color(0xff222a3d),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(path),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      type,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(.8),
                        fontSize: 11.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    void onArrowTap(ArrowDirection direction) {
      if (direction == ArrowDirection.up) {
        if (_currentPageIndex.value != 0) {
          _ctrl.animateToPage(
            _currentPageIndex.value - 1,
            duration: const Duration(milliseconds: 650),
            curve: Curves.ease,
          );
        }
      } else {
        if (_currentPageIndex.value != _list.length - 1) {
          _ctrl.animateToPage(
            _currentPageIndex.value + 1,
            duration: const Duration(milliseconds: 650),
            curve: Curves.ease,
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff2d374d),
        elevation: 0.0,
        toolbarHeight: 0.0, // status bar color
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [Color(0xff454d5e), Color(0xff2d374d)],
          ),
        ),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 120,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ...legends[_currentPageIndex.value]['abilities']
                              .map((p) {
                            return _buildAbility(
                                p['icon'], p['name'], p['type']);
                          }).toList(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 14,
                      ),
                      child: Text(
                        '"${legends[_currentPageIndex.value]['punchLine']}"',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              right: 25,
              child: SizedBox(
                height: 132,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentPageIndex.value != 0)
                      ArrowButton(
                        direction: ArrowDirection.up,
                        onTap: onArrowTap,
                        image: Image.asset('assets/images/arrow-up.png'),
                      ),
                    Container(),
                    if (_currentPageIndex.value != _list.length - 1)
                      ArrowButton(
                        onTap: onArrowTap,
                        direction: ArrowDirection.down,
                        image: Image.asset('assets/images/arrow-down.png'),
                      ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 90,
              left: 25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    legends[_currentPageIndex.value]['nickname'],
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    legends[_currentPageIndex.value]['type'],
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * .5,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage(path),
          ),
        ),
      ),
    );
  }
}
