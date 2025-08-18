import 'package:flutter/material.dart';
import 'hazards/hazardsscreen.dart';
import 'reports/reportscreen.dart';
import 'settings/settings.dart';


// ---------------------------------------------

class IssueRaisedScreen extends StatefulWidget {
  const IssueRaisedScreen({super.key});

  @override
  State<IssueRaisedScreen> createState() => _IssueRaisedScreenState();
}

class _IssueRaisedScreenState extends State<IssueRaisedScreen> {
  int _selectedIndex = 0;
  late DateTime selectedDate;
  late DateTime currentMonth;
  bool _calendarExpanded = true;

  // Date constraints
  late final DateTime _minDate;
  late final DateTime _maxDate;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedDate = DateTime(now.year, now.month, now.day);
    currentMonth = DateTime(now.year, now.month, 1);

    // Can't report issues more than 2 years old or in the future
    _minDate = DateTime(now.year - 2, now.month, now.day);
    _maxDate = now;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildDateSelectionScreen(context),
          HazardsScreen(),
          ReportScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFF5B6FFF),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedLabelStyle: TextStyle(
        fontFamily: 'Exo2',
        fontSize: isTablet ? 14 : 12,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: 'Exo2',
        fontSize: isTablet ? 14 : 12,
      ),
      iconSize: isTablet ? 28 : 24,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.report_outlined),
          activeIcon: Icon(Icons.report),
          label: 'Hazard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.summarize_outlined),
          activeIcon: Icon(Icons.summarize),
          label: 'Report',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_rounded),
          activeIcon: Icon(Icons.person),
          label: 'Settings',
        ),
      ],
    );
  }






  Widget _buildDateSelectionScreen(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final isTablet = width > 600;
        final isDesktop = width > 840;
        final isLandscape = width > height;

        final horizontalPadding = isDesktop
            ? 48.0
            : isTablet
            ? (isLandscape ? width * 0.15 : width * 0.1)
            : 24.0;
        final maxWidth = isDesktop ? 720.0 : (isTablet ? 600.0 : double.infinity);

        return SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with back button
                    _buildHeader(isTablet, isDesktop),

                    // Calendar or collapsed selected date
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: _calendarExpanded
                            ? _buildCalendar(context, constraints)
                            : _buildCollapsedDate(isTablet, isDesktop),
                      ),
                    ),

                    // Next button
                    Padding(
                      padding: EdgeInsets.only(
                        top: isTablet ? 32.0 : 24.0,
                        bottom: isTablet ? 32.0 : 24.0,
                      ),
                      child: _buildNextButton(context, isTablet, isDesktop),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(bool isTablet, bool isDesktop) {
    return Padding(
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
          // Title
          Expanded(
            child: Text(
              'When did the issue start?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isDesktop ? 32 : (isTablet ? 28 : 22),
                fontWeight: FontWeight.w600,
                fontFamily: 'Exo2',
                color: Colors.black87,
              ),
            ),
          ),

          // Spacer for balance
          SizedBox(width: isTablet ? 56 : 48),
        ],
      ),
    );
  }

  Widget _buildCollapsedDate(bool isTablet, bool isDesktop) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _calendarExpanded = true;
        });
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today,
              size: isTablet ? 64 : 48,
              color: const Color(0xFF5B6FFF),
            ),
            const SizedBox(height: 24),
            Text(
              'Selected Date:',
              style: TextStyle(
                fontSize: isTablet ? 20 : 18,
                fontFamily: 'Exo2',
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _formatDate(selectedDate),
              style: TextStyle(
                fontSize: isDesktop ? 32 : (isTablet ? 28 : 24),
                fontFamily: 'Exo2',
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () {
                setState(() {
                  _calendarExpanded = true;
                });
              },
              icon: const Icon(Icons.edit),
              label: const Text('Change Date'),
              style: TextButton.styleFrom(
                textStyle: TextStyle(
                  fontSize: isTablet ? 18 : 16,
                  fontFamily: 'Exo2',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar(BuildContext context, BoxConstraints constraints) {
    final width = constraints.maxWidth;
    final isTablet = width > 600;
    final isDesktop = width > 840;

    return Column(
      children: [
        // Calendar header
        _buildCalendarHeader(isTablet, isDesktop),

        // Weekday labels
        _buildWeekdayLabels(isTablet),

        // Calendar grid
        Expanded(
          child: _buildCalendarGrid(context, constraints),
        ),

        // Date validation message
        if (_isDateOutOfRange())
          Container(
            margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.amber.shade300),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_amber, color: Colors.amber.shade700),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Please select a date within the last 2 years',
                    style: TextStyle(
                      fontSize: isTablet ? 16 : 14,
                      fontFamily: 'Exo2',
                      color: Colors.amber.shade800,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildCalendarHeader(bool isTablet, bool isDesktop) {
    return Padding(
      padding: EdgeInsets.only(bottom: isTablet ? 24.0 : 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Month/Year dropdowns
          Row(
            children: [
              // Month dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<int>(
                  value: currentMonth.month,
                  underline: const SizedBox(),
                  style: TextStyle(
                    fontSize: isDesktop ? 18 : (isTablet ? 17 : 16),
                    fontFamily: 'Exo2',
                    color: Colors.black87,
                  ),
                  items: _getMonthDropdownItems(isTablet),
                  onChanged: (newMonth) {
                    if (newMonth != null) {
                      setState(() {
                        currentMonth = DateTime(currentMonth.year, newMonth, 1);
                      });
                    }
                  },
                ),
              ),
              const SizedBox(width: 12),
              // Year dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<int>(
                  value: currentMonth.year,
                  underline: const SizedBox(),
                  style: TextStyle(
                    fontSize: isDesktop ? 18 : (isTablet ? 17 : 16),
                    fontFamily: 'Exo2',
                    color: Colors.black87,
                  ),
                  items: _getYearDropdownItems(isTablet),
                  onChanged: (newYear) {
                    if (newYear != null) {
                      setState(() {
                        currentMonth = DateTime(newYear, currentMonth.month, 1);
                      });
                    }
                  },
                ),
              ),
            ],
          ),

          // Navigation arrows
          Row(
            children: [
              IconButton(
                onPressed: _canGoPrevious() ? _previousMonth : null,
                icon: Icon(
                  Icons.chevron_left,
                  size: isTablet ? 32 : 28,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.grey.shade100,
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: _canGoNext() ? _nextMonth : null,
                icon: Icon(
                  Icons.chevron_right,
                  size: isTablet ? 32 : 28,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.grey.shade100,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeekdayLabels(bool isTablet) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: weekdays.map((day) {
          return Expanded(
            child: Center(
              child: Text(
                day,
                style: TextStyle(
                  fontSize: isTablet ? 14 : 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Exo2',
                  color: Colors.black54,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCalendarGrid(BuildContext context, BoxConstraints constraints) {
    final width = constraints.maxWidth;
    final isTablet = width > 600;
    final isDesktop = width > 840;

    // Calculate appropriate cell size based on available width
    final availableWidth = width - (isTablet ? 16 : 0);
    final cellWidth = availableWidth / 7;
    final cellHeight = isDesktop ? 60.0 : (isTablet ? 52.0 : 48.0);

    final daysInView = _getDaysInMonthView();

    return GridView.builder(
      physics: const ClampingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: cellWidth / cellHeight,
      ),
      itemCount: daysInView.length,
      itemBuilder: (context, index) {
        final date = daysInView[index];
        final isCurrentMonth = date.month == currentMonth.month;
        final isSelected = _isSameDay(date, selectedDate);
        final isToday = _isSameDay(date, DateTime.now());
        final isDisabled = date.isAfter(_maxDate) || date.isBefore(_minDate);

        return GestureDetector(
          onTap: isDisabled ? null : () => _selectDate(date),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF5B6FFF)
                  : isToday
                  ? Colors.blue.shade50
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: isToday && !isSelected
                  ? Border.all(color: Colors.blue.shade300, width: 2)
                  : null,
            ),
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle(
                  fontFamily: 'Exo2',
                  fontSize: isDesktop ? 18 : (isTablet ? 17 : 16),
                  fontWeight: isSelected || isToday ? FontWeight.w600 : FontWeight.normal,
                  color: isDisabled
                      ? Colors.grey.shade300
                      : isSelected
                      ? Colors.white
                      : isCurrentMonth
                      ? Colors.black87
                      : Colors.grey.shade400,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<DateTime> _getDaysInMonthView() {
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    // Adjust for Monday as first day of week (1 = Monday, 7 = Sunday)
    final firstDayWeekday = firstDayOfMonth.weekday;
    final daysFromPreviousMonth = firstDayWeekday - 1;

    final startDate = firstDayOfMonth.subtract(Duration(days: daysFromPreviousMonth));

    // Always show 42 days (6 weeks)
    return List.generate(42, (index) => startDate.add(Duration(days: index)));
  }

  Widget _buildNextButton(BuildContext context, bool isTablet, bool isDesktop) {
    final isValidDate = !_isDateOutOfRange();

    return SizedBox(
      width: double.infinity,
      height: isDesktop ? 68 : (isTablet ? 64 : 56),
      child: ElevatedButton.icon(
        onPressed: isValidDate
            ? () {
          // Navigate to next screen
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Selected date: ${_formatDate(selectedDate)}'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isTablet ? 12 : 8),
          ),
          elevation: 0,
        ),
        label: Text(
          'Next',
          style: TextStyle(
            fontSize: isDesktop ? 20 : (isTablet ? 18 : 16),
            fontWeight: FontWeight.w600,
            fontFamily: 'Exo2',
          ),
        ),
      ),
    );
  }


  // Helper methods
  List<DropdownMenuItem<int>> _getYearDropdownItems(bool isTablet) {
    final currentYear = DateTime.now().year;
    final startYear = currentYear - 2;
    final endYear = currentYear;

    return List.generate(endYear - startYear + 1, (index) {
      final year = startYear + index;
      return DropdownMenuItem<int>(
        value: year,
        child: Text(
          '$year',
          style: TextStyle(
            fontSize: isTablet ? 17 : 16,
            fontFamily: 'Exo2',
          ),
        ),
      );
    });
  }

  List<DropdownMenuItem<int>> _getMonthDropdownItems(bool isTablet) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    return List.generate(12, (index) {
      final month = index + 1;
      return DropdownMenuItem<int>(
        value: month,
        child: Text(
          months[index],
          style: TextStyle(
            fontSize: isTablet ? 17 : 16,
            fontFamily: 'Exo2',
          ),
        ),
      );
    });
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool _isDateOutOfRange() {
    return selectedDate.isAfter(_maxDate) || selectedDate.isBefore(_minDate);
  }

  bool _canGoPrevious() {
    final previousMonth = DateTime(currentMonth.year, currentMonth.month - 1, 1);
    return !previousMonth.isBefore(DateTime(_minDate.year, _minDate.month, 1));
  }

  bool _canGoNext() {
    final nextMonth = DateTime(currentMonth.year, currentMonth.month + 1, 1);
    return !nextMonth.isAfter(DateTime(_maxDate.year, _maxDate.month, 1));
  }

  void _selectDate(DateTime date) {
    if (!date.isAfter(_maxDate) && !date.isBefore(_minDate)) {
      setState(() {
        selectedDate = date;
        _calendarExpanded = false;
      });
    }
  }

  void _previousMonth() {
    if (_canGoPrevious()) {
      setState(() {
        currentMonth = DateTime(currentMonth.year, currentMonth.month - 1, 1);
      });
    }
  }

  void _nextMonth() {
    if (_canGoNext()) {
      setState(() {
        currentMonth = DateTime(currentMonth.year, currentMonth.month + 1, 1);
      });
    }
  }

  void _showBackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final isTablet = MediaQuery.of(context).size.width > 600;

        return AlertDialog(
          title: Text(
            'Go Back',
            style: TextStyle(
              fontFamily: 'Exo2',
              fontSize: isTablet ? 24 : 20,
            ),
          ),
          content: Text(
            'Are you sure you want to go back? Your progress may be lost.',
            style: TextStyle(
              fontFamily: 'Exo2',
              fontSize: isTablet ? 18 : 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'Exo2',
                  fontSize: isTablet ? 17 : 15,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Go back from screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
              ),
              child: Text(
                'Go Back',
                style: TextStyle(
                  fontFamily: 'Exo2',
                  fontSize: isTablet ? 17 : 15,
                ),
              ),
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


