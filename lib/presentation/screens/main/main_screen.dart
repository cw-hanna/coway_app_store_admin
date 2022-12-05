import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:private_store_admin/config/theme/cw_colors.dart';
import 'package:private_store_admin/data/models/app_file_model.dart';
import 'package:private_store_admin/data/models/app_info_model.dart';
import 'package:private_store_admin/presentation/screens/main/widgets/main_add_app_bottom_sheet.dart';
import 'package:private_store_admin/presentation/screens/main/widgets/main_user_info.dart';
import 'package:private_store_admin/presentation/widget/app_list_item.dart';

import 'package:cross_file/cross_file.dart';


typedef AppListItemCallback = void Function(AppInfoModel app);
typedef AppUploadDragCallback = void Function(XFile? file);
typedef AppUploadFineCallback = void Function(PlatformFile? file);

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<String> _dropdownOsList = ['All', 'Android', 'iOS'];
  final List<String> _dropdownTypeList = ['All', 'Production', 'Develop'];

  final List<AppInfoModel> _originAppList = [
    AppInfoModel('digitalsales-aos-seller', 'Android', 'Production', '22/12/01',
        '2.1.0', 'f', 'hanna', null),
    AppInfoModel('digitalsales-aos-seller', 'iOS', 'Develop', '22/12/02',
        '2.1.0', 'f', 'hanna', null),
    AppInfoModel('Coway', 'Android', 'Production', '22/12/01', '2.1.0', 'f',
        'hanna', null),
    AppInfoModel(
        'Coway', 'iOS', 'Develop', '22/12/01', '2.1.0', 'f', 'hanna', null),
    AppInfoModel('ARCatalogue', 'Android', 'Dev', '22/12/01', '2.1.0', 'f',
        'hanna', null),
    AppInfoModel('ARCatalogue', 'iOS', 'Production', '22/12/01', '2.1.0', 'f',
        'hanna', null),
    AppInfoModel(
        'IoCare', 'Android', 'Dev', '22/12/01', '2.1.0', 'f', 'hanna', null),
    AppInfoModel('dIoCare', 'iOS', 'Production', '22/12/01', '2.1.0', 'f',
        'hanna', null),
  ];
  List<AppInfoModel> _appList = [];

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
              children: [
                //사용자 정보 위젯
                const MainUserInfo(userName: '최한나', teamName: '모바일앱개발팀'),

                //앱 추가 버튼
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return MainAddAppBottomSheet(
                              addNewAppCallback: (app) {
                            setState(() {
                              _originAppList.add(app);
                            });
                          });
                        });
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
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Flexible(
                                  flex: 4,
                                  fit: FlexFit.tight,
                                  child: Text('Name'),
                                ),
                                Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Text('OS')),
                                Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: Text('Release Type')),
                                Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: Text('Version')),
                                Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: Text('UpdateDAte')),
                              ],
                            ),
                          ),
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
                            return AppListItem(appInfoModel:  _appList[index]);
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
  List<AppInfoModel> _filterApp(
      String appNameQuery, String os, String releaseType) {
    List<AppInfoModel> suggestions;

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
