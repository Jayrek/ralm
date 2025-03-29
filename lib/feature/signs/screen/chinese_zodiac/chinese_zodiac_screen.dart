import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';
import 'package:ralm/core/shared/widget/custom_button_rounded_widget.dart';
import 'package:ralm/feature/signs/screen/chinese_zodiac/bloc/chinese_zodiac_bloc.dart';

class ChineseZodiacScreen extends StatefulWidget {
  const ChineseZodiacScreen({super.key});

  @override
  State<ChineseZodiacScreen> createState() => _ChineseZodiacScreenState();
}

class _ChineseZodiacScreenState extends State<ChineseZodiacScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _animation = Tween<Offset>(
      begin: Offset(-1.0, 0),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  Future<void> _selectYear(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 400,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Select a Year'.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2,
                  ),
                  itemCount: 2031 - 1950,
                  itemBuilder: (context, index) {
                    int year = 2030 - index;
                    bool isSelected =
                        selectedDate != null && year == selectedDate!.year;

                    return InkWell(
                      onTap: () {
                        // TODO: set here an event to get the corresponding year in the zodiac
                        setState(() {
                          selectedDate = DateTime(year);
                        });
                        debugPrint('selectedDate: ${selectedDate!.year}');
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 10,
                        ),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          // color: isSelected ? Colors.purple : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.purple, width: 1),
                        ),
                        child: Center(
                          child: Text(
                            '$year',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<ChineseZodiacBloc>().add(FetchChineseZodiac());
    return Scaffold(
      backgroundColor: Colors.purple.shade300,
      body: SlideTransition(
        position: _animation,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomButtonRoundedWidget(
                        label: 'Chinese Zodiac',
                        width: 200,
                        onPressed: null,
                      ),
                      CustomButtonIconWidget(
                        icon: Icon(Icons.arrow_circle_left),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  CustomButtonRoundedWidget(
                    label:
                        selectedDate == null
                            ? 'Select your birth year'
                            : selectedDate!.year.toString(),
                    width: 250,
                    onPressed: () => _selectYear(context),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Expanded(
                child: BlocBuilder<ChineseZodiacBloc, ChineseZodiacState>(
                  builder: (context, state) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 40,
                        mainAxisSpacing: 40,
                        childAspectRatio: 10,
                      ),
                      itemCount: state.zodiacs.length,
                      itemBuilder: (context, index) {
                        final zodiac = state.zodiacs[index];
                        return Row(
                          children: [
                            Icon(Icons.abc_rounded),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(50),
                                    bottomRight: Radius.circular(50),
                                  ),
                                ),
                                child: Center(
                                  child: Text(zodiac.name.toUpperCase()),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
