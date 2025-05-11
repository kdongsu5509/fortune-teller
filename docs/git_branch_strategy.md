## 📌 브랜치 구조 요약

```
feat/* ┐
       ├─→ dev ──┐
hotfix/* ┘       └─→ main
       |
fix/* ─┘ 
```

| 브랜치 | 역할 |
| --- | --- |
| `main` | 운영 배포용 브랜치 |
| `hotfix/*` | 운영 중 긴급 수정 브랜치 |
| `dev` | 기능 통합 및 테스트 브랜치 |
| `feat/*` | 기능 개발 브랜치 |
| `fix/*` | 버그 수정 브랜치 |

---

## Main 브랜치 보호 규칙 (`Main-Branch-Protection`)

- **적용 대상**: `main`
- **강제 적용 여부**: ✅ Active
- **병합 조건**:
  - ✅ Pull Request 필수
  - ✅ 리뷰어 승인 1명 이상
  - ✅ 최신 커밋 기준으로 리뷰 필요
- **허용된 병합 방식**:
  - ✅ Merge
  - ✅ Squash
  - ✅ Rebase
- **보호 옵션**:
  - ✅ Force Push 금지
  - ✅ 브랜치 삭제 금지
- **CI 연동 여부**:
  - ⛔ `Require status checks to pass`: 비활성화

## Default 브랜치 보호 규칙 (`Default-Branch-Protection`)

- **적용 대상**: `dev` `fix` `feat` `hotfix`
- **강제 적용 여부**: ✅ Active
- **병합 조건**:
  - ✅ Pull Request 필수
  - ✅ 리뷰어 승인 1명 이상
  - ✅ 최신 커밋 기준으로 리뷰 필요
- **허용된 병합 방식**:
  - ✅ Merge
  - ✅ Squash
  - ✅ Rebase
- **보호 옵션**:
  - ✅ Force Push 금지
  - ✅ 브랜치 삭제 금지
- **CI 연동 여부**:
  - ⛔ `Require status checks to pass`: 비활성화

---

## 📂 브랜치 네이밍 규칙

| 목적 | 형식 예시 |
| --- | --- |
| 기능 개발 | `feat/login-api` |
| 버그 수정 | `fix/attendance-bug` |
| 긴급 수정 | `hotfix/prod-login-fix` |

## 📋 개발 단위

- 해당 단위는 **GitHub 이슈** 단위로 관리되며, 각 **기능 개발** 또는 **버그 수정** 작업은 **개별 이슈로 생성**해야 합니다.
- 예시:
  - `feat/login-api` : 로그인 API 기능 개발
  - `fix/attendance-bug` : 출석 체크 시스템 버그 수정
  - `hotfix/prod-login-fix` : 운영 환경에서 발생한 로그인 오류 수정

---

## ✅ 브랜치 운영 원칙

- 모든 병합은 **PR(Pull Request)**을 통해 이루어져야 합니다.
- `dev` 브랜치에서 충분히 기능 통합 및 테스트한 후 `main`으로 병합합니다.
- `main` 브랜치는 언제든 **배포 가능한 상태**를 유지해야 합니다.
- 브랜치 삭제 및 강제 푸시는 **차단되어 있으므로** 실수로 인한 손상 가능성은 낮습니다.

---

## 📌 향후 확장 가이드

| 상황 | 대응 전략 |
| --- | --- |
| CI 테스트 연동 완료 | `Require status checks to pass` 활성화 |
| 배포 환경 구성 완료 | `Require deployments to succeed` 추가 고려 |
