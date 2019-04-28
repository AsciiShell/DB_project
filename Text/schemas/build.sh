for entry in `ls ./*/*.dot`
do
  dot -Tpdf $entry -o "${entry%.*}".pdf
done
for entry in `ls ./*.dot`
do
  dot -Tpdf $entry -o "${entry%.*}".pdf
done