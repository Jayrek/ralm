import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                  ),
                ),
              ),
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 50,
                  physics: FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      return Center(child: Text("${index + 1}"));
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
      backgroundColor: Colors.purple.shade300,
      body: SlideTransition(
        position: _animation,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/bg/constellation_zodiac_bg/cz_home_bg.jpg',
              fit: BoxFit.cover,
            ),
            Padding(
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
                                ? 'Select your birth year'
                                : selectedDate!.year.toString(),
                        width: 250,
                        // onPressed: () => _showMonthDayPicker(context),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return _dayMonthPicker();
                            },
                          );
                        },
                      ),
                      // DayMonthPicker(
                      //   onChange: (dayMonth) {
                      //     // Do something with the selected day and month
                      //     print(
                      //       'Selected Day: ${dayMonth.day}, Month: ${dayMonth.month}',
                      //     );
                      //   },
                      // ),
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
                                      SelectedConstellationZodiac(
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
          ],
        ),
      ),
    );
  }

  _dayMonthPicker() {
    return Dialog(
      child: SizedBox(
        height: 400,
        width: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [Text('MONTH'), Text('DAY')]),
            Row(
              children: [
                Column(
                  children:
                      StringConstant.monthNames.map((month) {
                        return Text(month);
                      }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
