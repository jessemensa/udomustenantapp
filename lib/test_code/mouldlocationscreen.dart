import 'package:flutter/material.dart';
// import 'arealargerthandoorscreen.dart';
//
// class MouldLocationScreen extends StatefulWidget {
//   const MouldLocationScreen({super.key});
//
//   @override
//   State<MouldLocationScreen> createState() => _MouldLocationScreenState();
// }
//
// class _MouldLocationScreenState extends State<MouldLocationScreen> {
//   final List<String> _allOptions = [
//     'Bedroom',
//     'Bathroom',
//     'Living Room/Lounge',
//     'Hallway/Landing',
//     'All Habitable Rooms',
//     'Kitchen',
//   ];
//
//   List<String> _selected = [];
//   int _selectedIndex = 1; // Set to 1 since this appears to be the "Hazard" screen
//   bool _isNavigating = false;
//
//   void _openMultiSelectDialog(double optionFontSize) async {
//     final List<String>? results = await showDialog<List<String>>(
//       context: context,
//       builder: (ctx) {
//         final tempSelected = List<String>.from(_selected);
//         return AlertDialog(
//           title: const Text(
//             'Select locations',
//             style: TextStyle(fontFamily: 'Exo2'),
//           ),
//           content: StatefulBuilder(
//             builder: (context, setStateDialog) {
//               return SizedBox(
//                 width: double.maxFinite,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Flexible(
//                       child: ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: _allOptions.length,
//                         itemBuilder: (context, index) {
//                           final option = _allOptions[index];
//                           return Semantics(
//                             label: 'Select $option',
//                             child: CheckboxListTile(
//                               title: Text(
//                                 option,
//                                 style: TextStyle(
//                                   fontSize: optionFontSize,
//                                   fontFamily: 'Exo2',
//                                 ),
//                               ),
//                               value: tempSelected.contains(option),
//                               activeColor: Colors.deepPurple,
//                               checkColor: Colors.white,
//                               onChanged: (bool? checked) {
//                                 setStateDialog(() {
//                                   if (checked == true) {
//                                     tempSelected.add(option);
//                                   } else {
//                                     tempSelected.remove(option);
//                                   }
//                                 });
//                               },
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(ctx, null),
//               child: const Text(
//                 'CANCEL',
//                 style: TextStyle(fontFamily: 'Exo2'),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () => Navigator.pop(ctx, tempSelected),
//               child: const Text(
//                 'OK',
//                 style: TextStyle(fontFamily: 'Exo2'),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//
//     if (results != null) {
//       setState(() => _selected = results);
//     }
//   }
//
//   void _navigateToTab(int index) {
//     if (_isNavigating) return;
//
//     setState(() {
//       _selectedIndex = index;
//       _isNavigating = true;
//     });
//
//     // Add navigation logic based on tab index
//     switch (index) {
//       case 0:
//       // Navigate to Home
//         Navigator.of(context).pushReplacementNamed('/home');
//         break;
//       case 1:
//       // Current screen (Hazard) - do nothing
//         break;
//       case 2:
//       // Navigate to Report
//         Navigator.of(context).pushNamed('/report');
//         break;
//       case 3:
//       // Navigate to Chat
//         Navigator.of(context).pushNamed('/chat');
//         break;
//       case 4:
//       // Navigate to Profile
//         Navigator.of(context).pushNamed('/profile');
//         break;
//     }
//
//     // Reset navigation flag after a short delay
//     Future.delayed(const Duration(milliseconds: 500), () {
//       if (mounted) {
//         setState(() => _isNavigating = false);
//       }
//     });
//   }
//
//   void _navigateToNext() async {
//     if (_isNavigating) return;
//
//     setState(() => _isNavigating = true);
//
//     try {
//       await Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => const AreaLargerThanDoorScreen(),
//         ),
//       );
//     } catch (e) {
//       // Handle navigation error
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Navigation failed: ${e.toString()}'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() => _isNavigating = false);
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.deepPurple),
//           onPressed: () => Navigator.of(context).maybePop(),
//         ),
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           // Enhanced responsive breakpoints
//           final bool isSmallPhone = constraints.maxWidth < 360;
//           final bool isTablet = constraints.maxWidth > 600;
//           final bool isLargeTablet = constraints.maxWidth > 900;
//
//           // Dynamic sizing based on screen size
//           final double hPad = isLargeTablet
//               ? 128
//               : isTablet
//               ? 64
//               : isSmallPhone
//               ? 12
//               : 16;
//
//           final double vGap = isLargeTablet
//               ? 40
//               : isTablet
//               ? 32
//               : isSmallPhone
//               ? 12
//               : 16;
//
//           final double titleSize = isLargeTablet
//               ? 28
//               : isTablet
//               ? 24
//               : isSmallPhone
//               ? 16
//               : 18;
//
//           final double optionSize = isLargeTablet
//               ? 22
//               : isTablet
//               ? 20
//               : isSmallPhone
//               ? 14
//               : 16;
//
//           final double maxWidth = isLargeTablet ? 600 : 500;
//
//           return SafeArea(
//             child: Center(
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(maxWidth: maxWidth),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: hPad),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       SizedBox(height: vGap),
//
//                       // Title
//                       Semantics(
//                         header: true,
//                         child: Text(
//                           'Mould Location in the property?',
//                           style: TextStyle(
//                             fontSize: titleSize,
//                             fontWeight: FontWeight.w600,
//                             fontFamily: 'Exo2',
//                             color: Colors.black87,
//                           ),
//                         ),
//                       ),
//
//                       SizedBox(height: vGap),
//
//                       // Multi-select dropdown
//                       Semantics(
//                         label: 'Select mould locations. Tap to open selection dialog.',
//                         button: true,
//                         child: GestureDetector(
//                           onTap: () => _openMultiSelectDialog(optionSize),
//                           child: InputDecorator(
//                             decoration: InputDecoration(
//                               hintText: 'Please Select',
//                               hintStyle: TextStyle(
//                                 fontFamily: 'Exo2',
//                                 fontSize: optionSize,
//                               ),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 12,
//                                 vertical: 8,
//                               ),
//                               suffixIcon: const Icon(Icons.arrow_drop_down),
//                             ),
//                             isEmpty: _selected.isEmpty,
//                             child: _selected.isEmpty
//                                 ? null
//                                 : Wrap(
//                               spacing: 6,
//                               runSpacing: 6,
//                               children: _selected
//                                   .map((loc) => Semantics(
//                                 label: 'Selected location: $loc. Double tap to remove.',
//                                 button: true,
//                                 child: Chip(
//                                   label: Text(
//                                     loc,
//                                     style: TextStyle(
//                                       fontSize: optionSize * 0.9,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   backgroundColor: Colors.deepPurple,
//                                   onDeleted: () {
//                                     setState(() => _selected.remove(loc));
//                                   },
//                                   deleteButtonTooltipMessage: 'Remove $loc',
//                                 ),
//                               ))
//                                   .toList(),
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       const Spacer(),
//
//                       // Next button
//                       SizedBox(
//                         height: isSmallPhone ? 44 : 48,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.black,
//                             disabledBackgroundColor: Colors.grey[300],
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           onPressed: (_selected.isEmpty || _isNavigating)
//                               ? null
//                               : _navigateToNext,
//                           child: _isNavigating
//                               ? const SizedBox(
//                             height: 20,
//                             width: 20,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                             ),
//                           )
//                               : Text(
//                             'Next',
//                             style: TextStyle(
//                               fontSize: optionSize,
//                               color: Colors.white,
//                               fontFamily: 'Exo2',
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       SizedBox(height: isLargeTablet ? 40 : isTablet ? 32 : 16),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: const Color(0xFF5B6FFF),
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.white70,
//         showUnselectedLabels: false,
//         showSelectedLabels: true,
//         selectedLabelStyle: const TextStyle(fontFamily: 'Exo2'),
//         unselectedLabelStyle: const TextStyle(fontFamily: 'Exo2'),
//         onTap: _isNavigating ? null : _navigateToTab,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined),
//             activeIcon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.report_rounded),
//             label: 'Hazard',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.summarize_outlined),
//             label: 'Report',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.chat_bubble_outline),
//             label: 'Chat',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_outline),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'arealargerthandoorscreen.dart';
//
// class MouldLocationScreen extends StatefulWidget {
//   const MouldLocationScreen({super.key});
//
//   @override
//   State<MouldLocationScreen> createState() => _MouldLocationScreenState();
// }
//
// class _MouldLocationScreenState extends State<MouldLocationScreen> {
//   final List<String> _allOptions = [
//     'Bedroom',
//     'Bathroom',
//     'Living Room/Lounge',
//     'Hallway/Landing',
//     'All Habitable Rooms',
//     'Kitchen',
//   ];
//
//   List<String> _selected = [];
//   int _selectedIndex = 1; // Hazard tab
//
//   bool _isNavigating = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: [
//           _buildPlaceholderScreen('Home', Icons.home),
//           _buildMainScreen(context),
//           _buildPlaceholderScreen('Report', Icons.summarize),
//           _buildPlaceholderScreen('Chat', Icons.chat_bubble),
//           _buildPlaceholderScreen('Profile', Icons.person),
//         ],
//       ),
//       bottomNavigationBar: _buildBottomNavigationBar(context),
//     );
//   }
//
//   Widget _buildMainScreen(BuildContext context) {
//     return SafeArea(
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           final width = constraints.maxWidth;
//           final height = constraints.maxHeight;
//           final isTablet = width > 600;
//           final isDesktop = width > 840;
//           final isLandscape = width > height;
//
//           final double horizontalPadding = isDesktop ? 48 : (isTablet ? 32 : 20);
//           final double maxContentWidth = isDesktop ? 600 : (isTablet ? 500 : double.infinity);
//           final double titleFontSize = isDesktop ? 26 : (isTablet ? 22 : 19);
//           final double bodyFontSize = isDesktop ? 18 : (isTablet ? 17 : 16);
//           final double buttonHeight = isDesktop ? 64 : (isTablet ? 56 : 48);
//
//           return Center(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(maxWidth: maxContentWidth),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     _buildHeader(context, isTablet, isDesktop),
//
//                     Expanded(
//                       child: SingleChildScrollView(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             SizedBox(height: isTablet ? 28 : 20),
//
//                             Row(
//                               children: [
//                                 Container(
//                                   padding: const EdgeInsets.all(8),
//                                   decoration: BoxDecoration(
//                                     color: Colors.purple.shade50,
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: Icon(
//                                     Icons.location_on,
//                                     size: isTablet ? 32 : 28,
//                                     color: Colors.purple.shade400,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 Expanded(
//                                   child: Text(
//                                     'Where is the mould located?',
//                                     style: TextStyle(
//                                       fontSize: titleFontSize,
//                                       fontWeight: FontWeight.w600,
//                                       fontFamily: 'Exo2',
//                                       color: Colors.black87,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//
//                             SizedBox(height: isTablet ? 24 : 16),
//
//                             _buildInfoBox(bodyFontSize, isTablet),
//
//                             SizedBox(height: isTablet ? 24 : 16),
//
//                             _buildLocationSelector(bodyFontSize, isTablet),
//                           ],
//                         ),
//                       ),
//                     ),
//
//                     _buildBottomSection(context, buttonHeight, bodyFontSize, isTablet),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildLocationSelector(double bodyFontSize, bool isTablet) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Select all that apply:',
//           style: TextStyle(
//             fontSize: bodyFontSize - 1,
//             fontWeight: FontWeight.w600,
//             fontFamily: 'Exo2',
//           ),
//         ),
//         const SizedBox(height: 8),
//         Wrap(
//           spacing: 8,
//           runSpacing: 8,
//           children: _allOptions.map((loc) {
//             final isSelected = _selected.contains(loc);
//             return FilterChip(
//               label: Text(
//                 loc,
//                 style: TextStyle(
//                   fontFamily: 'Exo2',
//                   fontSize: bodyFontSize - 1,
//                   color: isSelected ? Colors.white : Colors.black87,
//                 ),
//               ),
//               selected: isSelected,
//               backgroundColor: Colors.grey.shade100,
//               selectedColor: const Color(0xFF5B6FFF),
//               onSelected: (selected) {
//                 setState(() {
//                   if (selected) {
//                     _selected.add(loc);
//                   } else {
//                     _selected.remove(loc);
//                   }
//                 });
//               },
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildBottomSection(BuildContext context, double buttonHeight, double bodyFontSize, bool isTablet) {
//     final isValid = _selected.isNotEmpty;
//
//     return Column(
//       children: [
//         const Divider(height: 1),
//         Padding(
//           padding: EdgeInsets.symmetric(vertical: isTablet ? 20 : 16),
//           child: SizedBox(
//             height: buttonHeight,
//             child: ElevatedButton.icon(
//               onPressed: isValid && !_isNavigating
//                   ? () async {
//                 setState(() => _isNavigating = true);
//                 await Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (_) => const AreaLargerThanDoorScreen(),
//                   ),
//                 );
//                 if (mounted) setState(() => _isNavigating = false);
//               }
//                   : null,
//               icon: const Icon(Icons.arrow_forward),
//               label: Text(
//                 'Next',
//                 style: TextStyle(
//                   fontSize: bodyFontSize,
//                   fontFamily: 'Exo2',
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.black87,
//                 foregroundColor: Colors.white,
//                 disabledBackgroundColor: Colors.grey.shade300,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildInfoBox(double bodyFontSize, bool isTablet) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.blue.shade50,
//         border: Border.all(color: Colors.blue.shade200),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(Icons.info_outline, size: 20, color: Colors.blue.shade700),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               'Knowing where the mould is located helps us prioritize inspections and repairs, ensuring a safe and healthy environment.',
//               style: TextStyle(
//                 fontSize: bodyFontSize - 2,
//                 fontFamily: 'Exo2',
//                 color: Colors.blue.shade700,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHeader(BuildContext context, bool isTablet, bool isDesktop) {
//     return Padding(
//       padding: EdgeInsets.only(top: isTablet ? 24 : 16, bottom: isTablet ? 16 : 8),
//       child: Row(
//         children: [
//           IconButton(
//             onPressed: () => _showBackDialog(context),
//             icon: Icon(Icons.arrow_back, size: isTablet ? 28 : 24, color: Colors.black87),
//             style: IconButton.styleFrom(
//               backgroundColor: Colors.grey.shade100,
//               padding: EdgeInsets.all(isTablet ? 12 : 8),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBottomNavigationBar(BuildContext context) {
//     final isTablet = MediaQuery.of(context).size.width > 600;
//     return BottomNavigationBar(
//       currentIndex: _selectedIndex,
//       type: BottomNavigationBarType.fixed,
//       backgroundColor: const Color(0xFF5B6FFF),
//       selectedItemColor: Colors.white,
//       unselectedItemColor: Colors.black,
//       selectedLabelStyle: TextStyle(fontFamily: 'Exo2', fontSize: isTablet ? 14 : 12),
//       unselectedLabelStyle: TextStyle(fontFamily: 'Exo2', fontSize: isTablet ? 14 : 12),
//       onTap: (i) => setState(() => _selectedIndex = i),
//       items: const [
//         BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
//         BottomNavigationBarItem(icon: Icon(Icons.report_outlined), label: 'Hazard'),
//         BottomNavigationBarItem(icon: Icon(Icons.summarize_outlined), label: 'Report'),
//         BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
//       ],
//     );
//   }
//
//   Widget _buildPlaceholderScreen(String title, IconData icon) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, size: 64, color: Colors.grey),
//           const SizedBox(height: 16),
//           Text(title, style: const TextStyle(fontSize: 24, fontFamily: 'Exo2', color: Colors.grey)),
//           const SizedBox(height: 8),
//           const Text('Coming Soon', style: TextStyle(fontSize: 16, fontFamily: 'Exo2', color: Colors.grey)),
//         ],
//       ),
//     );
//   }
//
//   void _showBackDialog(BuildContext context) {
//     final isTablet = MediaQuery.of(context).size.width > 600;
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: Text('Leave Form?', style: TextStyle(fontFamily: 'Exo2', fontSize: isTablet ? 24 : 20)),
//         content: Text('Your progress will be lost if you go back.', style: TextStyle(fontFamily: 'Exo2', fontSize: isTablet ? 18 : 16)),
//         actions: [
//           TextButton(onPressed: () => Navigator.of(ctx).pop(), child: Text('Stay', style: TextStyle(fontFamily: 'Exo2'))),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.of(ctx).pop();
//               Navigator.of(context).pop();
//             },
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
//             child: const Text('Leave', style: TextStyle(fontFamily: 'Exo2')),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'arealargerthandoorscreen.dart';
import 'hazards/hazardsscreen.dart';
import 'reports/reportscreen.dart';
import 'settings/settings.dart';

class MouldLocationScreen extends StatefulWidget {
  const MouldLocationScreen({super.key});

  @override
  State<MouldLocationScreen> createState() => _MouldLocationScreenState();
}

class _MouldLocationScreenState extends State<MouldLocationScreen> {
  final List<String> _allOptions = [
    'Bedroom',
    'Bathroom',
    'Living Room/Lounge',
    'Hallway/Landing',
    'All Habitable Rooms',
    'Kitchen',
  ];

  List<String> _selected = [];
  int _selectedIndex = 0; // 👈 Start on Home

  bool _isNavigating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildMainScreen(context), // 👈 Home is now mould location
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
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;
          final isTablet = width > 600;
          final isDesktop = width > 840;

          final double horizontalPadding = isDesktop ? 48 : (isTablet ? 32 : 20);
          final double maxContentWidth = isDesktop ? 600 : (isTablet ? 500 : double.infinity);
          final double titleFontSize = isDesktop ? 26 : (isTablet ? 22 : 19);
          final double bodyFontSize = isDesktop ? 18 : (isTablet ? 17 : 16);
          final double buttonHeight = isDesktop ? 64 : (isTablet ? 56 : 48);

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxContentWidth),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(context, isTablet, isDesktop),

                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: isTablet ? 28 : 20),

                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.purple.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.location_on,
                                    size: isTablet ? 32 : 28,
                                    color: Colors.purple.shade400,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Where is the mould located?',
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

                            _buildInfoBox(bodyFontSize),

                            SizedBox(height: isTablet ? 24 : 16),

                            _buildLocationSelector(bodyFontSize),
                          ],
                        ),
                      ),
                    ),

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

  Widget _buildLocationSelector(double bodyFontSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select all that apply:',
          style: TextStyle(
            fontSize: bodyFontSize - 1,
            fontWeight: FontWeight.w600,
            fontFamily: 'Exo2',
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _allOptions.map((loc) {
            final isSelected = _selected.contains(loc);
            return FilterChip(
              label: Text(
                loc,
                style: TextStyle(
                  fontFamily: 'Exo2',
                  fontSize: bodyFontSize - 1,
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
              selected: isSelected,
              backgroundColor: Colors.grey.shade100,
              selectedColor: const Color(0xFF5B6FFF),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selected.add(loc);
                  } else {
                    _selected.remove(loc);
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  // // change it to make it like other screens
  // Widget _buildBottomSection(BuildContext context, double buttonHeight, double bodyFontSize, bool isTablet) {
  //   final isValid = _selected.isNotEmpty;
  //
  //   return Column(
  //     children: [
  //       const Divider(height: 1),
  //       Padding(
  //         padding: EdgeInsets.symmetric(vertical: isTablet ? 20 : 16),
  //         child: SizedBox(
  //           height: buttonHeight,
  //           child: ElevatedButton.icon(
  //             onPressed: isValid && !_isNavigating
  //                 ? () async {
  //               setState(() => _isNavigating = true);
  //               await Navigator.of(context).push(
  //                 MaterialPageRoute(
  //                   builder: (_) => const AreaLargerThanDoorScreen(),
  //                 ),
  //               );
  //               if (mounted) setState(() => _isNavigating = false);
  //             }
  //                 : null,
  //             label: Text(
  //               'Next',
  //               style: TextStyle(
  //                 fontSize: bodyFontSize,
  //                 fontFamily: 'Exo2',
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: Colors.black87,
  //               foregroundColor: Colors.white,
  //               disabledBackgroundColor: Colors.grey.shade300,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildBottomSection(
      BuildContext context,
      double buttonHeight,
      double bodyFontSize,
      bool isTablet,
      ) {
    final isValid = _selected.isNotEmpty;

    return Column(
      children: [
        const Divider(height: 1),
        Padding(
          padding: EdgeInsets.symmetric(vertical: isTablet ? 20 : 16),
          child: SizedBox(
            width: double.infinity, // 👈 make button full-width
            height: buttonHeight,
            child: ElevatedButton.icon(
              onPressed: isValid && !_isNavigating
                  ? () async {
                setState(() => _isNavigating = true);
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const AreaLargerThanDoorScreen(),
                  ),
                );
                if (mounted) setState(() => _isNavigating = false);
              }
                  : null,
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoBox(double bodyFontSize) {
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
          Icon(Icons.info_outline, size: 20, color: Colors.blue.shade700),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Knowing where the mould is located helps us prioritize inspections and repairs, ensuring a safe and healthy environment.',
              style: TextStyle(
                fontSize: bodyFontSize - 2,
                fontFamily: 'Exo2',
                color: Colors.blue.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isTablet, bool isDesktop) {
    return Padding(
      padding: EdgeInsets.only(top: isTablet ? 24 : 16, bottom: isTablet ? 16 : 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => _showBackDialog(context),
            icon: Icon(Icons.arrow_back, size: isTablet ? 28 : 24, color: Colors.black87),
            style: IconButton.styleFrom(
              backgroundColor: Colors.grey.shade100,
              padding: EdgeInsets.all(isTablet ? 12 : 8),
            ),
          ),
        ],
      ),
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
      selectedLabelStyle: TextStyle(fontFamily: 'Exo2', fontSize: isTablet ? 14 : 12),
      unselectedLabelStyle: TextStyle(fontFamily: 'Exo2', fontSize: isTablet ? 14 : 12),
      onTap: (i) => setState(() => _selectedIndex = i),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.report_outlined), label: 'Hazard'),
        BottomNavigationBarItem(icon: Icon(Icons.summarize_outlined), label: 'Report'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
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
          Text(title, style: const TextStyle(fontSize: 24, fontFamily: 'Exo2', color: Colors.grey)),
          const SizedBox(height: 8),
          const Text('Coming Soon', style: TextStyle(fontSize: 16, fontFamily: 'Exo2', color: Colors.grey)),
        ],
      ),
    );
  }

  void _showBackDialog(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Leave Form?', style: TextStyle(fontFamily: 'Exo2', fontSize: isTablet ? 24 : 20)),
        content: Text('Your progress will be lost if you go back.', style: TextStyle(fontFamily: 'Exo2', fontSize: isTablet ? 18 : 16)),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: Text('Stay', style: TextStyle(fontFamily: 'Exo2'))),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: const Text('Leave', style: TextStyle(fontFamily: 'Exo2')),
          ),
        ],
      ),
    );
  }
}