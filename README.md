# 🎬 KH-MovieDiary

영화 검색 및 리뷰를 위한 웹 프로젝트입니다.  
TMDB API를 활용하여 영화 정보를 제공하고,  
사용자 리뷰 및 개인화 기능을 구현하는 것을 목표로 합니다.
---
팀원 : 👑유지훈, 강민채, 강승주, 임유택, 조수인


---

## 👥 Team Collaboration Rules

- PR을 올리기 전 ISSUE를 생성하고 ISSUE 번호를 PR에 부여합니다.
- default 브랜치는 **절대** 건들지 말고, 오직 PR을 통해 병합한 코드들을 올립니다.
- default 브랜치에 변경사항이 생기면 주기적으로 git pull 또는 git merge를 통해 로컬 툴로 가져옵니다.(충돌 최소화 하기 위함)
  (git checkout [작업중이던 브랜치]) -> 작업중이던 브랜치로 이동
  (git fetch origin) -> 원격저장소(origin)의 최신 정보 가져오기 (다른 사람들의 커밋들을 내 로컬로 복사해옴)
  (git merge origin/develop) -> 가져와 둔 원격 devlop 브랜치의 변경사항을 현재 브랜치에 합치는 명령어
  -> 이후 충돌이 존재하면 충돌 해결 후 하던 작업 진행
  
  **git pull origin develop** 으로 한번에 처리할 수 있지만 여러 변수 발생 가능성이 존재하기 때문에 사용하지 않습니다.
  (무슨 변경이 있는지 보기도 전에 merge를 진행하기 때문에 예상치 못한 충돌 발생 가능성이 있음)
  


- merge는 본인이 하지 않고 2명 이상 Accept를 하면 merge 진행합니다.

---

## 🌱 Branch Rules

- `main`  
  - 배포 및 최종 안정 버전  
  - 직접 커밋 ❌, PR로만 병합  

- `develop`  
  - 기본 개발 브랜치  
  - 모든 기능 브랜치는 develop에서 분기  

- `feature/*`  
  - 새로운 기능 개발  
  - 예: `feature/movie-like`  

- `fix/*`
  - 버그 수정  
  - 예: `fix/login-error`

---

## 🐞 Issue Rules

- 모든 작업은 **Issue 생성 후 진행**합니다.  
- 제목 , 내용 등 간단하게만 작성.


### 사용 라벨
- ✨ FEAT : 기능 추가  
- 🐞 FIX : 버그 수정  
- 🧹 CHORE : 설정/환경 작업  
- 🔨 REFACTOR : 리팩토링  
- 🧪 TEST : 테스트  
- 📄 DOCS : 문서  

---

## 🔀 Pull Request Rules

- PR은 반드시 **Issue와 연결**합니다.  
- 예: `close #12`  

- PR 제목 규칙: [라벨]/제목
