import 'package:flutter/material.dart';
import 'ventilationissuescreen.dart';

import 'hazards/hazardsscreen.dart';
import 'reports/reportscreen.dart';
import 'settings/settings.dart';

class WaterLeaksDescribeProblemScreen extends StatefulWidget {
  const WaterLeaksDescribeProblemScreen({super.key});

  @override
  State<WaterLeaksDescribeProblemScreen> createState() => _WaterLeaksDescribeProblemScreenState();
}

class _WaterLeaksDescribeProblemScreenState extends State<WaterLeaksDescribeProblemScreen> {
  final TextEditingController _controller = TextEditingController();
  int _selectedIndex = 0; // Home tab by default

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {})); // re-render to enable/disable Next
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isValid => _controller.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildMainScreen(context), // Home content
          HazardsScreen(),
          ReportScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildMainScreen(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isTablet = constraints.maxWidth >= 600;

          // Phone vs Tablet sizing only
          final double horizontalPadding = isTablet ? 32 : 20;
          final double maxContentWidth   = isTablet ? 540 : double.infinity; // comfy width on tablets
          final double titleFontSize     = isTablet ? 22 : 19;
          final double bodyFontSize      = isTablet ? 17 : 16;
          final double buttonHeight      = isTablet ? 56 : 48;

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxContentWidth),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(context, isTablet),

                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: isTablet ? 28 : 20),

                            // Title with icon pill
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
                                    Icons.description_outlined,
                                    size: isTablet ? 32 : 38,
                                    color: const Color(0xFF5B6FFF),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Tell us more about the water leaks in your home',
                                    style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Exo2',
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: isTablet ? 24 : 16),

                            // Info box
                            _buildInfoBox(bodyFontSize),

                            SizedBox(height: isTablet ? 24 : 16),

                            // Description field
                            _buildDescriptionField(bodyFontSize, isTablet),
                          ],
                        ),
                      ),
                    ),

                    // Bottom section with full-width Next button
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

  Widget _buildDescriptionField(double bodyFontSize, bool isTablet) {
    final int minLinesValue = isTablet ? 5 : 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Please provide details (e.g., where the leak is, when it happens, any smells, staining, or dripping):',
          style: TextStyle(
            fontSize: bodyFontSize - 1,
            fontFamily: 'Exo2',
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _controller,
          minLines: minLinesValue,
          maxLines: null,
          textAlignVertical: TextAlignVertical.top,
          keyboardType: TextInputType.multiline,
          style: TextStyle(fontSize: bodyFontSize, fontFamily: 'Exo2'),
          decoration: InputDecoration(
            hintText: 'Type here',
            hintStyle: TextStyle(fontFamily: 'Exo2', fontSize: bodyFontSize - 1, color: Colors.black54),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: isTablet ? 16 : 12),
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
        ),
      ],
    );
  }

  Widget _buildInfoBox(double bodyFontSize) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 20, color: Colors.amber.shade700),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Your description helps us triage the issue quickly and plan the right repair. Mention any damage, smells, staining, or if the leak is continuous/intermittent.',
              style: TextStyle(
                fontSize: bodyFontSize - 2,
                fontFamily: 'Exo2',
                color: Colors.amber.shade700,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context, double buttonHeight, double bodyFontSize, bool isTablet) {
    return Column(
      children: [
        const Divider(height: 1),
        Padding(
          padding: EdgeInsets.symmetric(vertical: isTablet ? 20 : 16),
          child: SizedBox(
            width: double.infinity,
            height: buttonHeight,
            child: ElevatedButton.icon(
              onPressed: _isValid
                  ? () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const VentilationIssueScreen()),
                );
              }
                  : null,
             // icon: const Icon(Icons.arrow_forward),
              label: Text(
                'Next',
                style: TextStyle(
                  fontSize: bodyFontSize,
                  fontFamily: 'Exo2',
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey.shade300,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: _isValid ? 2 : 0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, bool isTablet) {
    return Padding(
      padding: EdgeInsets.only(top: isTablet ? 24 : 16, bottom: isTablet ? 16 : 8),
      child: Row(
        children: [
          // Back button
          IconButton(
            onPressed: () => _showBackDialog(context),
            icon: Icon(Icons.arrow_back, color: Colors.black87, size: isTablet ? 26 : 24),
            style: IconButton.styleFrom(
              backgroundColor: Colors.grey.shade100,
              padding: EdgeInsets.all(isTablet ? 12 : 8),
            ),
          ),
          const Spacer(),
          // Skip at far right
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const VentilationIssueScreen()),
              );
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: isTablet ? 16 : 12, vertical: 8),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Skip',
              style: TextStyle(
                fontFamily: 'Exo2',
                fontSize: isTablet ? 16 : 14,
                color: const Color(0xFF5B6FFF),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;

    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFF5B6FFF),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedLabelStyle: TextStyle(fontFamily: 'Exo2', fontSize: isTablet ? 14 : 12),
      unselectedLabelStyle: TextStyle(fontFamily: 'Exo2', fontSize: isTablet ? 14 : 12),
      onTap: (i) => setState(() => _selectedIndex = i),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.report_outlined), activeIcon: Icon(Icons.report), label: 'Hazard'),
        BottomNavigationBarItem(icon: Icon(Icons.summarize_outlined), activeIcon: Icon(Icons.summarize), label: 'Report'),
        BottomNavigationBarItem(icon: Icon(Icons.settings_rounded), activeIcon: Icon(Icons.settings_rounded), label: 'Settings'),
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
  //         Text(title, style: const TextStyle(fontSize: 24, fontFamily: 'Exo2', color: Colors.grey)),
  //         const SizedBox(height: 8),
  //         const Text('Coming Soon', style: TextStyle(fontSize: 16, fontFamily: 'Exo2', color: Colors.grey)),
  //       ],
  //     ),
  //   );
  // }

  void _showBackDialog(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Leave Form?', style: TextStyle(fontFamily: 'Exo2', fontSize: isTablet ? 22 : 20)),
        content: Text('Your progress will be lost if you go back.', style: TextStyle(fontFamily: 'Exo2', fontSize: isTablet ? 17 : 16)),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: Text('Stay', style: TextStyle(fontFamily: 'Exo2'))),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // Close dialog
              Navigator.of(context).pop(); // Go back
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade600, foregroundColor: Colors.white),
            child: const Text('Leave', style: TextStyle(fontFamily: 'Exo2')),
          ),
        ],
      ),
    );
  }
}