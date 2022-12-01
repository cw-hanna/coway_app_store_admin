
import 'package:flutter/material.dart';
import 'package:private_store_admin/config/theme/cw_colors.dart';
import 'package:private_store_admin/presentation/screens/main/widgets/main_add_app_bottom_sheet.dart';
import 'package:private_store_admin/presentation/screens/main/widgets/main_user_info.dart';
import 'package:private_store_admin/presentation/widget/app_list_item.dart';

typedef AppListItemCallback = void Function(AppListItem app);

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<String> _dropdownOsList = ['All', 'Android', 'iOS'];
  final List<String> _dropdownTypeList = ['All', 'Production', 'Develop'];

  final List<AppListItem> _originAppList = [
    const AppListItem(
        appName: 'digitalsales-aos-seller',
        os: 'Android',
        releaseType: 'Production',
        role: 'Collaborator',
        owner: 'Coway'),
    const AppListItem(
        appName: 'digitalsales-aos-seller',
        os: 'Android',
        releaseType: 'Production',
        role: 'Collaborator',
        owner: 'Coway'),
    const AppListItem(
        appName: 'IoCare',
        os: 'iOS',
        releaseType: 'Develop',
        role: 'Developer',
        owner: 'Coway'),
    const AppListItem(
        appName: 'ARCatalogue',
        os: 'iOS',
        releaseType: 'Develop',
        role: 'Developer',
        owner: 'Coway'),
    const AppListItem(
        appName: 'IoCare',
        os: 'Android',
        releaseType: 'Develop',
        role: 'Developer',
        owner: 'Coway'),
    const AppListItem(
        appName: 'Coway',
        os: 'Android',
        releaseType: 'Production',
        role: 'Admin',
        owner: 'Coway')
  ];
  List<AppListItem> _appList = [];

  var _selectedOs = 'All';
  var _selectedReleaseType = 'All';

  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _appList = _originAppList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Coway App Store'),
        backgroundColor: CwColors.color3,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                //사용자 정보 위젯
                const MainUserInfo(userName: '최한나', teamName: '모바일앱개발팀'),

                //앱 추가 버튼
                GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return MainAddAppBottomSheet(addNewAppCallback: (app) {
                setState(() {
                  _originAppList.add(app);
                });
              });
            }
          );
      },
      child: Container(
        color: CwColors.color3,
        padding: EdgeInsets.all(10),
        child: Text(
          'Add new app',
        ),
      ),
    )
              ],
            ),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('My Apps'),
                          const Spacer(),

                          //검색
                          Container(
                            padding: const EdgeInsets.only(right: 10),
                            width: 200,
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                isDense: true, 
                                contentPadding: const EdgeInsets.all(1),
                                prefixIcon: const Icon(Icons.search),
                                hintText: 'Search',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (query) {
                                setState(() {
                                  _appList = _filterApp(
                                      query, _selectedOs, _selectedReleaseType);
                                });
                              },
                            ),
                          ),

                          //Os 필터
                          DropdownButton(
                              value: _selectedOs,
                              items: _dropdownOsList.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (dynamic value) {
                                setState(() {
                                  _selectedOs = value;
                                  _appList = _filterApp(_searchController.text,
                                      _selectedOs, _selectedReleaseType);
                                });
                              }),
                          const SizedBox(
                            width: 10,
                          ),

                          //Release Type 필터
                          DropdownButton(
                              value: _selectedReleaseType,
                              items: _dropdownTypeList.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (dynamic value) {
                                setState(() {
                                  _selectedReleaseType = value;
                                  _appList = _filterApp(_searchController.text,
                                      _selectedOs, _selectedReleaseType);
                                });
                              }),
                        ],
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      //리스트 헤더
                      Column(
                        children: const [
                          AppListItem(
                              appName: 'Name',
                              os: 'Os',
                              releaseType: 'Release Type',
                              role: 'Role',
                              owner: 'Owner'),
                          Divider(
                            height: 1,
                          )
                        ],
                      ),

                      //앱 리스트
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: _appList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _appList[index];
                          })
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  //앱이름 검색창, os필터, releaseType필터 기능
  List<AppListItem> _filterApp(
      String appNameQuery, String os, String releaseType) {
    List<AppListItem> suggestions;

    if ('All' == os) {
      suggestions = _originAppList;
    } else {
      suggestions = _originAppList.where((app) {
        return app.os.contains(os);
      }).toList();
    }

    if ('All' == releaseType) {
    } else {
      suggestions = suggestions.where((app) {
        return app.releaseType.contains(releaseType);
      }).toList();
    }

    if (appNameQuery.isEmpty) {
    } else {
      suggestions = suggestions.where((app) {
        return app.appName.toLowerCase().contains(appNameQuery.toLowerCase());
      }).toList();
    }

    return suggestions;
  }
}
