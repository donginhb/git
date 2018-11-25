################################################################################
#
# fakeroot
#
################################################################################

#自定义从svn下载
FAKEROOT_VERSION = head
FAKEROOT_SOURCE = fakeroot_1.20.2.orig.tar.bz2
FAKEROOT_SITE = http://192.168.154.15/svn/tools/third_party_repository/$(FAKEROOT_SOURCE)
FAKEROOT_SITE_METHOD = svn

#FAKEROOT_VERSION = 1.20.2
#FAKEROOT_SOURCE = fakeroot_$(FAKEROOT_VERSION).orig.tar.bz2
#FAKEROOT_SITE = http://snapshot.debian.org/archive/debian/20141005T221953Z/pool/main/f/fakeroot

HOST_FAKEROOT_DEPENDENCIES = host-acl
# Force capabilities detection off
# For now these are process capabilities (faked) rather than file
# so they're of no real use
HOST_FAKEROOT_CONF_ENV = \
	ac_cv_header_sys_capability_h=no \
	ac_cv_func_capset=no

FAKEROOT_LICENSE = GPL-3.0+
FAKEROOT_LICENSE_FILES = COPYING

$(eval $(host-autotools-package))