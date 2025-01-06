# Fire Evacuation Assistance for Disabled

장애인들을 위한 화재 대피 보조 어플리케이션입니다.

## Environment (개발 환경)

- Flutter 3.24.5
- Framework • revision dec2ee5c1f
- Engine • revision a18df97ca5
- Tools • Dart 3.5.4 • DevTools 2.37.3

- VS Code, Android Studio etc..

## 서울시립대학교 컴퓨터과학부 전공과목 '창의적공학설계' 제출 작품

### Userflow
![image](https://github.com/user-attachments/assets/e35aabf5-768d-4644-b8ce-10d0c6dfbbbd)

### Login

- 요구조자 : Username: id, Pw: pw
- 관리자 : Username: admin, Pw: admin

* 요구조자의 경우 선택한 장애 유형에 따라 시각 장애인의 경우 음성 안내가 제공됩니다.
* 관리자의 경우 장애 유형과 상관없이 관리자 화면으로 넘어가게 됩니다.

### 주요 기능 
- 요구조자 (장애인): 장애 유형을 선택하여 로그인 -> 시각 장애인의 경우 음성 안내를 제공함, 화재 발생 시 신고할 수 있는 신고 기능 및 대피 메뉴얼 열람, 현재 내 위치와 화재 발생 층, 대피 안내도 확인
- 관리자 (소방대원): 화재가 발생한 위치의 도로명주소 및 해당 도로명주소에서의 장애인 요구조자 수를 리스트로 반환 -> 상세 정보를 열람할 시 해당 건물 각 층, 호실마다의 요구조자 수를 반환

### 문제 정의

화재가 발생했을 시 시각 장애인 및 휠체어 장애인 등 장애가 있어 대피가 어려운 분들의 사망률이 비장애인의 사망률의 2배가 넘는다는 사실에서 착안하여
장애인분들이 화재 발생 시 우선적으로 대피에 도움을 받을 수 있는 어플리케이션을 개발했다.
