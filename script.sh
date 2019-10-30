echo "CEWL HOME"
cewl -d 2 -u "Mozilla/5.0 (Windows NT 6.2; WOW64; rv:21.0) Gecko/20130514 Firefox/21.0" -m 5 --with-numbers -e -o -v -w 1.txt https://www.pippo.it/
echo "CEWL FORUM"
cewl -d 2 -u "Mozilla/5.0 (Windows NT 6.2; WOW64; rv:21.0) Gecko/20130514 Firefox/21.0" -m 5 --with-numbers -e -o -v -w 2.txt https://www.pippo.it/forum/

### PUO' ESSERE OPZIONALE ####
echo "JOHN STANDARD WORDLIST PUO ESSERE OPZIONALE"
john --wordlist --stdout >> john.txt
### ###

echo "JOINING WORDLISTS"
cat *.txt >> list.list

echo "FETCHING UNIQUES"
unique -inp=list.list uniques.list

echo "REMOVING TEMPS"
rm *.txt
rm list.list

echo "BUILDING DICTIONARY"
john --wordlist=uniques.list --rules=Jumbo,Extra --stdout >> tmp_dictionary.txt

echo "REMOVING DUPLICATES"
unique -inp=tmp_dictionary.txt dictionary.txt

echo "REMOVING TEMPS"
rm tmp_dictionary.txt
rm uniques.list

echo "GETTING WORDS WITH CORRECT LENGHT (>8)<"
cat dictionary.txt | grep -vwE '\w{1,8}' >> final_dict.txt

echo "############LINES#############"
wc -l final_dict.txt
