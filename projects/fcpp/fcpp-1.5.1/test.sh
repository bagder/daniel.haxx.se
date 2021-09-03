:

TESTS="1 2 3 4 5"

if [ "" != "$*" ]
then
    TESTS="$*"
fi

for TEST in ${TESTS}
do
    echo "Test ${TEST}"
    
    ./cpp -V -WWW test/test${TEST}.c > /tmp/test${TEST}.pp
    diff /tmp/test${TEST}.pp test/test${TEST}.pp
    
    if [ "0" = "${?}" ]
    then
        echo "!!! PASSED !!!"
    else
        echo "!!! FAILED !!!"
    fi
done
