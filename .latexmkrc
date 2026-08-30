# latexmk 설정: 모든 빌드 산출물을 build/ 아래로
$pdf_mode    = 1;          # pdflatex 사용
$out_dir     = 'build';    # .pdf, .aux, .log 등 산출물 위치
$aux_dir     = 'build';    # 보조 파일도 build/ 로
$bibtex_use  = 2;          # references.bib 자동 처리
$ENV{'BIBINPUTS'} = '../:../../:' . ($ENV{'BIBINPUTS'} || ''); # kieee/references.bib 우선, latex/references.bib 공유
$pdflatex    = 'pdflatex -interaction=nonstopmode -halt-on-error -file-line-error %O %S';
$clean_ext   = 'aux bbl blg fdb_latexmk fls log out synctex.gz';
