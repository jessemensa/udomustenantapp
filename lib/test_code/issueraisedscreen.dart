import 'package:flutter/material.dart';



class IssueRaisedScreen extends StatefulWidget {
  const IssueRaisedScreen({super.key});

  @override
  State<IssueRaisedScreen> createState() => _IssueRaisedScreenState();
}

class _IssueRaisedScreenState extends State<IssueRaisedScreen> {
  int _selectedIndex = 0;
  DateTime selectedDate = DateTime(2025, 10, 28);
  DateTime currentMonth = DateTime(2025, 10, 1);
  bool _calendarExpanded = true;

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;
    // final isTablet = screenSize.width > 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(context),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF5B6FFF),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: false,
        showSelectedLabels: true,
        selectedLabelStyle: const TextStyle(fontFamily: 'Exo2'),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Exo2'),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.report_rounded),
            label: 'Hazard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.summarize_outlined),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;
    final isLandscape = screenSize.width > screenSize.height;
    final horizontalPadding = isTablet
        ? (isLandscape ? screenSize.width * 0.15 : screenSize.width * 0.1)
        : 24.0;
    final maxWidth = isTablet ? 600.0 : double.infinity;

    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                Padding(
                  padding: EdgeInsets.only(
                    top: isTablet ? 32.0 : 24.0,
                    bottom: isTablet ? 32.0 : 24.0,
                  ),
                  child: Row(
                    children: [
                      // Back button
                      GestureDetector(
                        onTap: () => _showBackDialog(context),
                        child: Container(
                          width: isTablet ? 56 : 48,
                          height: isTablet ? 56 : 48,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            shape: BoxShape.circle,
                          ),
                          child: Align(
                            alignment: Alignment(-2, 0), // -1.0 is far left, 0 is center, 1.0 is far right
                            child: Icon(
                              Icons.arrow_back,
                              color: const Color.fromARGB(255, 0, 0, 0),
                              size: isTablet ? 28 : 24,
                            ),
                          ),
                        ),
                      ),
                      // Text takes remaining space
                      Expanded(
                        child: Text(
                          'When did the issue start?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: isTablet ? 28 : 22,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Exo2',
                            color: Colors.black,
                          ),
                        ),
                      ),
                      // Invisible spacer to balance the layout
                      SizedBox(width: isTablet ? 56 : 48),
                    ],
                  ),

                ),
                // Calendar or collapsed selected date
                Expanded(
                  child: _calendarExpanded
                      ? _buildCalendar(context)
                      : GestureDetector(
                    onTap: () {
                      setState(() {
                        _calendarExpanded = true;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Selected Date: ${_formatDate(selectedDate)}\n(Tap to change)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isTablet ? 28 : 22,
                          fontFamily: 'Exo2',
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                // Next button
                Padding(
                  padding: EdgeInsets.only(
                    top: isTablet ? 32.0 : 24.0,
                    bottom: isTablet ? 32.0 : 24.0,
                  ),
                  child: _buildNextButton(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Column(
      children: [
        // Header with dropdowns and navigation
        Padding(
          padding: EdgeInsets.only(bottom: isTablet ? 32.0 : 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Year dropdown
                  DropdownButton<int>(
                    value: currentMonth.year,
                    items: _getYearDropdownItems(),
                    onChanged: (newYear) {
                      if (newYear != null) {
                        setState(() {
                          currentMonth =
                              DateTime(newYear, currentMonth.month, 1);
                        });
                      }
                    },
                  ),
                  const SizedBox(width: 8),
                  // Month dropdown
                  DropdownButton<int>(
                    value: currentMonth.month,
                    items: _getMonthDropdownItems(),
                    onChanged: (newMonth) {
                      if (newMonth != null) {
                        setState(() {
                          currentMonth =
                              DateTime(currentMonth.year, newMonth, 1);
                        });
                      }
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: _previousMonth,
                    child: Container(
                      width: isTablet ? 40 : 32,
                      height: isTablet ? 40 : 32,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.chevron_left,
                        size: isTablet ? 24 : 20,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  SizedBox(width: isTablet ? 12 : 8),
                  GestureDetector(
                    onTap: _nextMonth,
                    child: Container(
                      width: isTablet ? 40 : 32,
                      height: isTablet ? 40 : 32,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.chevron_right,
                        size: isTablet ? 24 : 20,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Calendar grid
        Expanded(
          child: _buildCalendarGrid(context),
        ),
      ],
    );
  }

  List<DropdownMenuItem<int>> _getYearDropdownItems() {
    const startYear = 2020;
    const endYear = 2030;
    return List.generate(endYear - startYear + 1, (index) {
      final year = startYear + index;
      return DropdownMenuItem<int>(
          value: year,
          child: Text(
            '$year',
            style: const TextStyle(fontSize: 16, fontFamily: 'Exo2'),
          )
      );
    });
  }

  List<DropdownMenuItem<int>> _getMonthDropdownItems() {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return List.generate(12, (index) {
      final month = index + 1;
      return DropdownMenuItem<int>(
        value: month,
        child: Text(months[index],
          style: const TextStyle(fontSize: 16, fontFamily: 'Exo2'),
        ),
      );
    });
  }

  Widget _buildCalendarGrid(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    final cellSize = isTablet ? 56.0 : 44.0;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: 42,
      itemBuilder: (context, index) {
        final date = _getDateForIndex(index);
        final isCurrentMonth = date.month == currentMonth.month;
        final isSelected = _isSameDay(date, selectedDate);

        return GestureDetector(
          onTap: () => _selectDate(date),
          child: Container(
            height: cellSize,
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF4F46E5)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle(
                  fontFamily: 'Exo2',
                  fontSize: isTablet ? 18 : 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected
                      ? Colors.white
                      : isCurrentMonth
                      ? Colors.black
                      : Colors.grey.shade400,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNextButton(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return SizedBox(
      width: double.infinity,
      height: isTablet ? 64 : 56,
      child: ElevatedButton(
        onPressed: () => {
          // Navigator.of(context).push(
          //     MaterialPageRoute(
          //         builder: (context) => const NumberofTenantsScreen()
          //     )
          // )
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isTablet ? 12 : 8),
          ),
          elevation: 0,
        ),
        child: Text(
          'Next',
          style: TextStyle(
              fontSize: isTablet ? 20 : 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Exo2'
          ),
        ),
      ),
    );
  }

  DateTime _getDateForIndex(int index) {
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final firstDayWeekday = firstDayOfMonth.weekday % 7;
    final startDate = firstDayOfMonth.subtract(Duration(days: firstDayWeekday));
    return startDate.add(Duration(days: index));
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  void _selectDate(DateTime date) {
    setState(() {
      selectedDate = date;
      _calendarExpanded = false;
    });
  }

  void _previousMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1, 1);
    });
  }

  void _showBackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Go Back',
            style: TextStyle(fontFamily: 'Exo2'),
          ),
          content: const Text(
              'Are you sure you want to go back? Your progress may be lost.',
              style: TextStyle(fontFamily: 'Exo2')),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(fontFamily: 'Exo2'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                  'Go Back',
                  style: TextStyle(fontFamily: 'Exo2')),
            ),
          ],
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
