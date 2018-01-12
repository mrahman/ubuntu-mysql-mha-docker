#!/bin/bash
exec ./stop-master.sh
exec ./stop-slaves.sh

exec ./docker-clean.sh

exec ./start-master.sh
exec ./start-slaves.sh

