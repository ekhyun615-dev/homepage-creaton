# 카페24 웹호스팅 배포 가이드

CREATON Korea 홈페이지는 **정적 사이트**입니다. 서버에 Node.js·PHP·DB가 필요 없고,
빌드 결과물(`dist/` 폴더 안의 파일들)을 웹 루트에 그대로 올리기만 하면 됩니다.

---

## 1. 빌드하기

수정 사항이 있을 때마다 아래를 실행합니다.

```bash
npm run build
```

→ `dist/` 폴더에 업로드할 파일이 생성됩니다.

압축본이 필요하면:

```bash
npm run zip
```

→ `creaton-korea-deploy.zip` 생성

---

## 2. 업로드하기

### 방법 A — 카페24 파일매니저 (간편)

1. 카페24 호스팅 관리 → **파일매니저** 접속
2. 웹 루트 폴더(보통 **`/www`**)로 이동
3. `creaton-korea-deploy.zip` 업로드
4. 업로드한 zip을 **압축 해제**
5. zip 파일은 삭제

### 방법 B — FTP (FileZilla 등)

1. 카페24에서 발급받은 FTP 주소 / 아이디 / 비밀번호로 접속
2. 웹 루트 폴더(보통 **`/www`**)로 이동
3. **`dist/` 폴더 "안의 내용물"을** 전부 업로드
   - ⚠️ `dist` 폴더 자체를 올리면 안 됩니다. 안의 파일들을 올려야 합니다.
   - 올바름: `/www/index.html`
   - 잘못됨: `/www/dist/index.html`

> ### ⚠️ `.htaccess` 누락 주의 (가장 흔한 실수)
> `.htaccess`는 점(.)으로 시작하는 **숨김 파일**이라 FTP 프로그램에서 안 보일 수 있습니다.
> FileZilla 기준: **서버 → 강제로 숨김 파일 보이기** 를 켜고 업로드하세요.
> 이 파일이 없으면 404 페이지·캐시·주소 정리가 동작하지 않습니다.

---

## 3. 업로드 후 확인

- `http://도메인/` — 메인 페이지
- `http://도메인/products` — 상세 페이지 (주소 정리 동작 확인)
- `http://도메인/없는주소` — 404 페이지가 뜨는지 확인
- 이미지·로고가 모두 보이는지 확인

---

## 4. SSL(HTTPS) 설정 — 꼭 하세요

브라우저에 **"안전하지 않음"** 경고가 뜨면 검색 노출과 신뢰도에 직접적인 악영향이 있으니 반드시 적용하세요.

1. 카페24 호스팅 관리에서 **SSL 인증서 신청/적용**
2. 적용 완료 후 `.htaccess` 파일을 열어 아래 3줄의 `#` 을 제거 (HTTPS 자동 전환)

```apache
RewriteCond %{HTTPS} !=on
RewriteCond %{HTTP:X-Forwarded-Proto} !https
RewriteRule ^(.*)$ https://%{HTTP_HOST}/$1 [R=301,L]
```

3. `www` 통일이 필요하면 그 아래 2줄의 `#` 도 제거

---

## 5. 배포 전 남은 설정

| 항목 | 위치 | 현재 상태 |
|---|---|---|
| 문의 폼 수신 | `src/pages/contact.astro` | `info@alcmate.com` (FormSubmit) |
| 사이트 주소 | `astro.config.mjs` → `site` | `https://www.creaton.kr` |
| 카카오톡 채널 URL | README TODO 참고 | 미설정 |

> **문의 폼 최초 1회 인증 필요**: 사이트 공개 후 테스트로 상담 신청을 한 번 제출하면
> `info@alcmate.com` 으로 확인 메일이 옵니다. 그 링크를 클릭해야 이후 접수가 정상 수신됩니다.

> **테스트 도메인 사용 시**: 카페24 임시 주소(`***.cafe24.com`)로 먼저 테스트한다면
> `astro.config.mjs` 의 `site` 를 그 주소로 바꾼 뒤 다시 빌드하세요.
> (sitemap·canonical 주소가 정확해집니다.) 실도메인 연결 시 원래대로 되돌립니다.

---

## 6. 콘텐츠 수정 방법

- **제품 추가/수정**: `src/content/products/` 의 `.md` 파일
- **시공 사례 추가/수정**: `src/content/references/` 의 `.md` 파일
- 이미지는 `public/images/` 에 넣고 front-matter의 `image:` 경로로 지정

수정 후에는 반드시 `npm run build` → 재업로드 (또는 `npm run zip` 으로 압축본 생성 후 업로드).
