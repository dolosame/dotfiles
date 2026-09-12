#!/usr/bin/env bash

BLK=$'\033[0;30m'
R=$'\033[0;31m'
G=$'\033[0;32m'
Y=$'\033[0;33m'
B=$'\033[0;34m'
P=$'\033[0;35m'
W=$'\033[0;37m'
NC=$'\033[0m'

case "$(printf '%(%u)T' -1)" in
  1)  printf '%s' "${W}月${NC}" ;;
  2)  printf '%s' "${R}火${NC}" ;;
  3)  printf '%s' "${B}水${NC}" ;;
  4)  printf '%s' "${G}木${NC}" ;;
  5)  printf '%s' "${Y}金${NC}" ;;
  6)  printf '%s' "${P}土${NC}" ;;
  7)  printf '%s' "${BLK}日${NC}" ;;
esac
