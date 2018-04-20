(define-skeleton latex-skeleton
  "LaTeX Template"
  nil
  "\\documentclass[a4paper]{"
  (skeleton-read "documentclass: ") | "amsart" "}"\n
  \n
  "\\usepackage[utf8]{inputenc}" \n
  "\\usepackage{listings}" \n
  "\\usepackage{datetime}" \n
  ;;("package: " "\\usepackage{" str "}" \n)
  \n
  "\\newdateformat{monthyeardate}{" \n
  > "\\monthname[\\THEMONTH], \\THEYEAR}" \n
  \n
  "\\title{" (skeleton-read "title: ") | "" "}" \n
  "\\author{Andrés Felipe Ortega Montoya\\\\" \n
  > "\\monthyeardate{\\today}}" \n
  \n
  "\\begin{document}" \n
  "\\maketitle" \n
  _ \n
  "\\end{document}")
