CC = gcc
CFLAGS = -O0 -std=gnu99 -Wall -fopenmp -mavx
EXECUTABLE = \
	time_test_baseline \
	time_test_openmp_2 \
	time_test_openmp_4 \
	time_test_avx \
	time_test_avxunroll \
	time_test_leibniz \
	time_test_leibniz_avx \
	time_test_nilakantha \
	time_test_nilakantha_avx \
	benchmark_clock_gettime \
	error_rate

GIT_HOOKS := .git/hooks/pre-commit

$(GIT_HOOKS):
	@scripts/install-git-hooks
	@echo

default: $(GIT_HOOKS) $(EXECUTABLE)

benchmark_clock_gettime: computepi.o benchmark_clock_gettime.c
	$(CC) $(CFLAGS) $? -o $@ -lm

error_rate: computepi.o error_rate.c
	$(CC) $(CFLAGS) $? -o $@ -lm

time_test_%: computepi.o time_test.c
	$(CC) $(CFLAGS) $? -D$(shell echo $(subst time_test_,,$@) | tr a-z A-Z) -o $@ -lm

.PHONY: clean default

%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@

check: default
	for method in $(filter-out benchmark_clock_gettime error_rate,$(EXECUTABLE)); do \
		echo "\n"$$method; \
		time ./$$method; \
	done

gencsv: default
	for i in `seq 1000 200 400000`; do \
		printf "%d," $$i; \
		./benchmark_clock_gettime $$i; \
	done > result_clock_gettime.csv	

generrcsv: default
	for i in `seq 1000 200 400000`; do \
		printf "%d," $$i; \
		./error_rate $$i; \
	done > result_error_rate.csv

plot: result_clock_gettime.csv
	gnuplot scripts/runtime.gp

plot_error: result_error_rate.csv
	gnuplot scripts/error_rate.gp

clean:
	rm -f $(EXECUTABLE) *.o *.s result_clock_gettime.csv result_error_rate.csv runtime.png error_rate.png
