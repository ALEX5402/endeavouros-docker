# Use the Arch Linux base image
FROM archlinux:latest

RUN pacman -Syu --noconfirm

# Add EndeavourOS repository to pacman.conf
RUN echo -e "\n[endeavouros]\nSigLevel = PackageRequired\nInclude = /etc/pacman.d/endeavouros-mirrorlist" >> /etc/pacman.conf

# Add EndeavourOS mirrorlist to /etc/pacman.d/endeavouros-mirrorlist
RUN echo -e "######################################################\n\
####                                              ####\n\
###        EndeavourOS Repository Mirrorlist       ###\n\
####                                              ####\n\
######################################################\n\
#### Entry in file /etc/pacman.conf:\n\
###     [endeavouros]\n\
###     SigLevel = PackageRequired\n\
###     Include = /etc/pacman.d/endeavouros-mirrorlist\n\
######################################################\n\
\n\
## Germany\n\
Server = https://mirror.alpix.eu/endeavouros/repo/\$repo/\$arch\n\
Server = https://de.freedif.org/EndeavourOS/repo/\$repo/\$arch\n\
Server = https://mirror.moson.org/endeavouros/repo/\$repo/\$arch\n\
\n\
## Netherlands\n\
Server = https://mirror.erickochen.nl/endeavouros/repo/\$repo/\$arch\n\
\n\
## Sweden\n\
Server = https://ftp.acc.umu.se/mirror/endeavouros/repo/\$repo/\$arch\n\
Server = https://mirror.linux.pizza/endeavouros/repo/\$repo/\$arch\n\
\n\
## Canada\n\
Server = https://ca.gate.endeavouros.com/endeavouros/repo/\$repo/\$arch\n\
\n\
## China\n\
Server = https://mirrors.tuna.tsinghua.edu.cn/endeavouros/repo/\$repo/\$arch\n\
\n\
## Vietnam\n\
Server = https://mirror.freedif.org/EndeavourOS/repo/\$repo/\$arch\n\
\n\
## Github\n\
Server = https://raw.githubusercontent.com/endeavouros-team/repo/master/\$repo/\$arch\n" > /etc/pacman.d/endeavouros-mirrorlist

# Import the EndeavourOS PGP key manually
RUN pacman-key --init && \
    pacman-key --populate archlinux && \
    pacman-key --recv-keys A367FB01AE54040E --keyserver keyserver.ubuntu.com && \
    pacman-key --lsign-key A367FB01AE54040E

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

# Add the EndeavourOS and multilib repositories
RUN echo -e "\n[multilib]\nSigLevel = PackageRequired\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf


# Handle the .pacnew file if it exists
RUN [ -f /etc/pacman.d/endeavouros-mirrorlist.pacnew ] && mv /etc/pacman.d/endeavouros-mirrorlist.pacnew /etc/pacman.d/endeavouros-mirrorlist || true

# Create a dummy /etc/lsb-release file to prevent grep errors
RUN touch /etc/lsb-release

# Update the package database to include the new repositories
RUN pacman -Sy --noconfirm

# Install EndeavourOS specific packages
RUN pacman -S --noconfirm endeavouros-mirrorlist endeavouros-theming eos-hooks

# Set a default command (optional)
CMD ["bash"]
