/*
 * $Id$
 */
#include <assert.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

#include <gfarm/gfarm.h>

#include "gfutil.h"

#include "context.h"
#include "liberror.h"
#include "auth.h"
#include "gfpath.h"
#define GFARM_USE_STDIO
#include "config.h"
#include "config_openssl.h"

/* the following function is for server. */
gfarm_error_t
gfarm_server_config_read(void)
{
	gfarm_error_t e;
	int lineno;
	FILE *config;
	char *config_file = gfarm_config_get_filename();

	if ((config = fopen(config_file, "r")) == NULL) {
		gflog_debug(GFARM_MSG_1000976,
			"open operation on server config file (%s) failed",
			config_file);
		return (GFARM_ERRMSG_CANNOT_OPEN_CONFIG);
	}
	e = gfarm_config_read_file(config, &lineno, config_file);
	if (e != GFARM_ERR_NO_ERROR) {
		gflog_error(GFARM_MSG_1000014, "%s: line %d: %s",
		    config_file, lineno, gfarm_error_string(e));
		return (e);
	}

	gfarm_config_set_default_ports();
	gfarm_config_set_default_misc();

	return (GFARM_ERR_NO_ERROR);
}

/* the following function is for server. */
gfarm_error_t
gfarm_server_initialize(char *config_file, int *argcp, char ***argvp)
{
	gfarm_error_t e;

	if ((e = gfarm_context_init()) != GFARM_ERR_NO_ERROR) {
		gflog_debug(GFARM_MSG_1003865,
			"gfarm_context_init failed: %s",
			gfarm_error_string(e));
		return (e);
	}
	gfarm_openssl_initialize();
	gflog_initialize();
	if (argvp)
		gfarm_config_set_argv0(**argvp);

	if (config_file != NULL)
		gfarm_config_set_filename(config_file);
	e = gfarm_server_config_read();
	if (e != GFARM_ERR_NO_ERROR) {
		gflog_debug(GFARM_MSG_1000977,
			"gfarm_server_config_read() failed: %s",
			gfarm_error_string(e));
		return (e);
	}

	gfarm_setup_debug_command();

	return (GFARM_ERR_NO_ERROR);
}

/* the following function is for server. */
gfarm_error_t
gfarm_server_terminate(void)
{
	/* nothing to do (and also may never be called) */
	gflog_terminate();
	gfarm_context_term();

	return (GFARM_ERR_NO_ERROR);
}
