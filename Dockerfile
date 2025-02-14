FROM quay.io/opendatahub/text-generation-inference:fast-836fa5f

USER root

WORKDIR /caikit
COPY caikit /caikit

RUN yum -y install git && yum clean all && \
    pip install pipenv && \
    pipenv install --system && \
    rm -rf ~/.cache && \
    mkdir -p /opt/models && \
    adduser -g 0 -u 1001 caikit --home-dir /caikit && \
    chown -R 1001:0 /caikit /opt/models && \
    chmod -R g=u /caikit /opt/models

USER 1001

ENV RUNTIME_LIBRARY='caikit_nlp' \
    RUNTIME_LOCAL_MODELS_DIR='/opt/models'

CMD [ "./start-serving.sh" ]
