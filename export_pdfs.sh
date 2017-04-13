#!/bin/bash

# Export pdfs of all presentation slides
# The pdfs/final directory contains the individual presentations' pdfs
# A combined pdf is also created in the pdfs directory

# Exit immediately if a command exits with a non-zero status
set -e

rm -rf pdfs
mkdir -p pdfs/tmp
mkdir -p pdfs/final
cd pdfs

# By default, the slides will be owned by root. The -u 1000:1000 flag is used to change owner to the owner with UID 1000
# which is usually the first user on a linux host, i.e., your user. You can change the uid to something else or use
# your current user's uid $UID if your current user's uid isn't 1000.
# Specify the width and height of the outline page explicitly
docker run --rm --net=host -u 1000:1000 -v `pwd`:/slides astefanutti/decktape --size 930x2433 generic http://localhost:8000 tmp/00-outline.pdf
docker run --rm --net=host -u 1000:1000 -v `pwd`:/slides astefanutti/decktape http://localhost:8000/microservices-intro tmp/01-microservices-intro.pdf
docker run --rm --net=host -u 1000:1000 -v `pwd`:/slides astefanutti/decktape http://localhost:8000/modeling-microservices tmp/02-modeling-microservices.pdf
docker run --rm --net=host -u 1000:1000 -v `pwd`:/slides astefanutti/decktape http://localhost:8000/integration tmp/03-integration.pdf
docker run --rm --net=host -u 1000:1000 -v `pwd`:/slides astefanutti/decktape http://localhost:8000/decomposing-monolith tmp/04-decomposing-monolith.pdf
docker run --rm --net=host -u 1000:1000 -v `pwd`:/slides astefanutti/decktape http://localhost:8000/deployment tmp/05-deployment.pdf
docker run --rm --net=host -u 1000:1000 -v `pwd`:/slides astefanutti/decktape http://localhost:8000/testing tmp/06-testing.pdf
docker run --rm --net=host -u 1000:1000 -v `pwd`:/slides astefanutti/decktape http://localhost:8000/monitoring tmp/07-monitoring.pdf
docker run --rm --net=host -u 1000:1000 -v `pwd`:/slides astefanutti/decktape http://localhost:8000/security tmp/08-security.pdf
docker run --rm --net=host -u 1000:1000 -v `pwd`:/slides astefanutti/decktape http://localhost:8000/scaling-microservices tmp/09-scaling-microservices.pdf
docker run --rm --net=host -u 1000:1000 -v `pwd`:/slides astefanutti/decktape http://localhost:8000/best-practices tmp/10-best-practices.pdf
docker run --rm --net=host -u 1000:1000 -v `pwd`:/slides astefanutti/decktape http://localhost:8000/summary tmp/11-summary.pdf

echo "Run the pdfs through Ghostscript"
# To fix issues with missing glyphs when combining the pdfs, run the pdfs one more time through Ghostscript
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=final/00-outline.pdf tmp/00-outline.pdf
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=final/01-microservices-intro.pdf tmp/01-microservices-intro.pdf
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=final/02-modeling-microservices.pdf tmp/02-modeling-microservices.pdf
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=final/03-integration.pdf tmp/03-integration.pdf
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=final/04-decomposing-monolith.pdf tmp/04-decomposing-monolith.pdf
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=final/05-deployment.pdf tmp/05-deployment.pdf
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=final/06-testing.pdf tmp/06-testing.pdf
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=final/07-monitoring.pdf tmp/07-monitoring.pdf
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=final/08-security.pdf tmp/08-security.pdf
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=final/09-scaling-microservices.pdf tmp/09-scaling-microservices.pdf
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=final/10-best-practices.pdf tmp/10-best-practices.pdf
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=final/11-summary.pdf tmp/11-summary.pdf

NOW=`date +%Y-%m-%d-%H-%M`
echo "Combine the pdfs with Ghostscript"
# Combine all pdfs into one using Ghostscript
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=${NOW}-gofore-microservices-training.pdf \
        final/00-outline.pdf \
        final/01-microservices-intro.pdf \
        final/02-modeling-microservices.pdf \
        final/03-integration.pdf \
        final/04-decomposing-monolith.pdf \
        final/05-deployment.pdf \
        final/06-testing.pdf \
        final/07-monitoring.pdf \
        final/08-security.pdf \
        final/09-scaling-microservices.pdf \
        final/10-best-practices.pdf \
        final/11-summary.pdf
