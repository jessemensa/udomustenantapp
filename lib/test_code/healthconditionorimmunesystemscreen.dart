import 'package:flutter/material.dart';
import 'mentalhealthscreen.dart';

import 'hazards/hazardsscreen.dart';
import 'reports/reportscreen.dart';
import 'settings/settings.dart';

class HealthConditionOrImmuneSystemScreen extends StatefulWidget {
  const HealthConditionOrImmuneSystemScreen({super.key});

  @override
  State<HealthConditionOrImmuneSystemScreen> createState() => _HealthConditionOrImmuneSystemScreenState();
}

class _HealthConditionOrImmuneSystemScreenState extends State<HealthConditionOrImmuneSystemScreen> {
  String? _disabilityStatus;
  int? _numberOfResidentsWithHealthConditionOrImmunesystemIssues;
  final TextEditingController _numberController = TextEditingController();
  int _selectedIndex = 0;
  bool _showAdditionalInfo = false;

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
          icon: Icon(Icons.settings_rounded),
          activeIcon: Icon(Icons.settings_rounded),
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
                            SizedBox(height: isTablet ? 32 : 20),

                            // Main title with icon
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.pink.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.health_and_safety_rounded,
                                    size: isTablet ? 32 : 28,
                                    color: Colors.pink.shade400,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Health Information',
                                        style: TextStyle(
                                          fontSize: titleFontSize,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                          fontFamily: 'Exo2',
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'This helps us provide appropriate support and prioritize health-sensitive cases',
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

                            // Privacy notice
                            _buildPrivacyNotice(bodyFontSize, isTablet),

                            SizedBox(height: isTablet ? 24 : 16),

                            // Information box
                            _buildInfoBox(bodyFontSize, isTablet),

                            SizedBox(height: isTablet ? 24 : 16),

                            // Primary dropdown
                            _buildPrimaryDropdown(bodyFontSize, isTablet),

                            // Show additional fields if "Yes" is selected
                            if (_showAdditionalInfo) ...[
                              SizedBox(height: isTablet ? 24 : 16),
                              _buildNumberInput(bodyFontSize, isTablet),

                              SizedBox(height: isTablet ? 24 : 16),
                              // _buildTrimesterDropdown(bodyFontSize, isTablet),
                            ],

                            // Context message
                            if (_disabilityStatus != null)
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

  Widget _buildPrivacyNotice(double bodyFontSize, bool isTablet) {
    return Container(
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
            Icons.lock_outline,
            size: 20,
            color: Colors.blue.shade700,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Your medical information is strictly confidential and protected under data protection laws. It will only be used to ensure appropriate health and safety measures.',
              style: TextStyle(
                fontSize: bodyFontSize - 3,
                fontFamily: 'Exo2',
                color: Colors.blue.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox(double bodyFontSize, bool isTablet) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 20,
                color: Colors.amber.shade700,
              ),
              const SizedBox(width: 8),
              Text(
                'Why we ask',
                style: TextStyle(
                  fontSize: bodyFontSize - 2,
                  fontFamily: 'Exo2',
                  fontWeight: FontWeight.w600,
                  color: Colors.amber.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Residents with a pre-existing health condition may be at higher risk from damp and mould exposure. This information helps us:\n'
                '• Prioritize urgent cases\n'
                '• Ensure safe working practices during repairs\n'
                '• Provide appropriate health guidance',
            style: TextStyle(
              fontSize: bodyFontSize - 3,
              fontFamily: 'Exo2',
              color: Colors.amber.shade700,
              height: 1.4,
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
          'Any resident with a pre-existing health condition or issues with immune system?',
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
          value: _disabilityStatus,
          items: [
            'Yes',
            'No',
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
              _disabilityStatus = value;
              _showAdditionalInfo = value == 'Yes';
              if (!_showAdditionalInfo) {
                _numberOfResidentsWithHealthConditionOrImmunesystemIssues = null;
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
          'Number of residents with disability',
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
            // Quick select buttons for 1-2
            ...List.generate(2, (index) {
              final number = index + 1;
              final isSelected = _numberOfResidentsWithHealthConditionOrImmunesystemIssues == number;

              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _numberOfResidentsWithHealthConditionOrImmunesystemIssues = number;
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
                        ? const Color(0xFF5B6FFF).withValues(alpha: 0.1)
                        : Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 24 : 20,
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

            // Custom input for more
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
                  hintText: 'Enter number',
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
                    _numberOfResidentsWithHealthConditionOrImmunesystemIssues = int.tryParse(value);
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
    // Color color;
    String message;

    if (_disabilityStatus == 'Yes') {
      icon = Icons.priority_high;
      // color = Colors.red;
      message = 'Your case will be given high priority. We\'ll ensure all work is carried out safely with appropriate precautions for pregnant residents.';
    } else if (_disabilityStatus == 'No') {
      icon = Icons.check_circle_outline;
      // color = Colors.green;
      message = 'Thank you for the information. We\'ll proceed with standard assessment procedures.';
    } else {
      icon = Icons.privacy_tip_outlined;
      // color = Colors.grey;
      message = 'Your privacy is respected. We\'ll proceed with our standard safety protocols.';
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
    final isValid = _disabilityStatus != null &&
        (!_showAdditionalInfo || _numberOfResidentsWithHealthConditionOrImmunesystemIssues != null);

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
                      // final pregnancyData = {
                      //   'pregnancyStatus': _disabilityStatus,
                      //   if (_numberOfResidentsWithHealthConditionOrImmunesystemIssues != null)
                      //     'numberOfPregnantResidents': _numberOfResidentsWithHealthConditionOrImmunesystemIssues,
                      // };

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MentalHealthScreen(),
                        ),
                      );

                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text('Information saved securely'),
                      //     duration: const Duration(seconds: 2),
                      //   ),
                      // );

                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         const DisabilityOrBedBoundScreen(),
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