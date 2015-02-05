#!/bin/sh
#
# this assumes a fresh start each time.
# If we were to locally tag the oracle container to form a new impexed image then it could be used instead as a starting point without requiring the impex process to run (it would save time).

# this will run in the background
echo "docker run --name oracle -d -t wnameless/oracle-xe-11g"
docker run --name oracle -d -t wnameless/oracle-xe-11g

# this will run interactively which will block the script from starting
# the application until impex is done.

echo "docker run -i -t --link oracle:db kualistudent/bundled-impex:build-917"
docker run -i -t --link oracle:db kualistudent/bundled-impex:build-917

# this will start the application in the background
#
echo "docker run -d -t --name ks-with-rice-bundled --link oracle:db kualistudent/bundled-app:build-917"
docker run -d -t --name ks-with-rice-bundled --link oracle:db kualistudent/bundled-app:build-917

echo "View the logs using: docker logs -f ks-with-rice-bundled"

