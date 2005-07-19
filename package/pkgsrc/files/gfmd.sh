#!@RCD_SCRIPTS_SHELL@
#
# $NetBSD$
#
# Gfarm filesystem node daemon
#
# PROVIDE: gfmd
# REQUIRE: DAEMON

if [ -f /etc/rc.subr ]; then
	. /etc/rc.subr
fi

name="gfmd"
rcvar=${name}
command="@PREFIX@/sbin/${name}"
required_files="@PKG_SYSCONFDIR@/gfarm.conf"
# add more flags through ${${name}_flags}
command_args="-f ${required_files} -P @GFARM_PID_DIR@/${name}.pid"

if [ -f /etc/rc.subr ]; then
	load_rc_config $name
	run_rc_command "$1"
else
	@ECHO@ -n " ${name}"
	${command} ${gfmd_flags} ${command_args}
fi
