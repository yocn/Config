file="config-`date +%F[%T]`.txt"
touch $file
ls > "$file"
mv $file config/
