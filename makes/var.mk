VPATH=$(srcdir)

include $(top_builddir)/makes/config.mk

ja_mandir = $(default_mandir)/ja

# example_bindir = $(default_bindir)/example
example_bindir = $(default_bindir)

metadb_client_includes = $(ldap_includes)
metadb_client_libs = $(ldap_libs)

RM = rm

COMMON_CFLAGS = $(OPTFLAGS) $(largefile_cflags) \
	-I$(top_builddir)/include -I$(top_srcdir)/include
COMMON_LDFLAGS = $(largefile_ldflags)
GFARMLIB = -L$(top_builddir)/lib/libgfarm -lgfarm \
	$(metadb_client_libs) $(globus_gssapi_libs) $(openssl_libs)

INC_SRCDIR = $(top_srcdir)/include/gfarm
INC_BUILDDIR = $(top_builddir)/include/gfarm
DEPGFARMLIB = $(top_builddir)/lib/libgfarm/libgfarm.a
DEPGFARMINC = $(INC_BUILDDIR)/gfarm_config.h $(INC_SRCDIR)/gfarm.h $(INC_SRCDIR)/gfarm_error.h $(INC_SRCDIR)/gfarm_metadb.h $(INC_SRCDIR)/gfarm_misc.h $(INC_SRCDIR)/gfarm_stringlist.h $(INC_SRCDIR)/gfs.h $(INC_SRCDIR)/gfs_glob.h

# ns

NS_COMMON_CFLAGS = $(OPTFLAGS) $(largefile_cflags) \
	-I$(top_builddir)/include \
	-I$(top_builddir)/ns/include -I$(top_srcdir)/ns/include
NSLIB = -L$(top_builddir)/ns/nslib -lns
NSEXECLIB = -L$(top_builddir)/ns/nslib -lnsexec

NSINC_SRCDIR = $(top_srcdir)/ns/include/gfarm
NSINC_BUILDDIR = $(top_builddir)/ns/include/gfarm
GFD_SRCDIR = $(top_srcdir)/ns/gfarmd
DEPNSLIB = $(top_builddir)/ns/nslib/libns.a
DEPNSEXECLIB = $(top_builddir)/ns/nslib/libnsexec.a

# gfsl

GFSL_SRCDIR = $(top_srcdir)/lib/libgfarm/gfsl
DEPGFSLINC = $(GFSL_SRCDIR)/gfarm_auth.h $(GFSL_SRCDIR)/gfarm_gsi.h $(GFSL_SRCDIR)/gfarm_secure_session.h

# libgfarm internal interface

GFUTIL_SRCDIR = $(top_srcdir)/lib/libgfarm/gfutil
GFARMLIB_SRCDIR = $(top_srcdir)/lib/libgfarm/gfarm

# doc & man

DOCBOOK2MAN = jw -b man
DOCBOOK2HTML = jw -b html -u
srcsubst = dummy
dstsubst = dummy
