import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/feature/signs/screen/chinese_zodiac/bloc/chinese_zodiac_bloc.dart';

class ChineseZodiacDetailScreen extends StatefulWidget {
  const ChineseZodiacDetailScreen({super.key});

  @override
  State<ChineseZodiacDetailScreen> createState() =>
      _ChineseZodiacDetailScreenState();
}

class _ChineseZodiacDetailScreenState extends State<ChineseZodiacDetailScreen> {
  final PageController _pageController = PageController();
  // final PageController _pageController = PageController(viewportFraction: 0.6);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<ChineseZodiacBloc>();
    bloc.add(FetchChineseZodiac());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.stream.listen((state) {
        if (_pageController.hasClients) {
          _pageController.jumpToPage(state.selectedZodiacIndex);
          setState(() {
            _currentPage = state.selectedZodiacIndex;
          });
        }
      });
    });
  }

  void _goToPrevious() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNext(int totalZodiacs) {
    if (_currentPage < totalZodiacs - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade300,
      body: BlocBuilder<ChineseZodiacBloc, ChineseZodiacState>(
        builder: (context, state) {
          final zodiacs = state.zodiacs;

          return PageView.builder(
            controller: _pageController,
            itemCount: zodiacs.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final zodiac = zodiacs[index];

              double opacity = (_currentPage == index) ? 1.0 : 0;
              double scale = (_currentPage == index) ? 1.0 : 0.95;

              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(zodiac.bg, fit: BoxFit.cover),
                  Center(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      transform: Matrix4.identity()..scale(scale),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 40,
                      ),
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: opacity,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  zodiac.name.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Years ${zodiac.years}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  zodiac.chineseZodiacData.description,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Best Traits: ${zodiac.chineseZodiacData.bestTraits}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Lucky Number: ${zodiac.chineseZodiacData.luckyNumber}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Lucky Color: ${zodiac.chineseZodiacData.luckyColor}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Best Partners: ${zodiac.chineseZodiacData.bestPartners}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Bad Compatible: ${zodiac.chineseZodiacData.badCompatible}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),

                                // Left & Right Navigation Buttons
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 50,
                                    bottom: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Visibility(
                                        visible: _currentPage != 0,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.arrow_circle_left_outlined,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                          onPressed:
                                              _currentPage > 0
                                                  ? _goToPrevious
                                                  : null,
                                        ),
                                      ),
                                      SizedBox(width: 200),
                                      Visibility(
                                        visible:
                                            _currentPage != zodiacs.length - 1,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.arrow_circle_right_outlined,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                          onPressed:
                                              _currentPage < zodiacs.length - 1
                                                  ? () =>
                                                      _goToNext(zodiacs.length)
                                                  : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
