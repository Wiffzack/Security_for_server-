echo "First Parameter path to the files"

FILES=$1
if [ -z "$FILES" ]; then
        echo "No Input"
        exit 1
fi

prefix=$FILES
cd $FILES
for d in */ ; do
        cd $FILES/$d
        for f in *.*
        do
                if [[ $f == *.js ]];then
                        path=$(realpath $f)
                        string=${path/#$prefix}
                        sha256=$(openssl dgst -sha256 -binary $f | openssl base64 -A)
                        echo '<script src="'$string'" integrity="sha256-'$sha256'" crossorigin="anonymous"></script>'
                fi
        done
done
