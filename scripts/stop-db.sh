#!/bin/bash
exec ./stop-master.sh
exec ./stop-slaves.sh

exec ./docker-clean.sh
