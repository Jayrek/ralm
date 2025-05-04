import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/core/shared/widget/animated_tarot_cad_widget.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';
import 'package:ralm/core/util/shared_pref_util.dart';
import 'package:ralm/feature/avatar/bloc/avatar_bloc.dart';
import 'package:ralm/feature/discover/bloc/discover_bloc.dart';
import 'package:ralm/feature/know_yourself/screen/elemental_soul/bloc/elemental_soul_bloc.dart';
import 'package:ralm/feature/know_yourself/screen/myers_briggs/bloc/myers_briggs_bloc.dart';
import 'package:ralm/feature/know_yourself/screen/your_color/bloc/your_color_bloc.dart';
import 'package:ralm/feature/signs/screen/chinese_zodiac/bloc/chinese_zodiac_bloc.dart';
import 'package:ralm/feature/signs/screen/constellation/bloc/constellation_bloc.dart';
import 'package:ralm/models/avatar.dart';
import 'package:ralm/models/tarot.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  List<Tarot> pickedCards = [];
  final TextEditingController _userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _handlePickedCards();

    // getMyersBriggsResult

    context.read<ConstellationBloc>().add(FetchConstellationZodiac());
    context.read<ChineseZodiacBloc>().add(FetchChineseZodiac());
    context.read<MyersBriggsBloc>().add(GetMyersBriggesResult());
    context.read<ConstellationBloc>().add(GetAvatarContestllation());
    context.read<ElementalSoulBloc>().add(GetAvatarElementalSoul());
    context.read<YourColorBloc>().add(GetAvatarYourColor());
    context.read<DiscoverBloc>().add(GetDiscoverUserName());
    context.read<DiscoverBloc>().add(GetZodiacFromBDate());
    // _userNameController.addListener(() {
    //   final name = _userNameController.text.trim();
    //   context.read<DiscoverBloc>().add(SaveDiscoverUserName(name: name));
    // });
  }

  Future<void> _handlePickedCards() async {
    await resetPickedTarots();
    List<Tarot> cards = await loadPickedCards();
    setState(() {
      pickedCards = cards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg/discover/discover_bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: Colors.black.withOpacity(0.4),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                child: Stack(
                  children: [
                    CustomButtonIconWidget(
                      icon: Icon(Icons.arrow_circle_left),
                      onPressed: () {
                        Navigator.popUntil(
                          context,
                          ModalRoute.withName(
                            StringConstant.navDashboardScreenKey,
                          ),
                        );
                      },
                    ),
                    Center(
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Material(
                            elevation: 4,
                            shape: CircleBorder(),
                            color: Colors.transparent,
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              customBorder: CircleBorder(),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  StringConstant.navAvatar,
                                );
                              },
                              child:
                                  BlocSelector<AvatarBloc, AvatarState, Avatar>(
                                    selector: (state) => state.defaultAvatar,
                                    builder: (context, avatar) {
                                      return Container(
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.blue,
                                            width: 3,
                                          ),
                                        ),
                                        child: CircleAvatar(
                                          radius: 70,
                                          backgroundImage: AssetImage(
                                            avatar.image,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                            ),
                          ),
                          SizedBox(height: 20),

                          // user name here...
                          SizedBox(
                            width: 150,
                            child: BlocSelector<
                              DiscoverBloc,
                              DiscoverState,
                              String
                            >(
                              selector: (state) => state.userName,
                              builder: (context, userName) {
                                if (_userNameController.text != userName) {
                                  _userNameController.text = userName;
                                  _userNameController
                                      .selection = TextSelection.fromPosition(
                                    TextPosition(
                                      offset: _userNameController.text.length,
                                    ),
                                  );
                                }
                                return TextField(
                                  controller: _userNameController,
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    final name = value.trim();
                                    context.read<DiscoverBloc>().add(
                                      SaveDiscoverUserName(name: name),
                                    );
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ), // Customize border color
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: Colors.purple,
                                      ),
                                    ),
                                  ),
                                  style: TextStyle(fontSize: 16),
                                );
                              },
                            ),
                          ),

                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                spacing: 5,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return _dayMonthYearPicker(
                                            onSelected: (year, month, day) {
                                              final selectedDate = DateTime(
                                                year,
                                                month,
                                                day,
                                              );
                                              final bdayFormat = DateFormat(
                                                'MMM dd yyyy',
                                              ).format(selectedDate);
                                              context.read<DiscoverBloc>().add(
                                                SaveZodiacFromBDate(
                                                  bday: bdayFormat,
                                                ),
                                              );
                                              context
                                                  .read<ConstellationBloc>()
                                                  .add(
                                                    SelectedConstellationZodiac(
                                                      selectedDate,
                                                    ),
                                                  );
                                              context
                                                  .read<ChineseZodiacBloc>()
                                                  .add(
                                                    SelectedChineseZodiac(
                                                      year: year,
                                                    ),
                                                  );
                                              debugPrint(
                                                'Selected Date: $bdayFormat',
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                    child: BlocSelector<
                                      DiscoverBloc,
                                      DiscoverState,
                                      String
                                    >(
                                      selector: (state) => state.bday,
                                      builder: (context, bday) {
                                        return Text(
                                          'Birthday: ${bday.isEmpty ? 'N/A' : bday}',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: BlocSelector<
                                      ConstellationBloc,
                                      ConstellationState,
                                      String
                                    >(
                                      selector: (state) {
                                        return state.constellationValue;
                                      },
                                      builder: (context, constellation) {
                                        return Text(
                                          'Constellation: ${constellation.isEmpty ? 'N/A' : constellation}',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: BlocSelector<
                                      ChineseZodiacBloc,
                                      ChineseZodiacState,
                                      String
                                    >(
                                      selector: (state) {
                                        return state.zodiacValue;
                                      },
                                      builder: (context, zodiac) {
                                        return Text(
                                          'Chinese Zodiac: ${zodiac.isEmpty ? 'N/A' : zodiac}',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              // SizedBox(width: 40),
                              Column(
                                spacing: 5,
                                children: [
                                  BlocSelector<
                                    ElementalSoulBloc,
                                    ElementalSoulState,
                                    String
                                  >(
                                    selector: (state) => state.avatarUnLocked,
                                    builder: (context, state) {
                                      final soul =
                                          state == 'No' ? 'N/A' : state;
                                      return TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Elemental Soul: $soul',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  BlocSelector<
                                    YourColorBloc,
                                    YourColorState,
                                    String
                                  >(
                                    selector: (state) => state.avatarUnLocked,
                                    builder: (context, state) {
                                      final color =
                                          state == 'No' ? 'N/A' : state;
                                      return TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Aura Color: $color',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  BlocSelector<
                                    MyersBriggsBloc,
                                    MyersBriggsState,
                                    String
                                  >(
                                    selector:
                                        (state) => state.personalityResult,
                                    builder: (context, state) {
                                      final personality =
                                          state.isEmpty ? 'N/A' : state;
                                      return TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'MBTI: $personality',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // Row(
                          //   spacing: 40,
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     TextButton(
                          //       onPressed: () {
                          //         showDialog(
                          //           context: context,
                          //           builder: (context) {
                          //             return _dayMonthYearPicker(
                          //               onSelected: (year, month, day) {
                          //                 print(
                          //                   'Selected Date: $year-$month-$day',
                          //                 );
                          //               },
                          //             );
                          //           },
                          //         );
                          //       },
                          //       child: Text(
                          //         'Birthday: ',
                          //         style: TextStyle(
                          //           fontFamily: 'Poppins',
                          //           fontSize: 15,
                          //         ),
                          //       ),
                          //     ),
                          //     BlocSelector<
                          //       ElementalSoulBloc,
                          //       ElementalSoulState,
                          //       String
                          //     >(
                          //       selector: (state) => state.avatarUnLocked,
                          //       builder: (context, state) {
                          //         final soul = state == 'No' ? 'N/A' : state;
                          //         return Text(
                          //           'Elemental Soul: $soul',
                          //           style: TextStyle(
                          //             fontFamily: 'Poppins',
                          //             fontSize: 15,
                          //           ),
                          //         );
                          //       },
                          //     ),
                          //   ],
                          // ),
                          // Row(
                          //   spacing: 40,
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     Text(
                          //       'Constellation: N/A',
                          //       style: TextStyle(
                          //         fontFamily: 'Poppins',
                          //         fontSize: 15,
                          //       ),
                          //     ),
                          //     BlocSelector<
                          //       YourColorBloc,
                          //       YourColorState,
                          //       String
                          //     >(
                          //       selector: (state) => state.avatarUnLocked,
                          //       builder: (context, state) {
                          //         final color = state == 'No' ? 'N/A' : state;
                          //         return Text(
                          //           'Aura Color: $color',
                          //           style: TextStyle(
                          //             fontFamily: 'Poppins',
                          //             fontSize: 15,
                          //           ),
                          //         );
                          //       },
                          //     ),
                          //   ],
                          // ),

                          // Row(
                          //   spacing: 40,
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     Text(
                          //       'Chinese Zodiac: N/A',
                          //       style: TextStyle(
                          //         fontFamily: 'Poppins',
                          //         fontSize: 15,
                          //       ),
                          //     ),
                          //     BlocSelector<
                          //       MyersBriggsBloc,
                          //       MyersBriggsState,
                          //       String
                          //     >(
                          //       selector: (state) => state.personalityResult,
                          //       builder: (context, state) {
                          //         final personality =
                          //             state.isEmpty ? 'N/A' : state;
                          //         return Text(
                          //           'MBTI: $personality',
                          //           style: TextStyle(
                          //             fontFamily: 'Poppins',
                          //             fontSize: 15,
                          //           ),
                          //         );
                          //       },
                          //     ),
                          //   ],
                          // ),
                          SizedBox(height: 20),
                          TextButton(
                            child: Text(
                              'Clear All',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {},
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            child: Text(
                              'DAILY TAROT CARD',
                              style: TextStyle(fontFamily: 'Poppins'),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              3,
                              (index) => AnimatedTarotCardWidget(
                                tarot:
                                    pickedCards.isNotEmpty
                                        ? pickedCards[index]
                                        : null,
                              ),
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
    );
  }

  Widget _dayMonthYearPicker({
    required void Function(int year, int month, int day) onSelected,
  }) {
    int selectedYear = 2000;
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
                            style: const TextStyle(
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
                            style: const TextStyle(
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
                        initialItem: selectedYear - 1900,
                      ),
                      itemExtent: 40,
                      onSelectedItemChanged: (index) {
                        selectedYear = 1900 + index;
                      },
                      children: List.generate(
                        201, // 1900 to 2100
                        (index) => Center(
                          child: Text(
                            '${1900 + index}',
                            style: const TextStyle(
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
                  final selected = DateTime(
                    selectedYear,
                    selectedMonth,
                    selectedDay,
                  );
                  final formatted = DateFormat('y/MM/dd').format(selected);
                  print('Selected: $formatted');
                  onSelected(selectedYear, selectedMonth, selectedDay);
                },
                child: const Text(
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

  @override
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }
}
