###################################
# The Zen Garden :: CentOS 7 Base #
#     Build Tag: 180608-1533      #
###################################
FROM docker.io/centos:7.5.1804
MAINTAINER Chris Hammer <chris@thezengarden.net>


# Copy core files required for packages
# and Chef client to function:
#######################################
COPY pkgs/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm /tmp/
COPY pkgs/epel-release-latest-7.noarch.rpm /tmp/


# Install RPM Forge/EPEL:
#####################################
RUN rpm -ivh /tmp/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm \
    && rpm -ivh /tmp/epel-release-latest-7.noarch.rpm


# Setup Container to use our Local Repo:
# (My Local repos; replace/uncomment if
#  you wish to use custom repos...)
########################################
COPY repos/CentOS-Base.repo /etc/yum.repos.d/
COPY repos/epel.repo /etc/yum.repos.d/


# Update base and install required deps:
########################################
RUN yum clean all \
    && yum update -y


# Link timezone to US/Eastern
# (Replace with your local TZ)
#############################
RUN rm /etc/localtime \
    && ln -s /usr/share/zoneinfo/US/Eastern /etc/localtime


# Add root's .bashrc:
#####################
COPY env/root_bashrc /root/.bashrc


# Run quick cleanup to preserve some image size:
################################################
RUN yum clean all


# Default to a BASH shell if no command specified:
##################################################
CMD ["/bin/bash"]
