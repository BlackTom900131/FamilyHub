import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../immuch/photo_gallery.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Center(
      // child: Card(
      //   elevation: 4,
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      //   child: SizedBox(
      //     width: 300,
      //     height: 350,
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.stretch,
      //       children: [
      //         // Top: Photo
      //         ClipRRect(
      //           borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      //           child: Image(
      //             image: NetworkImage('https://picsum.photos/300/200'),
      //             height: 200,
      //             fit: BoxFit.cover,
      //           ),
      //         ),
      //         // Bottom: Text
      //         Padding(
      //           padding: EdgeInsets.all(16),
      //           child: Text(
      //             'This is a sample card with a photo on top and text at the bottom.',
      //             style: TextStyle(fontSize: 16),
      //             textAlign: TextAlign.center,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      child: PhotoGallery(imageUrls: [
            'https://picsum.photos/id/1011/200/200',
            'https://picsum.photos/id/1012/200/200',
            'https://picsum.photos/id/1013/200/200',
            // Add more URLs as needed
          ],),
    ),
    Center(child: Text('Files Page')),
    Center(child: Text('Location Page')),
    Center(child: Text('Location Page')),
    Center(child: Text('Location Page')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 35,
              width: 35,
              child: SvgPicture.asset(
                'assets/icons/immuch.svg',
                colorFilter: _selectedIndex == 0 
                    ? null  // No filter, keep original colors
                    : const ColorFilter.mode(Colors.grey, BlendMode.srcIn),  // Grey out when unselected
              ),
            ),
            label: 'Gallery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on,
                color: _selectedIndex == 1 ? Colors.blue : Colors.grey),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 25,
              width: 25,
              child: SvgPicture.asset(
                'assets/icons/Files.svg',
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 2 ? Colors.blue : Colors.grey, BlendMode.srcIn,),
              ),
            ),
            label: 'Files',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 25,
              width: 25,
              child: SvgPicture.asset(
                'assets/icons/Profile.svg',
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 3 ? Colors.blue : Colors.grey, BlendMode.srcIn,),
              ),
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedLabelStyle: TextStyle(color: Colors.black),   // selected label color
        unselectedLabelStyle: TextStyle(color: Colors.grey),  // unselected label color
        showUnselectedLabels: true,                           // ensures all labels are visible
      ),
    );
  }
}