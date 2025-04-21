# 📍 Flutter Search Local

Flutter 기반 지역 검색 및 지도 표시 앱입니다.  
네이버 지도와 VWorld API를 연동하여 위치 검색, 지도 마커 표시, 상세 보기 기능을 제공합니다.

---

## 📂 폴더 구조
```
📦lib
 ┣ 📂core
 ┃ ┣ 📂helper
 ┃ ┃ ┗ 📜geolocator_helper.dart
 ┃ ┗ 📂util
 ┃ ┃ ┣ 📜convert_vworld_to_naver_lat_lng.dart
 ┃ ┃ ┗ 📜remove_tag.dart
 ┣ 📂data
 ┃ ┣ 📂model
 ┃ ┃ ┗ 📜location.dart
 ┃ ┗ 📂repository
 ┃ ┃ ┗ 📜location_repository.dart
 ┣ 📂presentation
 ┃ ┗ 📂page
 ┃ ┃ ┣ 📂detail
 ┃ ┃ ┃ ┗ 📜detail_page.dart
 ┃ ┃ ┗ 📂home
 ┃ ┃ ┃ ┣ 📂widget
 ┃ ┃ ┃ ┃ ┣ 📜appbar.dart
 ┃ ┃ ┃ ┃ ┣ 📜draggable_search_sheet.dart
 ┃ ┃ ┃ ┃ ┣ 📜local_search_result_card.dart
 ┃ ┃ ┃ ┃ ┗ 📜location_marker_map.dart
 ┃ ┃ ┃ ┣ 📜home_page.dart
 ┃ ┃ ┃ ┗ 📜home_page_view_model.dart
 ┗ 📜main.dart
```

## 🚀 주요 기능
- 🔍 키워드 및 현재 위치 기반 장소 검색
- 📍 네이버 지도 위 마커 표시
- 🧭 위치 터치 시 지도 이동
- 🧾 상세 카드 리스트 + 드래그 시트 UI

##🔧 사용 기술
- Flutter
- flutter_riverpod – 상태 관리
- flutter_naver_map – 네이버 지도 SDK
- geolocator – 현재 위치
- vworld API – 외부 위치 데이터 요청

---
