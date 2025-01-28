### *서울시립대학교 컴퓨터과학부 전공과목 '창의공학기초설계' 프로젝트 ( 2024.09 ~ 2024.11 )*
<br/>

# Fire Evacuation Assistance for Disabled

 장애인들을 위한 화재 대피 보조 어플리케이션입니다.
<br/><br/>

## Environment (개발 환경)

- Flutter 3.24.5
- Framework • revision dec2ee5c1f
- Engine • revision a18df97ca5
- Tools • Dart 3.5.4 • DevTools 2.37.3
<br/>

- Firebase
<br/>

 - *Windows 10, IDE VS Code, Android Studio etc..*
 - Android Studio의 Medium Phone API 35 (mobile emulator)을 통해 개발
  
<br/><br/>

## Userflow
![image](https://github.com/user-attachments/assets/e35aabf5-768d-4644-b8ce-10d0c6dfbbbd)
<br/><br/>

## 로그인   

- 요구조자 : Username: id, Pw: pw
- 관리자 : Username: admin, Pw: admin
<br/>

   *요구조자의 경우 선택한 장애 유형에 따라 시각 장애인의 경우 음성 안내가 제공됩니다.*   
   *관리자의 경우 장애 유형과 상관없이 관리자 화면으로 넘어가게 됩니다.*
<br/><br/>

## 주요 기능   

- **요구조자 (장애인):**
~~화재 발생 시 background에서 돌아가던 어플이 팝업되어 화재 발생 경보 발동 -> 이때, 로그인은 최초 1회만 시행. 이후는 로그인 상태 유지~~
1. 화재 발생 시 신고할 수 있는 신고 기능
2. 대피 메뉴얼 열람
3. 현재 내 위치와 화재 발생 층 확인
4. 대피 안내도 확인
<br/>

- *시각 장애인의 경우 모든 정보를 음성 안내로 제공*   
- *시각 장애인을 위해 시각 장애인의 휴대전화 사용 방법에서 착안하여 신고 화면을 2분할을 해 화면 상단을 클릭할 시 신고가 접수 되도록 하고 하단을 클릭할 시 대피 메뉴얼을 제공할 수 있도록 함*   
<br/><br/>
   
- **관리자 (소방대원):**
1. 화재가 발생한 위치의 도로명주소 및 해당 도로명주소에서의 장애인 요구조자 수를 리스트로 반환
2. 상세 정보를 열람할 시 해당 건물 각 층, 호실마다의 요구조자 수를 반환
<br/>

데이터는 Firebase와 연결하여 CRUD를 구현하였고, 음성은 flutter_tts 라이브러리를 사용하여 구현했다.
<br/><br/>


## 개선해야 할 사항 및 결론

  ~~화재 발생 층 및 현재 나의 위치는 블루투스 비콘의 RSSI 신호를 활용해 나의 위치를 파악하여 firebase를 통해 정보를 주고 받으려 했으나 실패~~   
  ~~hc-06을 지원하는 ble 관련 flutter 라이브러리의 부재와 비용 문제 등으로 하드웨어와 소프트웨어 연결에도 실패~~   
<br/>

  *다만, 연결을 제외하고 아두이노를 활용한 화재 경보기 제작도 성공하였고, 이것이 잘 작동하며 시리얼 넘버를 설정하는데에도 성공*   
  *또한, 비콘의 시리얼 넘버들을 firebase에 저장하여 임의의 시리얼 넘버를 소프트웨어에 주고 해당 주소의 구조 요청이 가는 것도 구현 성공*         
<br/>

  ### 결론적으로는 하드웨어와 소프트웨어의 연결에 실패하였고, 나의 정확한 위치를 특정하는 것은 실패하였으나 그 외의 것들은 모두 구현하였다.      
  <br/>
  
  앞서 이야기한 것처럼 이미 구입한 hc-06을 지원하는 라이브러리의 부재로 인하여 연결이 불가능했고, 우회하여 연결할 방법을 갈구하였으나 금액적인 면에서 ble를 지원하는 모듈의 가격이 지원받을 수 없는 수준이었고 시간적인 측면에서도 불가했음..
<br/>

  *위의 문제들을 해결하고 추가적으로 구현해야 할 것은 화재 발생과 같은 급박한 상황에 맞게 로그인을 최초 1회만 하고 세션이 유지되어 background에서 로그인된 상태로 유지되도록 하여야함*      
<br/><br/>

## 문제 정의

  화재가 발생했을 시 시각 장애인 및 휠체어 장애인 등 장애가 있어 대피가 어려운 분들의 사망률이 비장애인의 사망률의 2배가 넘는다는 소방청 자료에서 착안하여 장애인분들이 화재 발생 시 우선적으로 대피에 도움을 받을 수 있는 어플리케이션을 개발했다..
<br/><br/>

## 개발자
- *개발자: 임준용(리더), 최유현*
- *작성자: 임준용*
<br/><br/>

## 최종 보고서
[최종보고서.pdf](https://github.com/user-attachments/files/18467555/default.pdf)
<br/><br/>

## 실행 사진
![image](https://github.com/user-attachments/assets/0445587b-302d-414a-878d-02763c930997)
![image](https://github.com/user-attachments/assets/dc8c0ea2-f174-4423-b4e4-f44d25b6e497)
![image](https://github.com/user-attachments/assets/26706110-4367-429a-ad39-2cb8dbefb426)
![image](https://github.com/user-attachments/assets/8e050685-d5ed-4988-8964-61af2249465b)
![image](https://github.com/user-attachments/assets/1075c3f9-1897-4189-b841-eb655f642d16)
