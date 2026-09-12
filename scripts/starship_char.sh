#!/usr/bin/env bash

BLK=$'\033[0;30m'
R=$'\033[0;31m'
G=$'\033[0;32m'
Y=$'\033[0;33m'
B=$'\033[0;34m'
P=$'\033[0;35m'
W=$'\033[0;37m'
NC=$'\033[0m'

case $(date +%A) in
  Monday)    printf '%s' "${W}月${NC}" ;;
  Tuesday)   printf '%s' "${R}火${NC}" ;;
  Wednesday) printf '%s' "${B}水${NC}" ;;
  Thursday)  printf '%s' "${G}木${NC}" ;;
  Friday)    printf '%s' "${Y}金${NC}" ;;
  Saturday)  printf '%s' "${P}土${NC}" ;;
  Sunday)    printf '%s' "${BLK}日${NC}" ;;
esac
