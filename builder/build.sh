#!/bin/bash


echo "-----> Pulling application"
wget $APP_URL -O /tmp/app.tar 2> /dev/null
if [ $? -eq 0 ];then
	echo "       Extracting application"
else
	echo "       Application download fail"
	exit 1
fi


tar -xf /tmp/app.tar -C /app 2> /dev/null
if [ $? -eq 0 ];then
	echo "       Extraction complete"
else
	echo "       Application extraction fail"
	exit 1
fi



echo "-----> Pulling cache"
if wget $CACHE_URL -O /tmp/cache.tar 2> /dev/null ; then
	echo "       Extracting cache"
	tar -xf /tmp/cache.tar -C /tmp 2> /dev/null
	if [ $? -eq 0 ];then
		echo "       Extraction complete"
	else
		echo "       Cache extraction fail"
	fi
	mv /tmp/tmp/cache /tmp 2> /dev/null
else
	echo "       No cache found"
fi

if [ "$BUILDPACK" != "" ]; then
	echo "-----> Downloading buildback"
	echo "       Buildback url: $BUILDPACK"
	/bin/herokuish buildpack install $BUILDPACK 2> /dev/null
	if [ $? -eq 0 ];then
		echo "       Download complete"
	else
		echo "       Buildback download fail"
		exit 1
	fi
fi

/bin/herokuish buildpack build 
if [ $? -eq 0 ];then
	echo "-----> Build complete"
else
	echo "-----> Build fail"
	exit 1
fi

echo "-----> Packing build"
echo "       Compressing build"
tar -cf /tmp/build.tar /app 2> /dev/null
if [ $? -eq 0 ];then
	echo "       Compression complete"
else
	echo "       Compression fail"
	exit 1
fi

echo "       Pushing build"
mc --config-folder /tmp cp --quiet /tmp/build.tar s3/$APP_UPLOAD_PATH > /dev/null
if [ $? -eq 0 ];then
	echo "       Push complete"
else
	echo "       Push fail cannot run without the build"
	exit 1
fi


echo "-----> Packing cache"
echo "       Compressing cache"
tar -cf /tmp/cache.tar /tmp/cache 2> /dev/null
if [ $? -eq 0 ];then
	echo "       Compression complete"
else
	echo "       Compression fail will skip cache next time"
fi

echo "       Pushing cache"
mc --config-folder /tmp cp --quiet /tmp/cache.tar s3/$CACHE_UPLOAD_PATH > /dev/null
if [ $? -eq 0 ];then
	echo "       Push complete"
else
	echo "       Push fail will skip cache next time"
fi

exit 0
