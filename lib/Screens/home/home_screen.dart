import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:freelancing_task/Providers/lessons_provider.dart';
import 'package:freelancing_task/remote/models/lessons_response.dart';
import 'package:freelancing_task/remote/models/programs_response.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Providers/programs_provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../../widgets/image_view.dart';
import '../../widgets/tile_container.dart';

class ProductsHomePage extends StatefulWidget {
  const ProductsHomePage({Key? key}) : super(key: key);

  @override
  State<ProductsHomePage> createState() => _ProductsHomePageState();
}

class _ProductsHomePageState extends State<ProductsHomePage> {
  @override
  void initState() {
    final provider = Provider.of<ProgramsProvider>(context, listen: false);
    final lesson = Provider.of<LessonsProvider>(context, listen: false);
    provider.getDataFromAPI();
    lesson.getDataFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final programsProvider = Provider.of<ProgramsProvider>(context);
    final lessonProvider = Provider.of<LessonsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BLUE1,
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          child: ImageView(
            image: AppImages.icMenu,
            imageType: ImageType.svg,
          ),
        ),
        actions: [
          _buildAppBarIcon(AppImages.icMessage),
          _buildAppBarIcon(AppImages.icNotification),
        ],
      ),
      body: _buildBody(lessonProvider, programsProvider),
    );
  }

  Widget _buildAppBarIcon(String image) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, top: 16, bottom: 16),
      child: ImageView(
        image: image,
        imageType: ImageType.svg,
      ),
    );
  }

  Widget _buildBody(LessonsProvider lessonProvider, ProgramsProvider programsProvider) {
    return lessonProvider.isLoading || programsProvider.isLoading
        ? _getLoadingUI()
        : lessonProvider.error.isNotEmpty || programsProvider.error.isNotEmpty
        ? _getErrorUI(lessonProvider.error.isNotEmpty
        ? lessonProvider.error
        : programsProvider.error)
        : _getBodyUI(lessonProvider.lessonsResponse, programsProvider.programsResponse);
  }

  Widget _getLoadingUI() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children:  [
          SpinKitFadingCircle(
            color: Colors.blue,
            size: 80,
          ),
          Text(
            'Loading...',
            style: TextStyle(fontSize: 20.sp, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget _getErrorUI(String error) {
    return Center(
      child: Text(
        error,
        style: TextStyle(color: Colors.red, fontSize: 22.sp),
      ),
    );
  }

  Widget _getBodyUI(
      LessonsResponse lessonsResponse, ProgramsResponse programsResponse) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            color: BLUE1,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),
                  Text(
                    'Hello, Priya!',
                    style: TextStyle(
                      color: BLACK1,
                      fontStyle: FontStyle.normal,
                      fontFamily: "Lora",
                      fontWeight: FontWeight.w500,
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'What do you wanna learn today?',
                    style: TextStyle(
                      color: GREY2,
                      fontStyle: FontStyle.normal,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Row(
                    children: [
                      buildExpandedContainer(
                        icon: AppImages.icPrograms,
                        text: 'Programs',
                        backgroundColor: BLUE1,
                        borderColor: BLUE,
                        textColor: BLUE,
                      ),
                      SizedBox(width: 8.w),
                      buildExpandedContainer(
                        icon: AppImages.icGetHelp,
                        text: 'Get help',
                        backgroundColor: BLUE1,
                        borderColor: BLUE,
                        textColor: BLUE,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      buildExpandedContainer(
                        icon: AppImages.icLearnSelected,
                        text: 'Learn',
                        backgroundColor: BLUE1,
                        borderColor: BLUE,
                        textColor: BLUE,
                      ),
                      SizedBox(width: 8.w),
                      buildExpandedContainer(
                        icon: AppImages.icDdTracker,
                        text: 'DD Tracker',
                        backgroundColor: BLUE1,
                        borderColor: BLUE,
                        textColor: BLUE,
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),

          //Programs for you
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Programs for you',
                  style: TextStyle(
                    color: BLACK1,
                    fontStyle: FontStyle.normal,
                    fontFamily: "Lora",
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      child: Text(
                        'View all',
                        style: TextStyle(
                            color: GREY2,
                            fontStyle: FontStyle.normal,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp),
                      ),
                    ),
                    Container(
                      child: ImageView(
                        image: AppImages.icArrowRight,
                        imageType: ImageType.svg,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          Container(
            height: 280.h,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: programsResponse.items.length,
              itemBuilder: (context, index) {
                final item = programsResponse.items[index];
                return Padding(
                  padding: EdgeInsets.only(left: index == 0 ? 0 : 16),
                  child: Container(
                    width: 242.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: GREY3, width: 1),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ImageView(
                            image: 'https://www.candere.com/media/mageplaza/blog/post/uploads/2021/07/platinum-offer.jpg',
                            imageType: ImageType.network,
                            boxFit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 16, 12, 21),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.category,
                                  style: TextStyle(
                                    color: BLUE,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  item.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: BLACK,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                SizedBox(height: 15.h),
                                Text(
                                  '${item.lesson} lessons',
                                  style: TextStyle(
                                    color: GREY,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 32.h),

          //Events and experiences
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Events and experiences',
                  style: TextStyle(
                    color: BLACK1,
                    fontStyle: FontStyle.normal,
                    fontFamily: "Lora",
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      child: Text(
                        'View all',
                        style: TextStyle(
                            color: GREY2,
                            fontStyle: FontStyle.normal,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp),
                      ),
                    ),
                    Container(
                      child: ImageView(
                        image: AppImages.icArrowRight,
                        imageType: ImageType.svg,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Container(
            height: 280.h,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: lessonsResponse.items.length,
              itemBuilder: (context, index) {
                final item = lessonsResponse.items[index];
                return Padding(
                  padding: EdgeInsets.only(left: index == 0 ? 0 : 16),
                  child: Container(
                    width: 242.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: GREY3, width: 1),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ImageView(
                            image: 'https://www.candere.com/media/mageplaza/blog/post/uploads/2021/07/platinum-offer.jpg',
                            imageType: ImageType.network,
                            boxFit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 16, 12,0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.category,
                                  style: TextStyle(
                                    color: BLUE,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  item.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: BLACK,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                SizedBox(height: 15.h),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      formatDate(item.createdAt),
                                      style: TextStyle(
                                        color: GREY,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 16),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(100),
                                        border: Border.all(
                                          color: BLUE,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Text(
                                        'Book',
                                        style: TextStyle(
                                          color: BLUE,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 32.h),

          //Lessons for you
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Lessons for you',
                  style: TextStyle(
                    color: BLACK1,
                    fontStyle: FontStyle.normal,
                    fontFamily: "Lora",
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      child: Text(
                        'View all',
                        style: TextStyle(
                            color: GREY2,
                            fontStyle: FontStyle.normal,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp),
                      ),
                    ),
                    Container(
                      child: ImageView(
                        image: AppImages.icArrowRight,
                        imageType: ImageType.svg,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Container(
            height: 280.h,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: lessonsResponse.items.length,
              itemBuilder: (context, index) {
                final item = lessonsResponse.items[index];
                return Padding(
                  padding: EdgeInsets.only(left: index == 0 ? 0 : 16),
                  child: Container(
                    width: 242.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: GREY3, width: 1),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ImageView(
                            image: 'https://www.candere.com/media/mageplaza/blog/post/uploads/2021/07/platinum-offer.jpg',
                            imageType: ImageType.network,
                            boxFit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 16, 12, 21),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.category,
                                  style: TextStyle(
                                    color: BLUE,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                SizedBox(height: 7.h),
                                Text(
                                  item.name,maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: BLACK,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                SizedBox(height: 15.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      formatDuration(item.duration),
                                      style: TextStyle(
                                        color: GREY,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    if (item.locked)
                                      ImageView(
                                        image: AppImages.icLock,
                                        imageType: ImageType.svg,
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  String formatDuration(int minutes) {
    if (minutes < 60) {
      return '$minutes min';
    } else {
      final hours = minutes ~/ 60;
      final remainingMinutes = minutes % 60;
      return remainingMinutes == 0
          ? '$hours hr'
          : '$hours hr $remainingMinutes min';
    }
  }

  String formatDate(DateTime date) {
    String formattedDate = DateFormat('d MMM, EEEE').format(date);
    return formattedDate;
  }

}
