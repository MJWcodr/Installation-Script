mkdir ./files2restore || echo "files2restore already exists"

for i in $@; do
	cp -r $i ./files2restore
	echo $i >> files2restore.txt
	echo "$i added to directory"
done
cd ..

tar -cf ./files2archive files2archive.tar.gz
rm ./files2archive
