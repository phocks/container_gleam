# FROM "mcr.microsoft.com/devcontainers/base:noble"
FROM "ghcr.io/gleam-lang/gleam:v1.12.0-erlang"

# Create a new user with a home directory
RUN useradd -m -s /bin/bash gleam

# Optionally grant sudo privileges (if needed)
RUN apt-get update && apt-get install -y sudo
RUN echo "gleam ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the new user
USER gleam

# Set working directory
WORKDIR /home/gleam

CMD ["bash"]