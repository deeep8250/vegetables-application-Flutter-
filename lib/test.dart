import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int showIndex = -1;
  bool dvh = true;
  List<String> image = [
    'icons/banana.png',
    'icons/apple.png',
    'icons/cucumber.png',
    'icons/grapes.png',
    'icons/orange.png',
    'icons/strawberry.png',
    'icons/unknownf.png',
    'icons/bedana.png',
    'icons/avacado.png',
    'icons/coconut.png',
    'icons/dragon.png',
    'icons/green_grapes.png',
    'icons/guava.png',
    'icons/mango.png',
    'icons/papaya.png',
    'icons/watermelon.png',
    'icons/khajur.png',
    'icons/lichi.png',
    'icons/pineapple.png',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (MediaQuery.of(context).size.width > 750) {
        setState(() {
          dvh = !dvh;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: deviceHeight * 0.16),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _getCrossAxisCount(context),
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: image.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      showIndex = (showIndex == index) ? -1 : index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      width: 10,
                      height: 200,
                      padding: const EdgeInsets.all(1.0),
                      transform: Matrix4.identity()
                        ..translate(showIndex == index ? 0 : 0,
                            showIndex == index ? -10 : 0),
                      child: Stack(
                        children: [
                          Center(
                            child: Image.asset(image[index], fit: BoxFit.fill),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (showIndex >= 0)
            Positioned(
              top: 0,
              left: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showIndex = -1;
                  });
                },
                child: AnimatedContainer(
                  width: deviceWidth,
                  height: deviceHeight,
                  color: Colors.black54,
                  duration: const Duration(milliseconds: 500),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: deviceHeight * 0.2,
                        left: deviceWidth * 0.06,
                        child: SizedBox(
                          width: deviceWidth * 0.9,
                          height: deviceHeight * 0.9,
                          child: Image.asset(
                            "large_" + image[showIndex],
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Add cart logic here
                        },
                        icon: Icon(Icons.shopping_cart, color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = (screenWidth / 100).toInt();
    return crossAxisCount > 0 ? crossAxisCount : 1;
  }
}
