import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:private_store_admin/config/theme/cw_colors.dart';
import 'package:private_store_admin/presentation/screens/main/main_screen.dart';
import 'package:private_store_admin/presentation/widget/app_list_item.dart';

class MainAddAppBottomSheet extends StatefulWidget {
  final AppListItemCallback addNewAppCallback;

  const MainAddAppBottomSheet({Key? key, required this.addNewAppCallback})
      : super(key: key);

  @override
  State<MainAddAppBottomSheet> createState() => _MainAddAppBottomSheetState();
}

class _MainAddAppBottomSheetState extends State<MainAddAppBottomSheet> {
  final _appNameTextControlelr = TextEditingController();

  final List<String> _dropdownReleaseTypeList = [
    'Alpha',
    'Beta',
    'Enterprise',
    'Production',
    'Store',
    'Custom'
  ];
  final List<String> _dropdownOwnerList = ['최한나[모바일앱개발팀]', 'Coway'];

  var _selectedType;
  var _selectedOwner;

  var _selectedOs;
  var _selectedPlatform;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(30),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Add new app',
                style: TextStyle(fontSize: 46),
              ),

              //닫기
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Image.asset('assets/close.png'),
              ),
            ],
          ),

          const SizedBox(
            height: 20,
          ),

          // 앱이름, 아이콘
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'App name: ',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: TextField(
                        controller: _appNameTextControlelr,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.all(30),
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Enter an app name',
                          hintStyle: TextStyle(fontSize: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (query) {},
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  const Text(
                    'Icon: ',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: (){
                      pickFiles();
                    },
                    child: Container(
                      width: 70,
                      height: 70,
                      color: CwColors.color2,
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),

          // 릴리즈타입, 소유자
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Release Type: ',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    DropdownButton(
                        value: _selectedType,
                        isExpanded: true,
                        hint: Text('Select a release type(optional)'),
                        items: _dropdownReleaseTypeList.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (dynamic value) {
                          setState(() {
                            _selectedType = value;
                          });
                        }),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Owner: ',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DropdownButton(
                      value: _selectedOwner,
                      hint: Text('Select a release type(optional)'),
                      items: _dropdownOwnerList.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (dynamic value) {
                        setState(() {
                          _selectedOwner = value;
                        });
                      }),
                ],
              )
            ],
          ),

          //OS 선택
          Row(
            children: [
              const Text(
                'OS: ',
                style: TextStyle(fontSize: 20),
              ),
              Expanded(
                child: Column(
                  children: [
                    RadioListTile(
                      value: 'iOS',
                      title: Text('iOS'),
                      groupValue: _selectedOs,
                      onChanged: ((value) {
                        setState(() {
                          _selectedOs = value;
                        });
                      }),
                    ),
                    RadioListTile(
                      value: 'Android',
                      title: Text('Android'),
                      groupValue: _selectedOs,
                      onChanged: ((value) {
                        setState(() {
                          _selectedOs = value;
                        });
                      }),
                    ),
                  ],
                ),
              )
            ],
          ),

          //Platform 선택
          Row(
            children: [
              const Text(
                'Platform: ',
                style: TextStyle(fontSize: 20),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RadioListTile(
                      value: 'Objective-C/Swift',
                      title: Text('Objective-C/Swift'),
                      groupValue: _selectedOs,
                      onChanged: ((value) {
                        setState(() {
                          _selectedOs = value;
                        });
                      }),
                    ),
                    RadioListTile(
                      value: 'Flutter',
                      title: Text('Flutter'),
                      groupValue: _selectedOs,
                      onChanged: ((value) {
                        setState(() {
                          _selectedOs = value;
                        });
                      }),
                    ),
                    RadioListTile(
                      value: 'React Native',
                      title: Text('React Native'),
                      groupValue: _selectedOs,
                      onChanged: ((value) {
                        setState(() {
                          _selectedOs = value;
                        });
                      }),
                    ),
                  ],
                ),
              )
            ],
          ),

          //등록 버튼
          GestureDetector(
            onTap: () {
              AppListItem item = AppListItem(
                  appName: _appNameTextControlelr.text,
                  os: _selectedOs,
                  releaseType: _selectedType,
                  role: 'Developer',
                  owner: _selectedOwner);
              widget.addNewAppCallback(item);
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
    );
  }

  void pickFiles() async {
    List<PlatformFile>? paths;
    try {
      paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: ['png', 'jpg', 'jpeg', 'heic'],
      ))
          ?.files;
    } on PlatformException catch (e) {
      print('PlatformException');
    } catch (e) {
      print('exception');
    }
    if (paths != null) {
      if (paths != null) {
        print('bbori upload file : ' + paths.first.name.toString());
      }
    }
  }
}
