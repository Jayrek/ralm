import 'package:flutter/material.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';
import 'package:ralm/models/tarot.dart';

class ViewPickedCardScreen extends StatefulWidget {
  const ViewPickedCardScreen({super.key});

  @override
  State<ViewPickedCardScreen> createState() => _ViewPickedCardScreenState();
}

class _ViewPickedCardScreenState extends State<ViewPickedCardScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.6);
  int _currentPage = 0;
  late List<Tarot> pickedCards = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (ModalRoute.of(context)!.settings.arguments != null &&
        pickedCards.isEmpty) {
      pickedCards = ModalRoute.of(context)!.settings.arguments as List<Tarot>;
    }
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
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg/tarot_bg/tc_card_result_bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: Colors.black.withOpacity(0.4),
              child: PageView.builder(
                controller: _pageController,
                itemCount: pickedCards.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final tarot = pickedCards[index];

                  double opacity = (_currentPage == index) ? 1.0 : 0.1;
                  double scale = (_currentPage == index) ? 1.0 : 0.95;

                  return Center(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      transform: Matrix4.identity()..scale(scale),
                      // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: opacity,
                        child: SizedBox(
                          height: 500,
                          // width: MediaQuery.of(context).size.width * 0.9,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    (index == 0
                                            ? 'First Card'
                                            : index == 1
                                            ? 'Second Card '
                                            : 'Third Card')
                                        .toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    _buildImageContainerWidget(tarot.image),
                                    _buildTarotCardInfoWidget(tarot),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: CustomButtonIconWidget(
              icon: Icon(Icons.arrow_circle_left),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  _buildImageContainerWidget(String image) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          child: Container(
            height: 350,
            width: 180,
            decoration: BoxDecoration(
              color: Colors.black45,
              border: Border.all(width: 1, color: Colors.black87),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildTarotCardInfoWidget(Tarot tarot) {
    return Expanded(
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
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 10),
          Text(
            tarot.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          ),

          // Left & Right Navigation Buttons
          Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 10),
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
                    onPressed: _currentPage > 0 ? _goToPrevious : null,
                  ),
                ),
                SizedBox(width: 200),
                Visibility(
                  visible: _currentPage != pickedCards.length - 1,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_circle_right_outlined,
                      size: 40,
                      color: Colors.white,
                    ),
                    onPressed:
                        _currentPage < pickedCards.length - 1
                            ? () => _goToNext(pickedCards.length)
                            : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
