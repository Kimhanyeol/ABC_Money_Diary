import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';

class WriteDiaryScreen extends StatefulWidget {
  const WriteDiaryScreen({super.key});

  @override
  State<WriteDiaryScreen> createState() => _WriteDiaryScreenState();
}

class _WriteDiaryScreenState extends State<WriteDiaryScreen> {
  // ABC 선택 관련 변수
  bool aButton = false;
  bool bButton = false;
  bool cButton = false;
  late List<bool> isSelected;

  //날짜 선택 관련 변수
  String selectedDate = "";

  // 기본 오늘 날짜 구하는 곳
  String getToday() {
    if (selectedDate == "") {
      DateTime now = DateTime.now();
      DateFormat formatter = DateFormat('yyyy-MM-dd (E)', 'ko');
      String Today = formatter.format(now);
      return Today;
    }
    return selectedDate;
  }

  // 날짜 클릭 시 선택 화면 나오게 만드는 곳
  Future onTapDateButton(BuildContext context) async {
    DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,

      //날짜 선택 부분의 색깔 등등 테마 설정부분
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.orange,
                onPrimary: Colors.white,
              ),
            ),
            child: child!);
      },
    );
    if (selected != null) {
      setState(() {
        selectedDate = (DateFormat('yyyy-MM-dd (E)', 'ko')).format(selected);
      });
    }
  }

  //시간 선택 관련 변수
  String selectedTime = "";

  // 기본 지금 시간 구하는 곳
  String getTimeNow() {
    if (selectedTime == "") {
      DateTime now = DateTime.now();
      DateFormat formatter = DateFormat('a HH:mm', 'ko');
      String NowTime = formatter.format(now);
      return NowTime;
    }
    return selectedTime;
  }

  // 시간 클릭 시 선택 화면 나오게 만드는 곳
  Future onTapTimeButton(BuildContext context) async {
    TimeOfDay? selected = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
              primary: Colors.orange,
            )),
            child: child!);
      },
    );

    if (selected != null) {
      setState(() {
        if (selected.hour < 12) {
          selectedTime = '오전 ${selected.hourOfPeriod}:${selected.minute}';
        } else {
          selectedTime = '오후 ${selected.hourOfPeriod}:${selected.minute}';
        }
      });
    }
  }

  //내용 부분 컨트롤러
  final TextEditingController _ContentTextEditingController =
      TextEditingController();

  //메모 부분 컨트롤러
  final TextEditingController _MemoTextEditingController =
      TextEditingController();

  final ImagePicker picker = ImagePicker();
  XFile? _image; // 카메라로 촬영한 이미지를 저장할 변수

  @override
  void initState() {
    isSelected = [aButton, bButton, cButton];
    super.initState();
  }

  //ABC 버튼 선택
  void onTapToggleButton(index) {
    if (index == 0) {
      aButton = true;
      bButton = false;
      cButton = false;
    } else if (index == 1) {
      aButton = false;
      bButton = true;
      cButton = false;
    }
    if (index == 2) {
      aButton = false;
      bButton = false;
      cButton = true;
    }
    setState(() {
      isSelected = [aButton, bButton, cButton];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //스테이터스바 투명하게 만드는 부분
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.orange,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        //앱바 높이
        toolbarHeight: 70,
        //글자 색
        foregroundColor: Colors.white,
        //앱 바 색
        backgroundColor: Colors.orange,
        //앱 바 밑에 음영 사라지게 만드는 코드
        elevation: 2,
        //타이틀 왼쪽에 딱 붙이는 코드
        titleSpacing: 0,

        title: Text(
          '가계부 작성',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontFamily: "Yeongdeok-Sea",
          ),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.symmetric(horizontal: 20),
            onPressed: null,
            icon: Icon(
              Icons.help,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //ABC 선택하는 부분
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: ToggleButtons(
                borderRadius: BorderRadius.circular(20),
                //선택한 버튼의 테두리 색
                selectedBorderColor: Colors.orange,
                //테두리 색
                borderColor: Colors.orange,
                //선택한 버튼의 배경색
                fillColor: Colors.orange,
                //기본 버튼들의 글자색
                color: Colors.orange,
                //선택한 버튼의 글자색
                selectedColor: Colors.white,
                //터치 이펙트 색
                splashColor: Colors.white30,
                isSelected: isSelected,
                onPressed: onTapToggleButton,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                    child: Text(
                      'A',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Yeongdeok-Sea",
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                    child: Text(
                      'B',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Yeongdeok-Sea",
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                    child: Text(
                      'C',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Yeongdeok-Sea",
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //날짜 선택하는 부분
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        Text(
                          '날짜',
                          style: TextStyle(
                            fontFamily: "HakgyoansimWoojuR",
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Icon(Icons.chevron_right_rounded, color: Colors.grey),
                      ],
                    ),
                  ),

                  //날짜선택
                  TextButton(
                    onPressed: () => onTapDateButton(context),
                    child: Text(
                      getToday(),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.brown,
                      ),
                    ),
                  ),

                  //시간선택
                  TextButton(
                    onPressed: () => onTapTimeButton(context),
                    child: Text(
                      getTimeNow(),
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //분류 선택하는 부분
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(20, 5, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        Text(
                          '분류',
                          style: TextStyle(
                            fontFamily: "HakgyoansimWoojuR",
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Icon(Icons.chevron_right_rounded, color: Colors.grey),
                      ],
                    ),
                  ),
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: '분류를 입력하세요',
                        hintText: 'ex) 식비, 교통비...',
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(color: Colors.brown.shade200),
                        hintStyle: TextStyle(color: Colors.brown.shade200),

                        //텍스트 필드 내에 여백이 싹 사라짐
                        //isCollapsed: true,

                        //텍스트를 입력하면 라벨 텍스트는 안보이게 만드는 코드
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 5,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //금액 입력하는 부분
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        Text(
                          '금액',
                          style: TextStyle(
                            fontFamily: "HakgyoansimWoojuR",
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Icon(Icons.chevron_right_rounded, color: Colors.grey),
                      ],
                    ),
                  ),
                  Flexible(
                    child: TextField(
                      keyboardType: TextInputType.number,

                      //키보드에서 숫자 외에 .-/ 이런 거 입력 못하게 막는 코드
                      //3자리마다 , 찍어주고 ￦표시 띄워주는 코드
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        CurrencyTextInputFormatter(
                            locale: 'ko', decimalDigits: 0, symbol: '￦ ')
                      ],

                      decoration: InputDecoration(
                        labelText: '금액을 입력하세요',
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(color: Colors.brown.shade200),
                        //텍스트 필드 내에 여백이 싹 사라짐
                        //isCollapsed: true,

                        //텍스트를 입력하면 라벨 텍스트는 안보이게 만드는 코드
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 5,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //내용 입력하는 부분
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(20, 10, 20, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        Text(
                          '내용',
                          style: TextStyle(
                            fontFamily: "HakgyoansimWoojuR",
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Icon(Icons.chevron_right_rounded, color: Colors.grey),
                      ],
                    ),
                  ),
                  Flexible(
                    child: TextField(
                      controller: _ContentTextEditingController,
                      decoration: InputDecoration(
                        labelText: '내용을 입력하세요',
                        hintText: 'ex) 점심 값, 군것질...',
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(color: Colors.brown.shade200),
                        hintStyle: TextStyle(color: Colors.brown.shade200),

                        //한 번에 내용 삭제 하는 아이콘(suffixIcon이 오른쪽)
                        suffixIcon: GestureDetector(
                          onTap: () => _ContentTextEditingController.clear(),
                          child: Icon(
                            Icons.cancel,
                          ),
                        ),

                        //텍스트 필드 내에 여백이 싹 사라짐
                        //isCollapsed: true,

                        //텍스트를 입력하면 라벨 텍스트는 안보이게 만드는 코드
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 5,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //필수 항목과 선택 항목 구분선
            Container(
              height: 10,
              color: Colors.grey.shade300,
            ),

            //메모 입력하는 부분
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(20, 10, 20, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: TextField(
                      controller: _MemoTextEditingController,
                      decoration: InputDecoration(
                        labelText: '메모',
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(color: Colors.brown.shade200),

                        //오른쪽 아이콘
                        //갤러리나 카메라에서 사진 업로드 하는 부분
                        suffixIcon: PopupMenuButton<MenuType>(
                          icon: Icon(Icons.camera_alt),
                          onSelected: (MenuType result) async {
                            //image를 가져와서 images에 저장
                            //카메라 클릭 시 작동
                            if (result.englishName == 'camera') {
                              final XFile? pickedFile = await picker.pickImage(
                                  source: ImageSource.camera);
                              if (pickedFile != null) {
                                setState(() {
                                  _image = XFile(pickedFile.path);
                                });
                              }
                            }

                            //갤러리 클릭 시 작동
                            if (result.englishName == 'gallery') {
                              final XFile? pickedFile = await picker.pickImage(
                                  source: ImageSource.gallery);
                              if (pickedFile != null) {
                                setState(() {
                                  _image = XFile(pickedFile.path);
                                });
                              }
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              for (final value in MenuType.values)
                                PopupMenuItem(
                                    value: value,
                                    child: Text(value.koreanName)),
                            ];
                          },
                        ),

                        //텍스트를 입력하면 라벨 텍스트는 안보이게 만드는 코드
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 5,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //사진 보여주는 부분
            Container(
              child: _buildPhotoArea(),
            ),

            //화면 끝에 안 닿게 만들기 위한 공간
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  //사진 보여주는 영역
  Widget _buildPhotoArea() {
    return _image != null
        ? SizedBox(
            width: 300,
            height: 300,
            child: Image.file(File(_image!.path)), //가져온 이미지를 화면에 띄워주는 코드
          )
        : SizedBox();
  }
}

//카메라 아이콘 클릭 시 카메라로 사진을 찍을 건지 갤러리에서 선택할건지 목록
enum MenuType {
  camera('camera', '카메라'),
  gallery('gallery', '갤러리');

  const MenuType(this.englishName, this.koreanName);

  final String englishName;
  final String koreanName;
}
