# 📍 Flutter Search Local

Flutter 기반 지역 검색 및 지도 표시 앱입니다.  
네이버 지도와 VWorld API를 연동하여 위치 검색, 지도 마커 표시, 상세 보기 기능을 제공합니다.

---

## 🚀 Getting Started

flutter run
🗂 폴더 구조
bash
복사
편집
lib/
├── core/                          # 공통 유틸 및 헬퍼 함수
│   ├── helper/                   # 위치 관련 도우미
│   │   └── geolocator_helper.dart
│   └── util/                     # 유틸 함수
│       ├── convert_vworld_to_naver_lat_lng.dart
│       └── remove_tag.dart

├── data/                          # 데이터 계층
│   ├── model/                    # 모델 정의
│   │   └── location.dart
│   └── repository/              # 데이터 요청/캐시 처리
│       └── location_repository.dart

├── presentation/                 # UI 계층
│   └── page/
│       ├── detail/              # 상세 페이지
│       │   └── detail_page.dart
│       └── home/                # 홈 화면 관련
│           ├── widget/         # 홈 페이지 하위 위젯
│           │   ├── appbar.dart
│           │   ├── draggable_search_sheet.dart
│           │   ├── local_search_result_card.dart
│           │   └── location_marker_map.dart
│           ├── home_page.dart
│           └── home_page_view_model.dart

└── main.dart                     # 앱 진입점
📌 주요 기능
🔍 키워드 및 현재 위치 기반 장소 검색

📍 네이버 지도 위 마커 표시

🧭 위치 터치 시 지도 이동

🧾 상세 카드 리스트 + 드래그 시트 UI

🔧 사용 기술
Flutter

flutter_riverpod – 상태 관리

flutter_naver_map – 네이버 지도 SDK

geolocator – 현재 위치

vworld API – 외부 위치 데이터 요청

