#ifndef HAVE_PTHREAD_BARRIER_WAIT
struct gfarm_thr_barrier;
typedef struct gfarm_thr_barrier pthread_barrier_t;
#endif
void gfarm_barrier_init(pthread_barrier_t *, unsigned int,
	const char *, const char *);
void gfarm_barrier_destroy(pthread_barrier_t *, const char *, const char *);
void gfarm_barrier_wait(pthread_barrier_t *, const char *, const char *);
