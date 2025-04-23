import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/feature/tarot_reading/bloc/tarot_bloc.dart';

class ViewCardDetailScreen extends StatefulWidget {
  const ViewCardDetailScreen({super.key});

  @override
  State<ViewCardDetailScreen> createState() => _ViewCardDetailScreenState();
}

class _ViewCardDetailScreenState extends State<ViewCardDetailScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.6);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<TarotBloc>();
    bloc.add(FetchTarotCards());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.stream.listen((state) {
        if (_pageController.hasClients) {
          _pageController.jumpToPage(state.selectedIndex);
          setState(() {
            _currentPage = state.selectedIndex;
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
      backgroundColor: Colors.purple.shade300,
      body: BlocBuilder<TarotBloc, TarotState>(
        builder: (context, state) {
          final tarotCards = state.tarots;

          return PageView.builder(
            controller: _pageController,
            itemCount: tarotCards.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final tarot = tarotCards[index];

              double opacity = (_currentPage == index) ? 1.0 : 0;
              double scale = (_currentPage == index) ? 1.0 : 0.95;

              return Center(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  transform: Matrix4.identity()..scale(scale),
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 300),
                    opacity: opacity,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: SingleChildScrollView(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 4,
                                  child: Container(
                                    height: 300,
                                    width: 180,
                                    decoration: BoxDecoration(
                                      color: Colors.black87,
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black87,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: AssetImage(tarot.image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    tarot.cardName.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    tarot.description,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              _currentPage !=
                                              tarotCards.length - 1,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.arrow_circle_right_outlined,
                                              size: 40,
                                              color: Colors.white,
                                            ),
                                            onPressed:
                                                _currentPage <
                                                        tarotCards.length - 1
                                                    ? () => _goToNext(
                                                      tarotCards.length,
                                                    )
                                                    : null,
                                          ),
                                        ),
                                      ],
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
              );
            },
          );
        },
      ),
    );
  }
}
