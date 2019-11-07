#include <stdio.h>

typedef struct {
  double utime;
  double stime;
} cpu_time;

#ifdef WIN32
#include <windows.h>
#else
#include <unistd.h>
#include <sys/resource.h>
#include <sys/times.h>
#include <time.h>
#endif

int get_useage_sec(cpu_time *cp)
{
#ifdef WIN32
  FILETIME createTime;
  FILETIME exitTime;
  FILETIME kernelTime;
  FILETIME userTime;
  SYSTEMTIME userSystemTime;
  SYSTEMTIME kernelSystemTime;

  if ( GetProcessTimes( GetCurrentProcess(),
        &createTime, &exitTime, &kernelTime, &userTime) !=  -1 ) {
    if ( FileTimeToSystemTime( &userTime, &userSystemTime ) !=  -1) {
      cp->utime = (double)userSystemTime.wHour * 3600.0 +
        (double)userSystemTime.wMinute * 60 +
        (double)userSystemTime.wSecond +
        (double)userSystemTime.wMilliseconds / 1000.0;
    } else {
      return 0;
    }
    if ( FileTimeToSystemTime( &kernelTime, &kernelSystemTime ) !=  - 1) {
      cp->stime = (double)kernelSystemTime.wHour * 3600.0 +
        (double)kernelSystemTime.wMinute * 60 +
        (double)kernelSystemTime.wSecond +
        (double)kernelSystemTime.wMilliseconds / 1000.0;
    } else {
      return 0;
    }
  } else {
    return 0;
  }
#else
  struct rusage rusage;
  if ( getrusage( RUSAGE_SELF, &rusage ) !=  - 1) {
    cp->utime = (double)rusage.ru_utime.tv_sec +
      (double)rusage.ru_utime.tv_usec / 1000000.0;
    cp->stime = (double)rusage.ru_stime.tv_sec +
      (double)rusage.ru_stime.tv_usec / 1000000.0;
  } else {
    return 0;
  }
#endif
  return 1;
}

int fibonacci(int n);

int main(void)
{
  cpu_time start;
  cpu_time end;

  if ( !get_useage_sec(&start) ) {
    fprintf(stderr, "failed get_useage_sec()\n");
    return 1;
  }

  printf("%d\n", fibonacci(34));

  if ( !get_useage_sec(&end) ) {
    fprintf(stderr, "failed get_useage_sec()\n");
    return 1;
  }

  printf("system  user    total\n");
  printf("%6.4f  %6.4f  %6.4f\n", end.stime - start.stime, end.utime - start.utime, (end.stime - start.stime) + (end.utime - start.utime));

  return 0;
}

int fibonacci(int n){
  if (n < 2) {
    return n;
  } else {
    return fibonacci(n - 2) + fibonacci(n - 1);
  }
}
