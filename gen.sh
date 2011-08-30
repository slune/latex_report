#!/bin/bash

echo "
\\documentclass{beamer}
\\usetheme{Warsaw}
%\\usetheme{Malmoe}
\\setbeamertemplate{navigation symbols}{} 

\\usepackage[utf8]{inputenc}
\\usepackage[czech]{babel}

\\usepackage{color, colortbl}

\\title{Web Test Report }
\\subtitle{Draco05 a Draco09}

\\date{\\today}

\\begin{document}

\\transwipe
\\maketitle

\\section{Report}
"

function figure {

  WIDTH="$1"
  HEIGHT="$2"
  PIC_NAME="$3"
  CAP_NAME="$4"
  echo "\\vspace{-20pt}"
  echo "\\begin{figure}[hb]"
  echo "\\includegraphics[width=${WIDTH}mm,height=${HEIGHT}mm]{images/${PIC_NAME}}"
  echo "\\\\ \\Tiny{${CAP_NAME}}"
  echo "\\end{figure}"
}

function table {

  VAL1=$1
  VAL2=$2
  VAL3=$3
  VAL4=$4
  VAL5=$5
  VAL6=$6
  VAL7=$7
  VAL8=$8
  VAL9=$9

  TAB_NAME="${10}"
  COMMENT="${11}"

  echo "\\begin{frame}"
  echo "\\begin{table}[hbtp]"
  echo "\\begin{center}"
  echo "\\begin{tabular}{|c|c|c|c|}"
  echo "\\hline"
  echo "\multicolumn{4}{|>{\columncolor[gray]{.8}}c|}{\\textbf{${TAB_NAME}}} \\\\"
  echo "\\hline"
  echo "\\hline"
  echo "\\rowcolor{green}"
  echo " & \\textbf{Test 2011} & \\textbf{Test 2012} & \\textbf{Difference \%}\\\\"
  echo "\\hline"
  echo "\\textbf{Draco05}       & $VAL1 & $VAL2 & $VAL3 \\\\"
  echo "\\hline"
  echo "\\textbf{Draco09}       & $VAL4 & $VAL5 & $VAL6 \\\\"
  echo "\\hline"
  echo "\\textbf{Difference \%} & $VAL7 & $VAL8 & $VAL9 \\\\"
  echo "\\hline"
  echo "\\end{tabular}"
  echo "${COMMENT}"
  echo "\\end{center}"
  echo "\\end{table}"
  echo "\\end{frame}"
}

echo "\\begin{frame}"
echo "\\begin{table}[hbtp]"
echo "\\begin{center}"
echo "\\begin{tabular}{|c|c|c|}"
echo "\\rowcolor{green}"
echo "\\hline"
echo " & \\tiny{\\textbf{Max ConnectionTimeAndResponseTime}} & \\tiny{\\textbf{Max Total Byte Rate(bits/s)}} \\\\"
echo "\\hline"
echo "\\hline"
echo "\\textbf{Test 2011} & 50 & 900000 \\\\"
echo "\\hline"
echo "\\textbf{Test 2012} & 70 & 3000000 \\\\"
echo "\\hline"
echo "\\textbf{Difference \%} & 40 & 233.33* \\\\"
echo "\\hline"
echo "\\end{tabular}"
echo "comment"
echo "\\end{center}"
echo "\\end{table}"
echo "\\end{frame}"

table X X X X X X X X X "Max connection(access/sec)" "Connection rate per server was doubled."
table X X X X X X X X X "CPU(nice time)" "Processor utilization was 100\% for both tests."
table X X X X X X X X X "Max MySQL connection" 
table X X X X X X X X X "Max Network Traffic(KB/s)" "Traffic was more then doubled."
table X X X X X X X X X "Apache CPU utilization"
table X X X X X X X X X "Apache Memory utilization"

WIDTH=55
HEIGHT=30
for FILE in `ls -1 images/zabbix/*.png`; do
  NAME=`basename $FILE .png | cut -f 2 -d "_"`
  echo "\\begin{frame}"
  echo "\\frametitle{$NAME}"
  echo "\\begin{columns}[t]"
  echo "\\begin{column}[T]{5cm}"
  figure $WIDTH $HEIGHT "zabbix/${NAME}_1.png" "Test"
  figure $WIDTH $HEIGHT "zabbix/${NAME}_2.png" "Test"
  echo "\\end{column}"
  echo "\\begin{column}[T]{5cm}"
  figure $WIDTH $HEIGHT "zabbix/${NAME}_1.png" "Test"
  figure $WIDTH $HEIGHT "zabbix/${NAME}_2.png" "Test"
  echo "\\end{column}"
  echo "\\end{columns}"
  echo "\\end{frame}"
done

WIDTH=80
HEIGHT=30
for FILE in `ls -1 images/test/*.png`; do
  NAME=`basename $FILE .png`
  echo "\\begin{frame}"
  echo "\\frametitle{$NAME}"
  figure $WIDTH $HEIGHT "test1/${NAME}.png" "${NAME} (test)"
  figure $WIDTH $HEIGHT "test2/${NAME}.png" "${NAME} (test)"
  echo "\\end{frame}"
done

echo "\\end{document}"
