import 'package:flutter/material.dart';
import 'hazards/hazardsscreen.dart';
import 'reports/reportscreen.dart';
import 'settings/settings.dart';
import 'numberoftenantscreen.dart';
import 'movefurniturewithoutassistancescreen.dart';

class PreviousDampMouldScreen extends StatefulWidget {
  const PreviousDampMouldScreen({super.key});

  @override
  State<PreviousDampMouldScreen> createState() => _PreviousDampMouldScreenState();
}

class _PreviousDampMouldScreenState extends State<PreviousDampMouldScreen> {
  String? _selected;
  // String? _timeframe;
  // String? _resolution;
  int _selectedIndex = 0;
  // bool _showAdditionalQuestions = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildMainScreen(context),
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
          activeIcon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }

  Widget _buildMainScreen(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          // final height = constraints.maxHeight;
          final isTablet = width > 600;
          final isDesktop = width > 840;
          // final isLandscape = width > height;

          // Adaptive sizing
          final double horizontalPadding = isDesktop
              ? 48
              : (isTablet ? 32 : 20);
          final double maxContentWidth = isDesktop
              ? 600
              : (isTablet ? 500 : double.infinity);
          final double titleFontSize = isDesktop
              ? 26
              : (isTablet ? 22 : 19);
          final double bodyFontSize = isDesktop
              ? 18
              : (isTablet ? 17 : 16);
          final double buttonHeight = isDesktop
              ? 64
              : (isTablet ? 56 : 48);

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxContentWidth),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Custom Header
                    _buildHeader(context, isTablet, isDesktop),

                    // Main content with scroll
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: isTablet ? 40 : 24),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone_in_talk, // or whatever icon you prefer
                                  size: isTablet ? 24 : 28,
                                  color: const Color(0xFF5B6FFF),
                                ),
                                SizedBox(width: isTablet ? 20 : 15),
                                Expanded(
                                  child: Text(
                                    'Have you previously reported this issues at this property?',
                                    style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                      fontFamily: 'Exo2',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: isTablet ? 12 : 8),

                            // Helper text
                            Text(
                              'This helps us understand if this is a recurring issue',
                              style: TextStyle(
                                fontSize: bodyFontSize - 2,
                                fontFamily: 'Exo2',
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: isTablet ? 28 : 20),
                            // Primary dropdown
                            _buildPrimaryDropdown(bodyFontSize, isTablet),
                          ],
                        ),
                      ),
                    ),

                    // Bottom section with buttons
                    _buildBottomSection(context, buttonHeight, bodyFontSize, isTablet),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isTablet, bool isDesktop) {
    return Padding(
      padding: EdgeInsets.only(
        top: isTablet ? 24 : 16,
        bottom: isTablet ? 16 : 8,
      ),
      child: Row(
        children: [
          // Back button
          IconButton(
            onPressed: () => _showBackDialog(context),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black87,
              size: isDesktop ? 28 : (isTablet ? 26 : 24),
            ),
            style: IconButton.styleFrom(
              backgroundColor: Colors.grey.shade100,
              padding: EdgeInsets.all(isTablet ? 12 : 8),
            ),
          ),

          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _buildPrimaryDropdown(double bodyFontSize, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Previous reports',
          style: TextStyle(
            fontSize: bodyFontSize - 2,
            fontFamily: 'Exo2',
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: isTablet ? 16 : 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF5B6FFF), width: 2),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
          ),
          hint: Text(
            'Please select',
            style: TextStyle(
              fontFamily: 'Exo2',
              fontSize: bodyFontSize,
              color: Colors.black54,
            ),
          ),
          value: _selected,
          items: [
            'Yes, I have reported this before',
            'No, this is the first time',
            'Not sure',
          ].map((label) => DropdownMenuItem(
            value: label,
            child: Text(
              label,
              style: TextStyle(
                fontSize: bodyFontSize,
                fontFamily: 'Exo2',
                color: Colors.black87,
              ),
            ),
          )).toList(),
          onChanged: (value) {
            setState(() {
              _selected = value;
              // _showAdditionalQuestions = value?.startsWith('Yes') ?? false;
              // if (!_showAdditionalQuestions) {
              //   _timeframe = null;
              //   _resolution = null;
              // }
            });
          },
          icon: Icon(
            Icons.arrow_drop_down_rounded,
            size: isTablet ? 32 : 28,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSection(BuildContext context, double buttonHeight, double bodyFontSize, bool isTablet) {
    final isValid = _isValidSelection();

    return Column(
      children: [
        const Divider(height: 1),

        Padding(
          padding: EdgeInsets.symmetric(vertical: isTablet ? 20 : 16),
          child: Row(
            children: [
              // Previous button
              const SizedBox(width: 12),
              // Next button
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: buttonHeight,
                  child: ElevatedButton.icon(
                    onPressed: isValid
                        ? () {

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MoveFurnitureWithoutAssistanceScreen(),
                        ),
                      );

                      // Prepare data
                      // final reportData = {
                      //   'previouslyReported': _selected,
                      //   if (_timeframe != null) 'timeframe': _timeframe,
                      //   if (_resolution != null) 'resolution': _resolution,
                      // };
                      //
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text('Report data: ${reportData.toString()}'),
                      //     duration: const Duration(seconds: 2),
                      //   ),
                      // );

                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => const MoveFurnitureWithoutAssistanceScreen(),
                      //   ),
                      // );
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade300,
                      disabledForegroundColor: Colors.grey.shade500,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: isValid ? 2 : 0,
                    ),
                    label: Text(
                      'Next',
                      style: TextStyle(
                        fontSize: bodyFontSize,
                        fontFamily: 'Exo2',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget _buildPlaceholderScreen(String title, IconData icon) {
  //   return Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Icon(icon, size: 64, color: Colors.grey),
  //         const SizedBox(height: 16),
  //         Text(
  //           title,
  //           style: const TextStyle(
  //             fontSize: 24,
  //             fontFamily: 'Exo2',
  //             color: Colors.grey,
  //           ),
  //         ),
  //         const SizedBox(height: 8),
  //         const Text(
  //           'Coming Soon',
  //           style: TextStyle(
  //             fontSize: 16,
  //             fontFamily: 'Exo2',
  //             color: Colors.grey,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  bool _isValidSelection() {
    if (_selected == null) return false;

    // If "Yes" is selected, require additional fields

    // if (_selected!.startsWith('Yes')) {
    //   return _timeframe != null && _resolution != null;
    // }

    return true;
  }

  void _showBackDialog(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Leave Form?',
            style: TextStyle(
              fontFamily: 'Exo2',
              fontSize: isTablet ? 24 : 20,
            ),
          ),
          content: Text(
            'Your progress will be lost if you go back.',
            style: TextStyle(
              fontFamily: 'Exo2',
              fontSize: isTablet ? 18 : 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Stay',
                style: TextStyle(
                  fontFamily: 'Exo2',
                  fontSize: isTablet ? 16 : 14,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Go back
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
              ),
              child: Text(
                'Leave',
                style: TextStyle(
                  fontFamily: 'Exo2',
                  fontSize: isTablet ? 16 : 14,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}