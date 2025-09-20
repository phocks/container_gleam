# FROM "mcr.microsoft.com/devcontainers/base:noble"
FROM "ghcr.io/gleam-lang/gleam:v1.12.0-erlang"

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y sudo && \
    rm -rf /var/lib/apt/lists/*

# Create a new user with a home directory
RUN useradd -m -s /bin/bash gleam

# Grant sudo privileges
RUN echo "gleam ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the new user
USER gleam

# Set working directory
WORKDIR /home/gleam

CMD ["bash"]