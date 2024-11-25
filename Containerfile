ARG SOURCE_IMAGE="bluefin"
ARG SOURCE_SUFFIX="-dx-nvidia"
ARG SOURCE_TAG="latest"

FROM ghcr.io/ublue-os/${SOURCE_IMAGE}${SOURCE_SUFFIX}:${SOURCE_TAG}

RUN curl -o /etc/yum.repos.d/fedora-multimedia.repo https://negativo17.org/repos/fedora-multimedia.repo

COPY --from=ghcr.io/ublue-os/akmods-extra:main-41 /rpms/ /tmp/rpms

RUN find /tmp/rpms
RUN rpm-ostree install /tmp/rpms/kmods/kmod-evdi*.rpm

COPY build-files /tmp

COPY usr /usr

RUN mkdir -p /var/lib/alternatives && \
    /tmp/packages.sh && \
    /tmp/fonts.sh && \
    /tmp/customizations.sh && \
    /tmp/suvctl.sh && \
    ostree container commit
