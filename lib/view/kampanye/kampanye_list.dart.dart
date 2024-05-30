import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../services/kampanye.dart';
import '../theme.dart';
import 'kampanye.dart';

class KampanyeListPage extends StatelessWidget {
  KampanyeListPage({super.key});
  final kampanye = Get.put(KampanyeService());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
        appBar: AppBar(
          title: const Text(
            'Program Kampanye',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: AppTheme.fontName,
              fontWeight: FontWeight.w700,
              fontSize: 22,
              letterSpacing: 1.2,
              color: AppTheme.mainColor,
            ),
          ),
          centerTitle: true,
        ),
        body: Obx(() {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                if (kampanye.isLoading.value) _buildShimmerEffect(context),
                if (kampanye.campaignList.isEmpty)
                  const Center(
                    child: Text(
                      'Belum ada data',
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        letterSpacing: 1.2,
                        color: AppTheme.mainColor,
                      ),
                    ),
                  ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: kampanye.campaignList.length,
                  itemBuilder: (context, index) {
                    final campaign = kampanye.campaignList[index];

                    final day = DateFormat('dd');
                    final month = DateFormat('MMMM');
                    final String days = day.format(campaign.date);
                    final String months = month.format(campaign.date);

                    return InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CampaignDetailDialog(campaign: campaign);
                          },
                        );
                      },
                      child: EventCard(
                          day: days,
                          month: months,
                          color: AppTheme.mainColor,
                          title: campaign.name,
                          subTitile: campaign.description),
                    );
                  },
                ),
              ],
            ),
          );
        }));
  }

  Widget _buildShimmerEffect(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 16),
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
              3,
              (index) => Container(
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(8.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppTheme.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 16, bottom: 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 25.0,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey,
                                    direction: ShimmerDirection.ltr,
                                    child: const Card(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Row(children: <Widget>[
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3.5,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 90.0,
                                            height: 20.0,
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.grey.shade300,
                                              highlightColor: Colors.grey,
                                              direction: ShimmerDirection.ltr,
                                              child: const Card(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 110.0,
                                            height: 25.0,
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.grey.shade300,
                                              highlightColor: Colors.grey,
                                              direction: ShimmerDirection.ltr,
                                              child: const Card(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2.9,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 90.0,
                                            height: 20.0,
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.grey.shade300,
                                              highlightColor: Colors.grey,
                                              direction: ShimmerDirection.ltr,
                                              child: const Card(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 110.0,
                                            height: 25.0,
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.grey.shade300,
                                              highlightColor: Colors.grey,
                                              direction: ShimmerDirection.ltr,
                                              child: const Card(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ]),
                                  )
                                ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
