import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_images.dart';
import '../widgets/image_view.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: ImageView(
            image: AppImages.icHomeSelected,
            imageType: ImageType.svg,
          ),
          label: 'Home',
          activeIcon: ImageView(
            image: AppImages.icHomeSelected,
            imageType: ImageType.svg,
          ),
        ),
        BottomNavigationBarItem(
          icon: ImageView(
            image: AppImages.icLearnUnselected,
            imageType: ImageType.svg,
          ),
          label: 'Learn',
          activeIcon: ImageView(
            image: AppImages.icLearnSelected,
            imageType: ImageType.svg,
          ),
        ),
        BottomNavigationBarItem(
          icon: ImageView(
            image: AppImages.icHubUnselected,
            imageType: ImageType.svg,
          ),
          label: 'Hub',
          activeIcon: ImageView(
            image: AppImages.icHubUnselected,
            imageType: ImageType.svg,
          ),
        ),
        BottomNavigationBarItem(
          icon: ImageView(
            image: AppImages.icChatUnselected,
            imageType: ImageType.svg,
          ),
          label: 'Chat',
          activeIcon: ImageView(
            image: AppImages.icChatUnselected,
            imageType: ImageType.svg,
          ),
        ),
        BottomNavigationBarItem(
          icon: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(AppImages.icDefaultProfile),
                fit: BoxFit.fill,
              ),
            ),
          ),
          label: 'Profile',
          activeIcon: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(AppImages.icDefaultProfile),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: BLUE,
      unselectedItemColor: GREY,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      onTap: onItemTapped,
    );
  }
}
