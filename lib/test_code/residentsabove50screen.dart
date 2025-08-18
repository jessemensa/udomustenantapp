import 'package:flutter/material.dart';
import 'respiratoryissuesorchildrenu14screen.dart';

import 'hazards/hazardsscreen.dart';
import 'reports/reportscreen.dart';
import 'settings/settings.dart';

class ResidentsAbove50Screen extends StatefulWidget {
  const ResidentsAbove50Screen({super.key});

  @override
  State<ResidentsAbove50Screen> createState() => _ResidentsAbove50ScreenState();
}

class _ResidentsAbove50ScreenState extends State<ResidentsAbove50Screen> {
  String? _selectedOption;
  int? _numberOfResidents;
  final TextEditingController _numberController = TextEditingController();
  int _selectedIndex = 0;
  bool _showNumberInput = false;

  @override
  void dispose() {
    _numberController.dispose();
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
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }

  Widget _buildMainScreen(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;
          final isTablet = width > 600;
          final isDesktop = width > 840;
          final isLandscape = width > height;

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
                            SizedBox(height: isTablet ? 32 : 20),

                            // Main question with icon and better context
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.family_restroom,
                                  size: isTablet ? 32 : 28,
                                  color: const Color(0xFF5B6FFF),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Household Demographics',
                                        style: TextStyle(
                                          fontSize: titleFontSize,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                          fontFamily: 'Exo2',
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Understanding the age range of residents helps us assess health risks associated with damp and mould',
                                        style: TextStyle(
                                          fontSize: bodyFontSize - 2,
                                          fontFamily: 'Exo2',
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: isTablet ? 28 : 20),

                            // Information box explaining why
                            _buildInfoBox(bodyFontSize, isTablet),

                            SizedBox(height: isTablet ? 24 : 16),

                            // Primary dropdown with better wording
                            _buildPrimaryDropdown(bodyFontSize, isTablet),

                            // Show number input if "Yes" is selected
                            if (_showNumberInput) ...[
                              SizedBox(height: isTablet ? 24 : 16),
                              _buildNumberInput(bodyFontSize, isTablet),
                            ],

                            // Context message based on selection
                            if (_selectedOption != null)
                              _buildContextMessage(bodyFontSize, isTablet),
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

  Widget _buildInfoBox(double bodyFontSize, bool isTablet) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 20,
                color: Colors.blue.shade700,
              ),
              const SizedBox(width: 8),
              Text(
                'Why we ask this',
                style: TextStyle(
                  fontSize: bodyFontSize - 2,
                  fontFamily: 'Exo2',
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Adults over 50 may be at higher risk from damp and mould-related health issues. This information helps us prioritize cases and provide appropriate support.',
            style: TextStyle(
              fontSize: bodyFontSize - 3,
              fontFamily: 'Exo2',
              color: Colors.blue.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryDropdown(double bodyFontSize, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Are there any residents aged 50 or above?',
          style: TextStyle(
            fontSize: bodyFontSize - 1,
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
          value: _selectedOption,
          items: [
            'Yes, there are residents aged 50+',
            'No, all residents are under 50',
            'Not sure',
            'Prefer not to say',
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
              _showNumberInput = value?.startsWith('Yes') ?? false;
              if (!_showNumberInput) {
                _numberOfResidents = null;
                _numberController.clear();
              }
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

  Widget _buildNumberInput(double bodyFontSize, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How many residents are aged 50 or above?',
          style: TextStyle(
            fontSize: bodyFontSize - 1,
            fontFamily: 'Exo2',
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            // Quick select buttons
            ...List.generate(4, (index) {
              final number = index + 1;
              final isSelected = _numberOfResidents == number;

              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _numberOfResidents = number;
                      _numberController.text = number.toString();
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: isSelected
                          ? const Color(0xFF5B6FFF)
                          : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                    backgroundColor: isSelected
                        ? const Color(0xFF5B6FFF).withOpacity(0.1)
                        : Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 20 : 16,
                      vertical: isTablet ? 12 : 8,
                    ),
                  ),
                  child: Text(
                    number.toString(),
                    style: TextStyle(
                      fontSize: bodyFontSize - 1,
                      fontFamily: 'Exo2',
                      color: isSelected
                          ? const Color(0xFF5B6FFF)
                          : Colors.black87,
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(width: 8),

            // Custom input for larger numbers
            Expanded(
              child: TextFormField(
                controller: _numberController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontSize: bodyFontSize,
                  fontFamily: 'Exo2',
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  hintText: 'More than 4',
                  hintStyle: TextStyle(
                    fontSize: bodyFontSize - 1,
                    fontFamily: 'Exo2',
                    color: Colors.black54,
                  ),
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
                onChanged: (value) {
                  setState(() {
                    _numberOfResidents = int.tryParse(value);
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContextMessage(double bodyFontSize, bool isTablet) {
    IconData icon;
    Color color;
    String message;

    if (_selectedOption?.startsWith('Yes') ?? false) {
      icon = Icons.priority_high;
      color = Colors.orange;
      message = 'We\'ll prioritize your case as older residents may be more vulnerable to health impacts from damp and mould.';
    } else if (_selectedOption?.startsWith('No') ?? false) {
      icon = Icons.check_circle_outline;
      color = Colors.green;
      message = 'Thank you for the information. We\'ll proceed with standard assessment procedures.';
    } else if (_selectedOption?.contains('Not sure') ?? false) {
      icon = Icons.help_outline;
      color = Colors.blue;
      message = 'That\'s okay. We\'ll gather more information during our assessment if needed.';
    } else {
      icon = Icons.privacy_tip_outlined;
      color = Colors.grey;
      message = 'Your privacy is respected. We\'ll proceed with our standard assessment process.';
    }

    return Container(
      margin: EdgeInsets.only(top: isTablet ? 24 : 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        // color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.blue,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: bodyFontSize - 2,
                fontFamily: 'Exo2',
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context, double buttonHeight,
      double bodyFontSize, bool isTablet) {
    final isValid = _selectedOption != null &&
        (!_showNumberInput || _numberOfResidents != null);

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
                      // Prepare data
                      final demographicData = {
                        'hasResidents50Plus': _selectedOption,
                        if (_numberOfResidents != null)
                          'numberOfResidents50Plus': _numberOfResidents,
                      };

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const VulnerableResidentsScreen(),
                        ),
                      );

                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text('Demographic data saved'),
                      //     duration: const Duration(seconds: 2),
                      //   ),
                      // );

                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         const RespiratoryIssuesorChildrenU14Screen(),
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

  Widget _buildPlaceholderScreen(String title, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontFamily: 'Exo2',
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Coming Soon',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Exo2',
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
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