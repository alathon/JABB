#!/bin/sh
TARGET=$(notdir $(basename $(CURDIR)))
VERSION=0.1
FULLNAME=$(TARGET)-$(VERSION)
PORT=5555
LOG=logs/$(FULLNAME).log
DMB=$(FULLNAME).dmb
