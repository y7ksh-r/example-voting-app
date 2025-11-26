#!/bin/sh
set -eo pipefail

host="$(hostname -i || echo '127.0.0.1')"

if ping="$(redis-cli -h "$host" -a "StrongRedisPassword123" ping 2>/dev/null)" && [ "$ping" = 'PONG' ]; then
	exit 0
fi

exit 1
