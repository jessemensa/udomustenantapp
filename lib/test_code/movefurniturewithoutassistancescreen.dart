import 'package:flutter/material.dart';
// import 'residentsabove50screen.dart';

class MoveFurnitureWithoutAssistanceScreen extends StatefulWidget {
  const MoveFurnitureWithoutAssistanceScreen({super.key});

  @override
  State<MoveFurnitureWithoutAssistanceScreen> createState() =>
      _MoveFurnitureWithoutAssistanceScreenState();
}

class _MoveFurnitureWithoutAssistanceScreenState
    extends State<MoveFurnitureWithoutAssistanceScreen> {
  String? _mobilityLevel;
  List<String> _assistanceNeeded = [];
  String? _additionalSupport;
  int _selectedIndex = 0;
  bool _showAssistanceOptions = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildMainScreen(context),
          _buildPlaceholderScreen('Hazard', Icons.report),
          _buildPlaceholderScreen('Report', Icons.summarize),
          _buildPlaceholderScreen('Chat', Icons.chat_bubble),
          _buildPlaceholderScreen('Profile', Icons.person),
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

                            // Main question with icon
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.accessible_forward,
                                  size: isTablet ? 32 : 28,
                                  color: const Color(0xFF5B6FFF),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Mobility and Assistance Needs',
                                        style: TextStyle(
                                          fontSize: titleFontSize,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                          fontFamily: 'Exo2',
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'This helps us understand if you need support during property inspections or repairs',
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
                            _buildPrivacyNotice(bodyFontSize),

                            SizedBox(height: isTablet ? 24 : 16),

                            // Primary dropdown
                            _buildMobilityDropdown(bodyFontSize, isTablet),

                            // Show assistance options if needed
                            if (_showAssistanceOptions) ...[
                              SizedBox(height: isTablet ? 24 : 16),
                              _buildAssistanceOptions(bodyFontSize, isTablet),

                              SizedBox(height: isTablet ? 24 : 16),
                              _buildAdditionalSupportField(bodyFontSize, isTablet),
                            ],

                            // Information box
                            if (_mobilityLevel != null)
                              _buildInfoBox(bodyFontSize, isTablet),
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

  Widget _buildPrivacyNotice(double bodyFontSize) {
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
              'Your information is confidential and will only be used to provide appropriate support during our visit.',
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

  Widget _buildMobilityDropdown(double bodyFontSize, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Can you move furniture without assistance?',
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
          value: _mobilityLevel,
          items: [
            'Yes, without any assistance',
            'Yes, but only light furniture',
            'Sometimes, depending on the furniture',
            'No, I need assistance',
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
              _mobilityLevel = value;
              _showAssistanceOptions = value != null &&
                  (value.contains('No') || value.contains('Sometimes') ||
                      value.contains('light'));
              if (!_showAssistanceOptions) {
                _assistanceNeeded.clear();
                _additionalSupport = null;
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

  Widget _buildAssistanceOptions(double bodyFontSize, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What assistance would be helpful? (Select all that apply)',
          style: TextStyle(
            fontSize: bodyFontSize - 1,
            fontFamily: 'Exo2',
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildCheckboxTile(
                'Help moving furniture during inspection',
                'furniture',
                bodyFontSize,
              ),
              Divider(height: 1, color: Colors.grey.shade300),
              _buildCheckboxTile(
                'Extra time for property access',
                'time',
                bodyFontSize,
              ),
              Divider(height: 1, color: Colors.grey.shade300),
              _buildCheckboxTile(
                'Ground floor access only',
                'ground',
                bodyFontSize,
              ),
              Divider(height: 1, color: Colors.grey.shade300),
              _buildCheckboxTile(
                'Support person present during visit',
                'support',
                bodyFontSize,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCheckboxTile(String title, String value, double fontSize) {
    final isSelected = _assistanceNeeded.contains(value);

    return ListTile(
      onTap: () {
        setState(() {
          if (isSelected) {
            _assistanceNeeded.remove(value);
          } else {
            _assistanceNeeded.add(value);
          }
        });
      },
      leading: Checkbox(
        value: isSelected,
        onChanged: (bool? newValue) {
          setState(() {
            if (newValue == true) {
              _assistanceNeeded.add(value);
            } else {
              _assistanceNeeded.remove(value);
            }
          });
        },
        activeColor: const Color(0xFF5B6FFF),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: fontSize - 1,
          fontFamily: 'Exo2',
          color: Colors.black87,
        ),
      ),
      tileColor: isSelected ? const Color(0xFF5B6FFF).withOpacity(0.05) : null,
    );
  }

  Widget _buildAdditionalSupportField(double bodyFontSize, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Any other support needs? (Optional)',
          style: TextStyle(
            fontSize: bodyFontSize - 1,
            fontFamily: 'Exo2',
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          maxLines: 3,
          style: TextStyle(
            fontSize: bodyFontSize,
            fontFamily: 'Exo2',
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            hintText: 'Please describe any additional support you may need...',
            hintStyle: TextStyle(
              fontSize: bodyFontSize - 1,
              fontFamily: 'Exo2',
              color: Colors.black54,
            ),
            contentPadding: EdgeInsets.all(isTablet ? 16 : 12),
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
              _additionalSupport = value.isEmpty ? null : value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildInfoBox(double bodyFontSize, bool isTablet) {
    IconData icon;
    Color color;
    String message;

    if (_mobilityLevel?.contains('No') ?? false) {
      icon = Icons.support;
      color = Colors.green;
      message = 'We\'ll ensure appropriate support is available during our visit. Your safety and comfort are our priority.';
    } else if (_mobilityLevel?.contains('Sometimes') ?? false ||
        _mobilityLevel!.contains('light') ?? false) {
      icon = Icons.info_outline;
      color = Colors.blue;
      message = 'We\'ll make note of your needs and provide assistance as required during the inspection.';
    } else if (_mobilityLevel?.contains('Prefer not') ?? false) {
      icon = Icons.privacy_tip_outlined;
      color = Colors.grey;
      message = 'Your privacy is respected. We\'ll proceed with standard procedures during our visit.';
    } else {
      icon = Icons.check_circle_outline;
      color = Colors.green;
      message = 'Thank you for letting us know. This helps us plan our visit efficiently.';
    }

    return Container(
      margin: EdgeInsets.only(top: isTablet ? 24 : 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        //color: Colors.blue,
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
    final isValid = _mobilityLevel != null;

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
                      final assistanceData = {
                        'mobilityLevel': _mobilityLevel,
                        'assistanceNeeded': _assistanceNeeded,
                        'additionalSupport': _additionalSupport,
                      };

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Assistance data saved'),
                          duration: const Duration(seconds: 2),
                        ),
                      );

                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => const ResidentsAbove50Screen(),
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
                    icon: const Icon(Icons.arrow_forward),
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