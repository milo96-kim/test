# 작업 환경

- 현재 프로젝트 운영체제: Windows NT 10.0.26200.0
- 현재 shell/terminal 환경: Windows PowerShell 5.1.26100.8457
- 현재 프로젝트 루트 경로: `C:\Users\sy031_uqioywp\test_codex`
- 사용 가능한 주요 런타임:
  - python: `C:\Users\sy031_uqioywp\AppData\Local\Programs\Python\Python312\python.exe`
  - node: `C:\Program Files\nodejs\node.exe`
  - npm: `C:\Program Files\nodejs\npm.ps1`
  - git: `UNKNOWN`

# 작업 원칙

이 프로젝트에서 Codex는 기본적으로 한국어로 설명, 계획, 보고한다.

1. 현재 프로젝트 스코프 안에서만 작업한다.
2. 프로젝트 내부 파일을 직접 읽고 판단한다.
3. 추정으로 구현하지 않는다.
4. 요구사항이 모호하면 먼저 짧게 확인하고, 확인이 어렵다면 안전한 최소 범위로 작업한다.
5. 필요한 경우 먼저 짧은 계획을 세운 뒤 작업한다.
6. 코드 수정 후 관련 테스트 또는 최소 검증을 수행한다.
7. 테스트를 실행할 수 없으면 그 이유를 명확히 기록한다.
8. 변경 내용과 검증 결과를 마지막에 짧게 요약한다.
9. `.env`, secret, credential, API key, 인증 파일은 출력하거나 수정하지 않는다.
10. 프로젝트 스코프 밖 파일은 읽거나 수정하지 않는다.
11. 삭제, 강제 덮어쓰기, 원격 push 같은 파괴적 작업은 수행하지 않는다.
12. 사용자가 제공한 변수명, 함수명, 파일명은 임의로 바꾸지 않는다.
13. 불필요한 대규모 리팩토링은 하지 않는다.
14. 요청 범위 밖의 기능은 임의로 추가하지 않는다.
