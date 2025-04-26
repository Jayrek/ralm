import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';
import 'package:ralm/core/shared/widget/custom_button_rounded_widget.dart';
import 'package:ralm/feature/signs/screen/constellation/bloc/constellation_bloc.dart';

class ConstellationScreen extends StatefulWidget {
  const ConstellationScreen({super.key});

  @override
  State<ConstellationScreen> createState() => _ConstellationScreenState();
}

class _ConstellationScreenState extends State<ConstellationScreen>
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

  void _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        // zodiacSign = getZodiacSign(selectedDate!); // Get zodiac sign
      });

      // print("Selected Zodiac Sign: $zodiacSign");
    }
  }

  void _showMonthDayPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return SizedBox(
          height: 400,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Select birth date",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 50,
                  physics: FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      return Center(
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      );
                    },
                    childCount: 12, // 12 months
                  ),
                ),
              ),
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 50,
                  physics: FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      return Center(
                        child: Text(
                          "${index + 1}",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      );
                    },
                    childCount: 31, // 31 days
                  ),
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
    context.read<ConstellationBloc>().add(FetchConstellationZodiac());
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/bg/constellation_zodiac_bg/cz_home_bg.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(0.4),
          child: SlideTransition(
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
                            label: 'Constellation Zodiac',
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
                                ? 'Select your birth date'
                                : DateFormat('MMM dd').format(selectedDate!),
                        width: 250,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return _dayMonthPicker(
                                onSelected: (month, day) {
                                  final picked = DateTime(2000, month, day);
                                  setState(() {
                                    selectedDate = DateTime(2000, month, day);
                                  });
                                  context.read<ConstellationBloc>().add(
                                    SelectedConstellationZodiac(picked),
                                  );
                                  Navigator.pop(context);
                                  Navigator.pushNamed(
                                    context,
                                    StringConstant.navConstellationZodiacDetail,
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Expanded(
                    child: BlocBuilder<ConstellationBloc, ConstellationState>(
                      builder: (context, state) {
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
                                childAspectRatio: 2.5,
                              ),
                          itemCount: state.zodiacs.length,
                          itemBuilder: (context, index) {
                            final constellation = state.zodiacs[index];
                            final columnIndex = index % 4;

                            final List<Color> columnColors = [
                              Colors.purple.shade200,
                              Colors.teal.shade400,
                              Colors.blue.shade200,
                              Colors.orange.shade300,
                            ];

                            final buttonColor = columnColors[columnIndex];
                            return Center(
                              child: Material(
                                elevation: 4,
                                color:
                                    Colors
                                        .transparent, // keep background color from button
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    // backgroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 50,
                                      vertical: 20,
                                    ),
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    side: BorderSide(
                                      color: buttonColor,
                                      width: 3,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                  ),
                                  onPressed: () {
                                    context.read<ConstellationBloc>().add(
                                      SelectedConstellationIndividualZodiac(
                                        dateRange: constellation.dateRange,
                                      ),
                                    );
                                    Navigator.pushNamed(
                                      context,
                                      StringConstant
                                          .navConstellationZodiacDetail,
                                    );
                                  },
                                  child: Text(
                                    constellation.name.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ),
                            );

                            // return InkWell(
                            //   onTap: () {
                            //     context.read<ConstellationBloc>().add(
                            //       SelectedConstellationZodiac(
                            //         dateRange: constellation.dateRange,
                            //       ),
                            //     );
                            //     Navigator.pushNamed(
                            //       context,
                            //       StringConstant.navConstellationZodiacDetail,
                            //     );
                            //   },
                            //   child: Expanded(
                            //     child: Container(
                            //       height: 60,
                            //       decoration: BoxDecoration(
                            //         border: Border.all(
                            //           width: 3,
                            //           color: buttonColor,
                            //         ),
                            //       ),
                            //       child: Center(
                            //         child: Text(
                            //           constellation.name.toUpperCase(),
                            //           style: TextStyle(
                            //             fontWeight: FontWeight.bold,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dayMonthPicker({
    required void Function(int month, int day) onSelected,
  }) {
    int selectedMonth = 1;
    int selectedDay = 1;

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 400,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Select your birth date',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                        initialItem: selectedMonth - 1,
                      ),
                      itemExtent: 40,
                      onSelectedItemChanged: (index) {
                        selectedMonth = index + 1;
                      },
                      children: List.generate(
                        12,
                        (index) => Center(
                          child: Text(
                            StringConstant.monthNames[index],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                        initialItem: selectedDay - 1,
                      ),
                      itemExtent: 40,
                      onSelectedItemChanged: (index) {
                        selectedDay = index + 1;
                      },
                      children: List.generate(
                        31,
                        (index) => Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  final selected = DateTime(2000, selectedMonth, selectedDay);
                  final formatted = DateFormat('MMM/dd').format(selected);
                  print('Selected: $formatted');
                  onSelected(selectedMonth, selectedDay);
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
