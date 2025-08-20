import 'package:flutter/material.dart';
import 'package:udomustenantapp/test_code/previousdampandmouldscreen.dart';
// import 'package:flutter/services.dart';
// import 'previousdampandmouldscreen.dart';
import 'hazards/hazardsscreen.dart';
import 'reports/reportscreen.dart';
import 'settings/settings.dart';

class NumberOfTenantsScreen extends StatefulWidget {
  const NumberOfTenantsScreen({super.key});

  @override
  State<NumberOfTenantsScreen> createState() => _NumberOfTenantsScreenState();
}

class _NumberOfTenantsScreenState extends State<NumberOfTenantsScreen> {
  String? _selectedOption;
  int? _customNumber;
  final TextEditingController _customController = TextEditingController();
  int _selectedIndex = 0;
  bool _useCustomInput = false;

  @override
  void dispose() {
    _customController.dispose();
    super.dispose();
  }

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
              ? 28
              : (isTablet ? 24 : 20);
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
                    // Custom Header with back button
                    _buildHeader(context, isTablet, isDesktop),

                    // Main content
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: isTablet ? 40 : 24),

                            // Question title
                            Row(
                              children: [
                                Icon(
                                  Icons.phone_in_talk, // or whatever icon you prefer
                                  size: isTablet ? 24 : 28,
                                  color: const Color(0xFF5B6FFF),
                                ),
                                SizedBox(width: isTablet ? 20 : 10),
                                Expanded(
                                 child: Text(
                                   'How many tenants live in the property?',
                                   style: TextStyle(
                                     fontSize: titleFontSize,
                                     fontFamily: 'Exo2',
                                     fontWeight: FontWeight.w600,
                                     color: Colors.black87,
                                   ),
                                 ),
                                ),
                              ],
                            ),
                            // Text(
                            //   'How many tenants live in the property?',
                            //   style: TextStyle(
                            //     fontSize: titleFontSize,
                            //     fontFamily: 'Exo2',
                            //     fontWeight: FontWeight.w600,
                            //     color: Colors.black87,
                            //   ),
                            // ),

                            SizedBox(height: isTablet ? 12 : 8),

                            // Helper text
                            Text(
                              'This helps us understand the scale of the issue',
                              style: TextStyle(
                                fontSize: bodyFontSize - 2,
                                fontFamily: 'Exo2',
                                color: Colors.black54,
                              ),
                            ),

                            SizedBox(height: isTablet ? 32 : 24),

                            // Selection method toggle
                            _buildSelectionMethodToggle(bodyFontSize, isTablet),

                            SizedBox(height: isTablet ? 24 : 16),

                            // Input field based on selection method
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: _buildDropdownSelection(bodyFontSize, isTablet),
                            ),

                            // Validation message
                            if (!_isValidSelection())
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  'Please select or enter the number of tenants',
                                  style: TextStyle(
                                    fontSize: bodyFontSize - 3,
                                    fontFamily: 'Exo2',
                                    color: Colors.orange.shade700,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),

                    // Bottom section with Next button
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

  Widget _buildSelectionMethodToggle(double bodyFontSize, bool isTablet) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _useCustomInput = false),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: isTablet ? 12 : 10,
                ),
                decoration: BoxDecoration(
                  color: !_useCustomInput ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: !_useCustomInput
                      ? [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                      : null,
                ),
                child: Text(
                  'Select Range',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: bodyFontSize - 1,
                    fontFamily: 'Exo2',
                    fontWeight: !_useCustomInput ? FontWeight.w600 : FontWeight.normal,
                    color: !_useCustomInput ? Colors.black87 : Colors.black54,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownSelection(double bodyFontSize, bool isTablet) {
    return Column(
      key: const ValueKey('dropdown'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
            'Please Select',
            style: TextStyle(
              fontFamily: 'Exo2',
              fontSize: bodyFontSize,
              color: Colors.black54,
            ),
          ),
          value: _selectedOption,
          items: [
            '1 tenant',
            '2 tenants',
            '3 tenants',
            '4-6 tenants',
            '7-10 tenants',
            'More than 10 tenants',
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
              _selectedOption = value;
              _customNumber = null;
              _customController.clear();
            });
          },
          icon: Icon(
            Icons.arrow_drop_down_rounded,
            size: isTablet ? 32 : 28,
            color: Colors.black54,
          ),
        ),

        // Information box
        Container(
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline,
                size: 20,
                color: Colors.blue.shade700,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Include all residents, including children',
                  style: TextStyle(
                    fontSize: bodyFontSize - 2,
                    fontFamily: 'Exo2',
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
            ],
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
              // Previous button (optional)
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
                              builder: (context) => const PreviousDampMouldScreen()
                          )
                      );

                      // Navigate to next screen
                      // final tenantCount = _useCustomInput
                      //     ? _customNumber.toString()
                      //     : _selectedOption;
                      //
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text('Selected: $tenantCount'),
                      //     duration: const Duration(seconds: 2),
                      //   ),
                      // );

                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => const PreviousDampMouldScreen(),
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
    return _selectedOption != null || (_customNumber != null && _customNumber! > 0);
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
