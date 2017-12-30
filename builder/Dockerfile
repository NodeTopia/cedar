FROM nodetopia/cedar:runner


COPY ./build.sh /build.sh


ARG S3_URL
ARG S3_KEY
ARG S3_SECRET



RUN /bin/herokuish buildpack install

RUN mc --config-folder /tmp config host add s3 $S3_URL $S3_KEY $S3_SECRET
RUN chown -R herokuishuser /app

CMD ["/build.sh"]