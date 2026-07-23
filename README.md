# CREATON Korea 홈페이지

독일 **CREATON**(www.creaton.de / www.creaton.com) 정품 점토기와의 한국 공식 파트너 홈페이지입니다.
기존 `www.creaton.kr`을 현대적인 구조로 새로 구축하는 프로젝트입니다.

---

## 🧭 프로젝트 방향 (기본 전제)

| 항목 | 결정 |
|------|------|
| 1순위 목표 | **문의 유도 + 시공 레퍼런스** + 독일 130년 브랜드 신뢰 전달 |
| 기술 스택 | **Astro** (정적 사이트) + Markdown 콘텐츠 |
| 콘텐츠 관리 | 개발자/코드 기반 (Markdown 파일 편집) |
| 대상 | 건축주, 시공사, 설계사 |
| 특화 | 모바일 우선 · 네이버/구글 SEO · 원터치 문의(전화/카카오) |

> 위 전제는 초기 가정값입니다. 방향이 다르면 알려주세요.

## 🗂 사이트 구조

```
/                 홈 (히어로 · 브랜드 강점 · 대표제품 · 시공사례 · CTA)
/about            브랜드 소개 (독일 헤리티지 + 한국 파트너)
/products         제품 목록 (카테고리별)
/products/[slug]  제품 상세
/references       시공 사례 목록
/references/[slug] 시공 사례 상세
/downloads        기술자료(카탈로그/시공가이드/규격서 PDF)
/contact          문의 (빠른연락 + 온라인 문의폼)
```

## 🛠 개발

```bash
npm install      # 최초 1회 의존성 설치
npm run dev      # 개발 서버 (http://localhost:4321)
npm run build    # 정적 빌드 → dist/
npm run preview  # 빌드 결과 미리보기
```

## ✍️ 콘텐츠 추가 방법 (코드 몰라도 가능)

- **제품 추가**: `src/content/products/` 에 `.md` 파일 생성
- **시공 사례 추가**: `src/content/references/` 에 `.md` 파일 생성
- 이미지: `public/images/` 에 넣고 front-matter의 `image: /images/파일명.jpg` 로 지정
- 각 파일 상단(`---` 사이)의 항목만 채우면 목록/상세에 자동 반영됩니다.
- **카테고리(메인메뉴)**: `category` 값 = 카테고리명, `categoryOrder` = 노출 순서.
  같은 `category` 값을 쓰면 자동으로 한 그룹으로 묶이고, 헤더 드롭다운·목록에 반영됩니다.
  새 카테고리는 그냥 새 `category` 문자열을 쓰면 생성됩니다.

### 제품 `.md` front-matter 필드
```yaml
title: "FUTURA 푸투라"        # 제품명
category: "낮은 골기와"        # 메인메뉴(카테고리)
categoryOrder: 1              # 카테고리 순서
order: 1                      # 카테고리 내 순서
summary: "한 줄 요약"
image: /images/futura.jpg     # 대표 이미지(선택)
colors:                       # 색상 카드 (이미지 또는 hex 스와치)
  - name: "내추럴 레드"
    hex: "#a83a2a"            # 또는  image: /images/color-red.jpg
specs:                        # 규격표
  - label: "정미치수"
    value: "예: 접시 300×480mm"
gallery:                      # 시공 사진(슬라이드) — 이미지 경로 나열
  - /images/futura-1.jpg
  - /images/futura-2.jpg
```
> 본문(`---` 아래)에 쓰는 글은 **제품 설명** 섹션에 표시됩니다.

## ✅ 실제 오픈 전 교체해야 할 항목 (TODO)

- [ ] 본사 CI(로고 이미지, 정확한 브랜드 컬러/폰트) 반영
- [ ] 실제 제품 정보·색상칩·제품 사진 (`src/content/products/`)
- [ ] 실제 시공 사례 사진·정보 (`src/content/references/`)
- [ ] 회사 정보: 상호/주소/전화/이메일/카카오채널 (Header·Footer·contact)
- [ ] 문의폼 전송 연결 (Formspree/Web3Forms 또는 자체 API) — `contact.astro`
- [ ] 카탈로그/시공가이드 PDF 업로드 (`public/downloads/`) 및 `downloads.astro` 링크
- [ ] 네이버 웹마스터도구 · 구글 서치콘솔 소유확인 값 (`BaseLayout.astro`)
- [ ] OG 공유 이미지 (`public/images/og-default.jpg`)
- [ ] **기존 creaton.kr URL → 신규 URL 301 리다이렉트 매핑** (SEO 유실 방지)
- [ ] 개인정보처리방침 페이지

## 🚀 배포(제안)

- 정적 사이트이므로 **Vercel / Netlify / Cloudflare Pages** 등에 무료·간편 배포 가능
- 배포 후 도메인 `www.creaton.kr` 연결 → 네이버/구글에 사이트맵 제출

## 📌 다음 단계

1. 위 TODO 중 **실제 자료(로고·제품·연락처)** 확보
2. 문의폼 백엔드 연결 + 배포 환경 결정
3. 기존 사이트 URL 조사 → 리다이렉트 매핑
