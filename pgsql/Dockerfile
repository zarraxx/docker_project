FROM postgres:9.5

ENV DEBIAN_FRONTEND noninteractive

ADD stage /stage
RUN chmod 755 /stage/*.bash
RUN /stage/setup.bash
