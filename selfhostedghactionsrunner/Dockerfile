FROM ubuntu:24.04
ARG USER=mytestghrunner
# Working directory
WORKDIR /app
# As root to install dependencies
USER root:root
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y curl git libsqlite3-dev
# Add the non-root user
RUN useradd -ms /bin/bash ${USER}
RUN chown ${USER}:root /app
RUN chmod -R 775 /app
USER ${USER}:root
# Install GitHub runner
RUN curl -o actions-runner-linux-x64-2.331.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.331.0/actions-runner-linux-x64-2.331.0.tar.gz
RUN echo "5fcc01bd546ba5c3f1291c2803658ebd3cedb3836489eda3be357d41bfcf28a7  actions-runner-linux-x64-2.331.0.tar.gz" | sha256sum -c
RUN tar xzf ./actions-runner-linux-x64-2.331.0.tar.gz
RUN chmod -R 775 /app
USER root:root
RUN ./bin/installdependencies.sh
# Non-root user
USER ${USER}:root
ENV HOME=/app
RUN chmod -R 775 /app
