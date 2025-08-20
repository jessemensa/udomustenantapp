import 'package:flutter/material.dart';
import 'residentswithpregnancyscreen.dart';

import 'hazards/hazardsscreen.dart';
import 'reports/reportscreen.dart';
import 'settings/settings.dart';

/*
  TODO: Add a text for users that choose NO
  ie. Thank you for information, we will proceed with the standard assessment procedures
* */

// Renamed to better reflect the purpose
class VulnerableResidentsScreen extends StatefulWidget {
  const VulnerableResidentsScreen({super.key});

  @override
  State<VulnerableResidentsScreen> createState() => _VulnerableResidentsScreenState();
}

class _VulnerableResidentsScreenState extends State<VulnerableResidentsScreen> {
  // Separate tracking for different vulnerable groups
  bool? _hasChildrenUnder14;
  int? _numberOfChildren;
  // bool? _hasRespiratoryConditions;
  // int? _numberOfRespiratoryResidents;
  // List<String> _respiratoryConditions = [];

  final TextEditingController _childrenController = TextEditingController();
  final TextEditingController _respiratoryController = TextEditingController();

  int _selectedIndex = 0;

  @override
  void dispose() {
    _childrenController.dispose();
    _respiratoryController.dispose();
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
         // final height = constraints.maxHeight;
          final isTablet = width > 600;
          final isDesktop = width > 840;
         // final isLandscape = width > height;

          // Adaptive sizing
          final double horizontalPadding = isDesktop
              ? 48
              : (isTablet ? 32 : 20);
          final double maxContentWidth = isDesktop
              ? 700
              : (isTablet ? 600 : double.infinity);
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
                                    color: const Color(0xFF5B6FFF).withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.health_and_safety,
                                    size: isTablet ? 32 : 28,
                                    color: const Color(0xFF5B6FFF),
                                  ),
                                ),
                                // Icon(
                                //   Icons.health_and_safety,
                                //   size: isTablet ? 32 : 28,
                                //   color: const Color(0xFF5B6FFF),
                                // ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Vulnerable Residents Assessment',
                                        style: TextStyle(
                                          fontSize: titleFontSize,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                          fontFamily: 'Exo2',
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'This information helps us prioritize urgent cases and provide appropriate support',
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

                            // Information box
                            _buildInfoBox(bodyFontSize, isTablet),

                            SizedBox(height: isTablet ? 24 : 16),

                            // Children section
                            _buildChildrenSection(bodyFontSize, isTablet),

                            SizedBox(height: isTablet ? 24 : 16),

                            // // Respiratory conditions section
                            // _buildRespiratorySection(bodyFontSize, isTablet),

                            // Context message
                            if (_hasChildrenUnder14 != null
                                // || _hasRespiratoryConditions != null
                            )
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
                Icons.warning_amber,
                size: 20,
                color: Colors.amber.shade700,
              ),
              const SizedBox(width: 8),
              Text(
                'Why this matters',
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
            'Children and people with respiratory conditions are at higher risk from damp and mould exposure. This includes conditions like asthma, COPD, or weakened immune systems.',
            style: TextStyle(
              fontSize: bodyFontSize - 3,
              fontFamily: 'Exo2',
              color: Colors.amber.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChildrenSection(double bodyFontSize, bool isTablet) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.child_care,
                size: 24,
                color: const Color(0xFF5B6FFF),
              ),
              const SizedBox(width: 8),
              Text(
                'Children Under 14 or Respiratory Issues',
                style: TextStyle(
                  fontSize: bodyFontSize,
                  fontFamily: 'Exo2',
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Yes/No selection
          Row(
            children: [
              Expanded(
                child: RadioListTile<bool>(
                  title: Text(
                    'Yes',
                    style: TextStyle(
                      fontSize: bodyFontSize - 1,
                      fontFamily: 'Exo2',
                    ),
                  ),
                  value: true,
                  groupValue: _hasChildrenUnder14,
                  onChanged: (value) {
                    setState(() {
                      _hasChildrenUnder14 = value;
                      if (value != true) {
                        _numberOfChildren = null;
                        _childrenController.clear();
                      }
                    });
                  },
                  activeColor: const Color(0xFF5B6FFF),
                ),
              ),
              Expanded(
                child: RadioListTile<bool>(
                  title: Text(
                    'No',
                    style: TextStyle(
                      fontSize: bodyFontSize - 1,
                      fontFamily: 'Exo2',
                    ),
                  ),
                  value: false,
                  groupValue: _hasChildrenUnder14,
                  onChanged: (value) {
                    setState(() {
                      _hasChildrenUnder14 = value;
                      _numberOfChildren = null;
                      _childrenController.clear();
                    });
                  },
                  activeColor: const Color(0xFF5B6FFF),
                ),
              ),
            ],
          ),

          // Number input if Yes
          if (_hasChildrenUnder14 == true) ...[
            const SizedBox(height: 12),
            Text(
              'How many children under 14?',
              style: TextStyle(
                fontSize: bodyFontSize - 2,
                fontFamily: 'Exo2',
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ...List.generate(3, (index) {
                  final number = index + 1;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _numberOfChildren = number;
                          _childrenController.text = number.toString();
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: _numberOfChildren == number
                              ? const Color(0xFF5B6FFF)
                              : Colors.grey.shade300,
                          width: _numberOfChildren == number ? 2 : 1,
                        ),
                        backgroundColor: _numberOfChildren == number
                            ? const Color(0xFF5B6FFF).withValues(alpha: 0.1)
                            : Colors.white,
                      ),
                      child: Text(number.toString()),
                    ),
                  );
                }),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _childrenController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'More',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _numberOfChildren = int.tryParse(value);
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }


  Widget _buildContextMessage(double bodyFontSize, bool isTablet) {
    final hasVulnerable = (_hasChildrenUnder14 == true);
        // || (_hasRespiratoryConditions == true);

    if (!hasVulnerable && _hasChildrenUnder14 != null
        // && _hasRespiratoryConditions != null
    ) {
      return Container(
        margin: EdgeInsets.only(top: isTablet ? 24 : 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.green.shade200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 20,
              color: Colors.green.shade700,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Thank you. We\'ll proceed with standard assessment procedures.',
                style: TextStyle(
                  fontSize: bodyFontSize - 2,
                  fontFamily: 'Exo2',
                  color: Colors.green.shade700,
                ),
              ),
            ),
          ],
        ),
      );
    } else if (hasVulnerable) {
      return Container(
        margin: EdgeInsets.only(top: isTablet ? 24 : 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.red.shade200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.priority_high,
              size: 20,
              color: Colors.red.shade700,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Your case will be prioritized due to vulnerable residents. We\'ll ensure swift action to address the damp and mould issues.',
                style: TextStyle(
                  fontSize: bodyFontSize - 2,
                  fontFamily: 'Exo2',
                  color: Colors.red.shade700,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildBottomSection(BuildContext context, double buttonHeight,
      double bodyFontSize, bool isTablet) {
    final isValid = _hasChildrenUnder14 != null;
        //  && _hasRespiratoryConditions != null;

    return Column(
      children: [
        const Divider(height: 1),

        Padding(
          padding: EdgeInsets.symmetric(vertical: isTablet ? 20 : 16),
          child: Row(
            children: [
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
                      // final vulnerableData = {
                      //   'hasChildrenUnder14': _hasChildrenUnder14,
                      //   if (_numberOfChildren != null)
                      //     'numberOfChildren': _numberOfChildren,
                      //   'hasRespiratoryConditions': _hasRespiratoryConditions,
                      //
                      //   // if (_respiratoryConditions.isNotEmpty)
                      //   //   'conditions': _respiratoryConditions,
                      // };

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const PregnancyInformationScreen(),
                        ),
                      );


                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text('Vulnerable residents data saved'),
                      //     duration: const Duration(seconds: 2),
                      //   ),
                      // );

                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         const ResidentsWithPregnancyScreen(),
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