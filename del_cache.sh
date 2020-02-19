#!/bin/bash
free -m
sudo sync
sudo echo 3 > /proc/sys/vm/drop_caches
free -m


