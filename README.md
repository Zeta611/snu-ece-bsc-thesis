# snu-ece-bsc-thesis 클래스

snu-ece-bsc-thesis 클래스는 서울대학교 전기정보공학부 학사학위논문 양식을 LaTeX으로 작성하기 위한 클래스입니다.

`ko` 및 `en` 옵션으로 한국어와 영어 논문을 둘 다 지원합니다.

## 사용법

**XeLaTeX 혹은 LuaLaTeX**을 사용해야 합니다.
pdfLaTeX은 지원하지 않습니다.[^1]

[^1]: XeLaTeX 및 LuaLaTeX은 (pdfLaTeX과 달리) 기본적으로 유니코드 인코딩을 지원하고, OTF 및 TTF 폰트를 사용할 수 있습니다. 더 자세한 정보는 [여기](https://tex.stackexchange.com/a/72/97583)를 참고하세요.

### 예시

XeLaTeX을 사용할 경우 아래와 같이 조판할 수 있습니다.
Biber를 통해 참고문헌을 처리하고, XeLaTeX을 두 번 더 실행하여 참조를 처리합니다.[^2]

[^2]: [Overleaf](https://www.overleaf.com/)를 사용하는 경우 이 과정을 자동으로 처리하는 것 같습니다. 이외에도 [Tectonic](https://tectonic-typesetting.github.io/), [Latexmk](https://mg.readthedocs.io/latexmk.html) 등을 사용하여 자동화할 수 있습니다.

```sh
xelatex example-ko
biber example-ko
xelatex example-ko
xelatex example-ko
```

[example-ko.tex](example/example-ko.tex) 파일과 [example-en.tex](example/example-en.tex) 파일을 참고하세요.

## 저자

* 이재호 [jaeho.lee@snu.ac.kr](jaeho.lee@snu.ac.kr)

## 라이선스

snu-ece-bsc-thesis 클래스는 MIT 라이선스를 따릅니다.
[LICENSE](LICENSE) 파일을 참고하세요.
