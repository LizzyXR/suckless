/* user and group to drop privileges to */
static const char *user  = "nobody";
static const char *group = "nobody";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "{background}",     /* after initialization */
	[INPUT] =  "{foreground}",   /* during input */
	[FAILED] = "{color5}",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;
