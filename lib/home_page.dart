import 'package:flutter/material.dart';
import 'package:flutter_app/dao/home_dao.dart';
import 'package:flutter_app/model/common_model.dart';
import 'package:flutter_app/model/grid_nav_model.dart';
import 'package:flutter_app/model/home_model.dart';
import 'package:flutter_app/model/sales_box_model.dart';
import 'package:flutter_app/test1/other_function_test.dart';
import 'package:flutter_app/widget/grid_nav.dart';
import 'package:flutter_app/widget/local_nav_widget.dart';
import 'package:flutter_app/widget/sale_box.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  double appBarAlpha = 1.0;
  int maxScroll = 100;
  List<CommonModel> localNav = [];
  GridNavModel gridNav;
  SalesBoxModel salesBox;

  _scroll(double offset) {
    double alpha = offset / 100;
    if (alpha <= 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return new OtherFunctionTest();
            }));
          },
          child: Text("实战"),
        ),
        body: Stack(
          //通过Stack布局，自定义AppBar，主要是flutter提供的appBar写的比较死
          children: <Widget>[
            MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: RefreshIndicator(
                  child: NotificationListener(
                    child: ListView(
                      //ListView默认和顶部有一个状态栏的高度的Padding,使用MediaQuery.removePadding移除
                      children: <Widget>[
                        Container(
                          height: 200,
                          child: Swiper(
                            itemBuilder: (BuildContext context, int index) {
                              return new Image.network(
                                "https://github.com/jzoom/flutter_swiper/raw/master/banner.jpg",
                                fit: BoxFit.fill,
                              );
                            },
                            itemCount: 3,
                            autoplay: true,
                            pagination: new SwiperPagination(),
                            control: new SwiperControl(),
                          ),
                        ),
                        LocalNavWidget(
                          localNavList: localNav,
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: GridNav(
                            gridNavModel: gridNav,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: SalesBox(
                            salesBoxModel: salesBox,
                          ),
                        )
                      ],
                    ),
                    onNotification: (scrollNotification) {
                      //ScrollUpdateNotification只有是滚动大于0的时候,并且是ListView，因为ListView是NotificationListener的第一个孩子
                      //NotificationListener会监听整个树，一层一层向下监听，因为我们只是想监听ListView，所以通过depth
                      if (scrollNotification is ScrollUpdateNotification &&
                          scrollNotification.depth == 0) {
                        _scroll(scrollNotification.metrics.pixels);
                      }
                    },
                  ),
                  onRefresh: () => _loadData()),
            ),
            Opacity(
                opacity: appBarAlpha,
                child: Container(
                  height: 60,
                  color: Colors.white,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text("首页"), //自定义AppBar，
                    ),
                  ),
                ))
          ],
        ));
  }

  Future<void> _loadData() async {
    try {
      HomeModel homeModel = await HomeDao.fetchHomeData();
      setState(() {
        localNav = homeModel.localNavList;
        gridNav = homeModel.gridNav;
        salesBox = homeModel.salesBox;
      });
    } catch (e) {
      print(e);
    }
  }
}
