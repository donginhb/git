################################################################################
#
# pkgconf
#
################################################################################

#自定义从svn下载
PKGCONF_VERSION = head
PKGCONF_SOURCE = pkgconf-0.9.12.tar.bz2
PKGCONF_SITE = http://192.168.154.15/svn/tools/third_party_repository/$(PKGCONF_SOURCE)
PKGCONF_SITE_METHOD = svn

#PKGCONF_VERSION = 0.9.12
#PKGCONF_SITE = https://github.com/pkgconf/pkgconf/releases/download/pkgconf-$(PKGCONF_VERSION)
#PKGCONF_SOURCE = pkgconf-$(PKGCONF_VERSION).tar.bz2
PKGCONF_LICENSE = pkgconf license
PKGCONF_LICENSE_FILES = COPYING

PKG_CONFIG_HOST_BINARY = $(HOST_DIR)/bin/pkg-config

define PKGCONF_LINK_PKGCONFIG
	ln -sf pkgconf $(TARGET_DIR)/usr/bin/pkg-config
endef

define HOST_PKGCONF_INSTALL_WRAPPER
	$(INSTALL) -m 0755 -D package/pkgconf/pkg-config.in \
		$(HOST_DIR)/bin/pkg-config
	$(SED) 's,@STAGING_SUBDIR@,$(STAGING_SUBDIR),g' \
		$(HOST_DIR)/bin/pkg-config
endef

define HOST_PKGCONF_STATIC
	$(SED) 's,@STATIC@,--static,' $(HOST_DIR)/bin/pkg-config
endef

define HOST_PKGCONF_SHARED
	$(SED) 's,@STATIC@,,' $(HOST_DIR)/bin/pkg-config
endef

PKGCONF_POST_INSTALL_TARGET_HOOKS += PKGCONF_LINK_PKGCONFIG
HOST_PKGCONF_POST_INSTALL_HOOKS += HOST_PKGCONF_INSTALL_WRAPPER

ifeq ($(BR2_STATIC_LIBS),y)
HOST_PKGCONF_POST_INSTALL_HOOKS += HOST_PKGCONF_STATIC
else
HOST_PKGCONF_POST_INSTALL_HOOKS += HOST_PKGCONF_SHARED
endif

$(eval $(autotools-package))
$(eval $(host-autotools-package))