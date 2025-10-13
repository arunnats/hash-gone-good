# =======================
#  STAGE 1 — Build ProVerif
# =======================
FROM ocaml/opam:debian-13-ocaml-5.4 AS build-ocaml
USER root

# Install system dependencies needed for OCaml compilation
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install OCaml utilities
RUN opam install -y ocamlfind ocamlbuild

# Set environment vars
ENV RES="Docker/res"
ENV PROVERIF_TGZ="proverif-compfun.zip"
ENV PROVERIF_DIR_NAME="proverif"

WORKDIR /opt/build

# Copy source archive
COPY ${RES}/${PROVERIF_TGZ} .

# Unzip source
RUN mkdir ${PROVERIF_DIR_NAME} && \
    unzip ${PROVERIF_TGZ} -d ${PROVERIF_DIR_NAME} && \
    rm ${PROVERIF_TGZ}

# Build ProVerif (non-interactive CLI version) and all associated tools
RUN eval `opam config env` && \
    cd ${PROVERIF_DIR_NAME} && \
    chmod +x build && \
    # CHANGE: Removed "native" to build all binaries
    ./build -nointeract && \
    # DEBUG: Explicitly check that all required files exist and are executable
    test -x proverif && \
    test -x proveriftotex && \
    test -x addexpectedtags && \
    test -x analyze && \
    echo "All binaries built successfully:" && \
    ls -l proverif proveriftotex addexpectedtags analyze

# =======================
#  STAGE 2 — Runtime image
# =======================
FROM debian:trixie

USER root
WORKDIR /opt/proverif

# Install runtime deps and locale
RUN apt-get update && apt-get install -y --no-install-recommends \
    graphviz \
    libgtk2.0-0 \
    locales \
    make \
    m4 \
    && sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen && \
    rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Copy built binaries
COPY --from=build-ocaml /opt/build/proverif/proverif /usr/local/bin/
COPY --from=build-ocaml /opt/build/proverif/proveriftotex /usr/local/bin/
COPY --from=build-ocaml /opt/build/proverif/addexpectedtags /usr/local/bin/
COPY --from=build-ocaml /opt/build/proverif/analyze /usr/local/bin/

# Copy docs/examples to home directory
COPY --from=build-ocaml /opt/build/proverif/examples /root/examples

# Copy case studies to home directory
COPY Proverif-Case-Studies /root/Proverif-Case-Studies

# Add /usr/local/bin to PATH (just to be explicit)
ENV PATH="${PATH}:/usr/local/bin"

# Working directory - start in home directory so files are immediately visible
WORKDIR /root

# Expose nothing (CLI only)
EXPOSE 0

ENTRYPOINT []
CMD ["/bin/bash"]