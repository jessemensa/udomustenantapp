import 'package:flutter/material.dart';


// This file powers the screen for user to log a compliant or view all compliants logged

class CompliantScreen extends StatefulWidget {
  const CompliantScreen({super.key});

  @override
  State<CompliantScreen> createState() => _CompliantScreenState();
}

class _CompliantScreenState extends State<CompliantScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        children: [
          _buildHomeScreen(context),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex, // set to the _selectedIndex variable which is 0
          // called when item is tapped
          // index argument is set to selectedIndex in the setState method
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });

          },
          // background color of the navigation bar
          backgroundColor: const Color(0xFF8294FA),
          // color when user has not selected an item
          unselectedItemColor: Colors.black,
          // color when user has selected an item
          selectedItemColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home_outlined),
                label: 'Home'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.report_rounded),
                label: 'Hazards'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.summarize_rounded),
                label: 'Reports'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_rounded),
                label: 'Settings'
            ),
          ]
      ),
    );
  }

  // METHOD TO BUILD HOME SCREEN
  Widget _buildHomeScreen(BuildContext context) {

    // use this to get the screen size
    final screenSize = MediaQuery.of(context).size;
    // checks if the screen is a tablet -> if the screen width is greater than 600 then tablet
    final bool isTablet = screenSize.width > 600;
    // checks if the device is in landscape mode
    // landscape mode => width > height, potrait mode => height greater than width
    final bool isLandscape = screenSize.width > screenSize.height;
    // set maximum width -> if its tablet, it limits content width to 500px, on phones there is no limit(infinity)
    final double maxWidth = isTablet ? 500 : double.infinity;
    // phone -> always 24 pixels of padding,
    // if tablet is in landscape mode(15% of screen width as padding eg. 1200px width = 180px padding each side)
    // if tablet is in potrait, 10% of screen width as padding(on 800px width = 80px padding each side)
    final double horizontalPadding = isTablet ? (isLandscape ? screenSize.width * 0.15 : screenSize.width * 0.1) : 24;


    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: isTablet ? 32.0 : 24.0,
                        right: isTablet ? 8.0 : 0.0
                    ),
                    child: IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.notifications_rounded,
                        color: Colors.black,
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
                      Text(
                        'Any Damp and Mould Issues',
                        style: TextStyle(
                          fontSize: isTablet ? 32 : 24,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: isTablet ? 80 : 60),
                      // BUTTONS
                      _buildActionButton(
                          context,
                          'Log a compliant',
                          onPressed: () => {}
                      ),
                      SizedBox(height: isTablet ? 24 : 30),
                      _buildActionButton(context, 'View compliants', onPressed: () => {})
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // METHOD TO BUILD ACTION BUTTON
  // BuildContext context -> for accessing media query
  // text -> for button label text
  // required -> must be provided when calling, voidcallback -> function with no parameters that returns nothing, onPressed -> executes when
  // button is tapped
  Widget _buildActionButton(BuildContext context, String text, {required VoidCallback onPressed}) {
    // access device information(size of device)
    // extracts the width, if the width is greater than 600 pixels then its a tablet
    final bool isTablet = MediaQuery.of(context).size.width > 600;

    return SizedBox(
      width: double.infinity,
      height: isTablet ? 64 : 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isTablet ? 12 : 8),
          )
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: isTablet ? 20 : 16
          )
        ),
      ),
    );
  }
}








