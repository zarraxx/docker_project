FROM postgres:9.5

ENV DEBIAN_FRONTEND noninteractive

ENV  PYTHONIOENCODING utf8

ADD stage /stage
RUN chmod 755 /stage/*.bash
RUN /stage/setup.bash
