#!/bin/bash

TARGET=data/test

cd ..
bin/opensfm_run_all $TARGET
bin/opensfm undistort $TARGET
bin/opensfm compute_depthmaps $TARGET

