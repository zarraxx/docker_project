#
# DCM4CHEE - Open source picture archive and communications server (PACS)
#
FROM  zarra/dcm4chee_base
MAINTAINER zarra  <xsp@xyan.net.cn>

# Load the stage folder, which contains the setup scripts.
#
ADD stage stage2
RUN chmod 755 stage2/*.bash
RUN cd stage2; ./setup.bash

CMD ["stage/start.bash"]
