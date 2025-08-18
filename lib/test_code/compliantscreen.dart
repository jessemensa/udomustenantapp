 import 'package:flutter/material.dart';
 import 'hazards/hazardsscreen.dart';
 import 'reports/reportscreen.dart';
 import 'settings/settings.dart';

 // This file powers the screen for user to log a complaint or view all complaints logged
 class ComplaintScreen extends StatefulWidget {
   const ComplaintScreen({super.key});

   @override
   State<ComplaintScreen> createState() => _ComplaintScreenState();
 }

 class _ComplaintScreenState extends State<ComplaintScreen> {

   // keep track of which tab is currently active
   int _selectedIndex = 0;


   @override
   Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Colors.white,
       body: IndexedStack(
         index: _selectedIndex,
         children: [
           _buildHomeScreen(context),
           HazardsScreen(),
           ReportScreen(),
           SettingsScreen(),
         ],
       ),
       bottomNavigationBar: _buildBottomNavigationBar(),
     );
   }

   /* METHOD THAT RETURNS A WIDGET */
   Widget _buildBottomNavigationBar() {

     // this checks if the device is a tablet, it is a tablet if it is greater than 600.
     // the number is then stored in the variable isTablet and used throughout the code
     final bool isTablet = MediaQuery.of(context).size.width > 600;

     return BottomNavigationBar(
       type: BottomNavigationBarType.fixed,
       // tells the widget to show the tab that matches the index
       currentIndex: _selectedIndex,
       // index -> number of the tab the user tapped
       // any time user taps the index is updated into selected index and setState re-renders the screen so the UI changes
       onTap: (index) {
         setState(() {
           _selectedIndex = index;
         });
       },
       // features of the bottom navigation tab
       backgroundColor: const Color(0xFF8294FA),
       unselectedItemColor: Colors.black,
       selectedItemColor: Colors.white,
       // if the selected font size is tablet then use 14 else use 12
       selectedFontSize: isTablet ? 14 : 12,
       // if the unselected font size is tablet then use 14 else use 12
       unselectedFontSize: isTablet ? 14 : 12,
       // if the iconSize is tablet then
       iconSize: isTablet ? 28 : 24,
       items: const [
         BottomNavigationBarItem(
           icon: Icon(Icons.home_outlined),
           activeIcon: Icon(Icons.home),
           label: 'Home',
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.report_outlined),
           activeIcon: Icon(Icons.report),
           label: 'Hazards',
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.summarize_outlined),
           activeIcon: Icon(Icons.summarize),
           label: 'Reports',
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.settings_outlined),
           activeIcon: Icon(Icons.settings),
           label: 'Settings',
         ),
       ],
     );
   }

   /* METHOD THAT RETURNS A WIDGET */
   Widget _buildHomeScreen(BuildContext context) {
     return LayoutBuilder(
       builder: (context, constraints) {
         // More precise responsive breakpoints
         final double width = constraints.maxWidth;
         final bool isTablet = width > 600;
         // final bool isDesktop = width > 840;
         final bool isLandscape = width > constraints.maxHeight;

         // Adaptive sizing
         final double maxContentWidth = isTablet ? 500 : double.infinity;
         final double horizontalPadding = isTablet
             ? (isLandscape ? width * 0.15 : width * 0.1)
             : 24;

         return SafeArea(
           child: Center(
             child: ConstrainedBox(
               constraints: BoxConstraints(maxWidth: maxContentWidth),
               child: Padding(
                 padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                 child: Column(
                   children: [
                     // Notification Icon
                     Align(
                       alignment: Alignment.topRight,
                       child: Padding(
                         padding: EdgeInsets.only(
                           top: isTablet ? 32.0 : 24.0,
                           right: isTablet ? 8.0 : 0.0,
                         ),
                         child: IconButton(
                           onPressed: () {
                             // TODO: Implement notifications
                             ScaffoldMessenger.of(context).showSnackBar(
                               const SnackBar(
                                 content: Text('Notifications coming soon!'),
                                 duration: Duration(seconds: 2),
                               ),
                             );
                           },
                           icon: Icon(
                             Icons.notifications_outlined,
                             color: Colors.black87,
                             size: isTablet ? 32 : 28,
                           ),
                         ),
                       ),
                     ),


                     // Main content area
                     Expanded(
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [

                           // Title with better text
                           Text(
                             'Udomus Tenant',
                             style: TextStyle(
                               fontSize: isTablet ? 32 : 24,
                               fontWeight: FontWeight.w600,
                               color: Colors.black87,
                             ),
                             textAlign: TextAlign.center,
                           ),

                           // Subtitle for better UX
                           const SizedBox(height: 12),
                           Text(
                             'Report Damp and Mould issues in your home to your property manager.',
                             style: TextStyle(
                               fontSize: isTablet ? 18 : 16,
                               color: Colors.black54,
                             ),
                             textAlign: TextAlign.center,
                           ),

                           SizedBox(height: isTablet ? 60 : 48),

                           // ACTION BUTTONS
                           _buildActionButton(
                             context,
                             'Send a Complaint',
                             icon: Icons.send,
                             onPressed: () {
                               // TODO: change to navigate to IssueRaisedDate Screen
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                   builder: (context) => const Scaffold(
                                     body: Center(
                                       child: Text('Complaint Form - Coming Soon'),
                                     ),
                                   ),
                                 ),
                               );
                             },
                           ),
                           SizedBox(height: isTablet ? 24 : 20),
                           _buildActionButton(
                             context,
                             'View Complaints',
                             icon: Icons.list_alt,
                             isSecondary: true,
                             onPressed: () {
                               // TODO: Navigate to complaints list Screen
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                   builder: (context) => const Scaffold(
                                     body: Center(
                                       child: Text('Complaints List - Coming Soon'),
                                     ),
                                   ),
                                 ),
                               );
                             },
                           ),
                         ],
                       ),
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

   // IMPROVED ACTION BUTTON METHOD
   // BuildContext context -> tells flutter where in the widget tree it lives
   // String text -> the label that will be shown in the button
   // required VoidCallback onPressed -> function that runs when the button is tapped, voidcallback means function with no parameter returns nothing
   // IconData -> lets you add an icon
   // bool isSecondary = false → optional parameter, defaults to false. If set to true, the button can be styled as a secondary button (less important, maybe a lighter color).
   Widget _buildActionButton(
       BuildContext context,
       String text, {
         required VoidCallback onPressed,
         IconData? icon,
         bool isSecondary = false,
       }) {
     final bool isTablet = MediaQuery.of(context).size.width > 600;

     return SizedBox(
       width: double.infinity,
       height: isTablet ? 64 : 56,
       child: ElevatedButton.icon(
         style: ElevatedButton.styleFrom(
           backgroundColor: isSecondary ? Colors.white : Colors.black,
           foregroundColor: isSecondary ? Colors.black : Colors.white,
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(isTablet ? 12 : 8),
             side: isSecondary
                 ? const BorderSide(color: Colors.black, width: 2)
                 : BorderSide.none,
           ),
           elevation: isSecondary ? 0 : 2,
         ),
         onPressed: onPressed,
         icon: icon != null
             ? Icon(icon, size: isTablet ? 24 : 20)
             : const SizedBox.shrink(),
         label: Text(
           text,
           style: TextStyle(
             fontSize: isTablet ? 17 : 16,
             fontWeight: FontWeight.w600,
           ),
         ),
       ),
     );
   }
 }






