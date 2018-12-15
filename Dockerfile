###################################
# The Zen Garden :: CentOS 7 Base #
#     Build Tag: 181215-126       #
###################################
FROM docker.io/centos:7.6.1810
MAINTAINER Chris Hammer <chris@thezengarden.net>


# Install EPEL:
#####################################
RUN yum install -y epel-release


# Setup Container to use our Local Repo:
# (My Local repos; replace/uncomment if
#  you wish to use custom repos...)
########################################
COPY repos/CentOS-Base.repo /etc/yum.repos.d/
COPY repos/epel.repo /etc/yum.repos.d/


# Update base and install required deps:
########################################
RUN yum clean all \
    && rm -rfv /var/cache/yum \
    && yum update -y \
    && yum install -y net-tools iproute yum-utils bind-utils traceroute telnet rsync man bc bzip2 unzip zip tar file git deltarpm


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
