FROM docker.io/centos:7.2.1511
MAINTAINER Chris Hammer <chris@thezengarden.net>


# Copy core files required for packages
# and Chef client to function:
#######################################
COPY pkgs/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm /tmp/
COPY pkgs/epel-release-latest-7.noarch.rpm /tmp/


# Install RPM Forge/EPEL/Chef Client:
#####################################
RUN rpm -ivh /tmp/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm \
    && rpm -ivh /tmp/epel-release-latest-7.noarch.rpm


# Setup Container to use our Local Repo:
########################################
COPY repos/CentOS-Base.repo /etc/yum.repos.d/
COPY repos/epel.repo /etc/yum.repos.d/


# Update base and install required deps:
########################################
RUN yum update -y


# Link timezone to US/Eastern
#############################
RUN rm /etc/localtime \
    && ln -s /usr/share/zoneinfo/US/Eastern /etc/localtime


# Add root's .bashrc:
#####################
COPY env/root_bashrc /root/.bashrc

