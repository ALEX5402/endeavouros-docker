# Use the Arch Linux base image
FROM archlinux:latest

RUN pacman -Syu --noconfirm

# Add EndeavourOS
RUN curl -sL https://raw.githubusercontent.com/endeavouros-team/Weekly-ISO-Rebuilds/main/add-EndeavourOS | bash

# Update the package database to include the EndeavourOS repository
RUN pacman -Sy --noconfirm

# Install EndeavourOS keyring and other base packages
RUN pacman -S --noconfirm endeavouros-keyring

# Modify /etc/os-release to reflect EndeavourOS
RUN echo 'NAME="EndeavourOS"' > /etc/os-release && \
    echo 'PRETTY_NAME="EndeavourOS"' >> /etc/os-release && \
    echo 'ID="endeavouros"' >> /etc/os-release && \
    echo 'ID_LIKE="arch"' >> /etc/os-release && \
    echo 'BUILD_ID=rolling' >> /etc/os-release && \
    echo 'ANSI_COLOR="38;2;23;147;209"' >> /etc/os-release && \
    echo 'HOME_URL="https://endeavouros.com"' >> /etc/os-release && \
    echo 'DOCUMENTATION_URL="https://discovery.endeavouros.com"' >> /etc/os-release && \
    echo 'SUPPORT_URL="https://forum.endeavouros.com"' >> /etc/os-release && \
    echo 'BUG_REPORT_URL="https://forum.endeavouros.com/c/general-system/endeavouros-installation"' >> /etc/os-release && \
    echo 'PRIVACY_POLICY_URL="https://endeavouros.com/privacy-policy-2"' >> /etc/os-release && \
    echo 'LOGO="endeavouros"' >> /etc/os-release

# Clean up cached package files to reduce the image size
RUN pacman -Syu --noconfirm

# Create a dummy /etc/lsb-release file to prevent grep errors
RUN touch /etc/lsb-release

# Update the package database to include the new repositories
RUN pacman -Syu --noconfirm

# Install EndeavourOS specific packages
RUN pacman -S --noconfirm endeavouros-mirrorlist endeavouros-theming eos-hooks

# Set a default command (optional)
CMD ["bash"]
