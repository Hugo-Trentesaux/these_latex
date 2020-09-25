#!/bin/bash
# Clean and sanitize a list of PDF files
for fullfile in "$@"
do
   filenameext=$(basename "$fullfile") 
   extension="${filenameext##*.}"
   filename="${filenameext%.*}"
   echo fix $filenameext with PDFtk and GS
   pdftk "$filenameext" output "$filename"_tk.pdf&& \
      gs -q -dSAFER -dNOPAUSE -dBATCH -sDEVICE=pdfwrite  -dCompatibilityLevel=1.5  -sOUTPUTFILE="$filename"_C.pdf -f "$filename"_tk.pdf&& \
      /bin/rm -f "$filename"_tk.pdf
      retval=$?
      if [ $retval = 0 ]; then
         echo "   done"
      fi
      ls -l "$filename"*.pdf | awk '{printf("%-6s %-35s\t  %7d\n", " ",$9, $5); }'
done