#!/bin/bash

# Export pdfs of all HY training presentation slides
# The hy-pdfs/final directory contains the individual presentations' pdfs
# A combined pdf is also created in the hy-pdfs directory

# Exit immediately if a command exits with a non-zero status
set -e

rm -rf hy-pdfs
mkdir -p hy-pdfs/tmp
mkdir -p hy-pdfs/final
cd hy-pdfs

# By default, the slides will be owned by root. The -u 1000:1000 flag is used to change owner to the owner with UID 1000
# which is usually the first user on a linux host, i.e., your user. You can change the uid to something else or use
# your current user's uid $UID if your current user's uid isn't 1000.
docker run --rm --net=host -u 1000:1000 -v `pwd`:/slides astefanutti/decktape --size 930x1558 generic http://localhost:8000/hy.html tmp/00-outline.pdf
docker run --rm --net=host -u 1000:1000 -v `pwd`:/slides astefanutti/decktape http://localhost:8000/gofore-intro tmp/01-gofore-intro.pdf
docker run --rm --net=host -u 1000:1000 -v `pwd`:/slides astefanutti/decktape http://localhost:8000/hy-trainers tmp/02-hy-trainers.pdf
docker run --rm --net=host -u 1000:1000 -v `pwd`:/slides astefanutti/decktape http://localhost:8000/microservices-intro tmp/03-microservices-intro.pdf
docker run --rm --net=host -u 1000:1000 -v `pwd`:/slides astefanutti/decktape http://localhost:8000/modeling-microservices tmp/04-modeling-microservices.pdf
docker run --rm --net=host -u 1000:1000 -v `pwd`:/slides astefanutti/decktape http://localhost:8000/integration tmp/05-integration.pdf
docker run --rm --net=host -u 1000:1000 -v `pwd`:/slides astefanutti/decktape http://localhost:8000/decomposing-monolith tmp/06-decomposing-monolith.pdf
docker run --rm --net=host -u 1000:1000 -v `pwd`:/slides astefanutti/decktape http://localhost:8000/deployment tmp/07-deployment.pdf
docker run --rm --net=host -u 1000:1000 -v `pwd`:/slides astefanutti/decktape http://localhost:8000/testing tmp/08-testing.pdf
docker run --rm --net=host -u 1000:1000 -v `pwd`:/slides astefanutti/decktape http://localhost:8000/best-practices tmp/09-best-practices.pdf
docker run --rm --net=host -u 1000:1000 -v `pwd`:/slides astefanutti/decktape http://localhost:8000/monitoring tmp/10-monitoring.pdf
docker run --rm --net=host -u 1000:1000 -v `pwd`:/slides astefanutti/decktape http://localhost:8000/security tmp/11-security.pdf
docker run --rm --net=host -u 1000:1000 -v `pwd`:/slides astefanutti/decktape http://localhost:8000/scaling-microservices tmp/12-scaling-microservices.pdf
docker run --rm --net=host -u 1000:1000 -v `pwd`:/slides astefanutti/decktape http://localhost:8000/summary tmp/13-summary.pdf

echo "Run the pdfs through Ghostscript"
# To fix issues with missing glyphs when combining the pdfs, run the pdfs one more time through Ghostscript
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=final/00-outline.pdf tmp/00-outline.pdf
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=final/01-gofore-intro.pdf tmp/01-gofore-intro.pdf
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=final/02-hy-trainers.pdf tmp/02-hy-trainers.pdf
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=final/03-microservices-intro.pdf tmp/03-microservices-intro.pdf
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=final/04-modeling-microservices.pdf tmp/04-modeling-microservices.pdf
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=final/05-integration.pdf tmp/05-integration.pdf
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=final/06-decomposing-monolith.pdf tmp/06-decomposing-monolith.pdf
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=final/07-deployment.pdf tmp/07-deployment.pdf
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=final/08-testing.pdf tmp/08-testing.pdf
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=final/09-best-practices.pdf tmp/09-best-practices.pdf
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=final/10-monitoring.pdf tmp/10-monitoring.pdf
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=final/11-security.pdf tmp/11-security.pdf
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=final/12-scaling-microservices.pdf tmp/12-scaling-microservices.pdf
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=final/13-summary.pdf tmp/13-summary.pdf

NOW=`date +%Y-%m-%d-%H-%M`
echo "Combine the pdfs with Ghostscript"
# Combine all pdfs into one using Ghostscript
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=${NOW}-gofore-hy-microservices-training.pdf \
        final/00-outline.pdf \
        final/01-gofore-intro.pdf \
        final/02-hy-trainers.pdf \
        final/03-microservices-intro.pdf \
        final/04-modeling-microservices.pdf \
        final/05-integration.pdf \
        final/06-decomposing-monolith.pdf \
        final/07-deployment.pdf \
        final/08-testing.pdf \
        final/09-best-practices.pdf \
        final/10-monitoring.pdf \
        final/11-security.pdf \
        final/12-scaling-microservices.pdf \
        final/13-summary.pdf
