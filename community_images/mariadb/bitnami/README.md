[![Rapidfort](https://assets.website-files.com/6102f7f1589f985b19197b3d/61082629d82d1361e5835b58_rapidfort_logo-new.svg)](https://rapidfort.com) 

[![dh][dh-rf-badge]][rf-dh-image-link]
[![rf-h][rf-h-badge]][rf-link] 
[![image-ft][ft-badge]][ft-badge-link]

# RapidFort hardened image for MariaDB

RapidFort’s container optimization process hardened this MariaDB container. This container is free to use and has no license limitations.

It is the same as the [bitnami/mariadb][source-image-dh-link] image but more secure.

Every day, we optimize and harden a variety of Docker Hub’s most famous images. Check out our [entire library](https://hub.docker.com/u/rapidfort) of secured containers.

[![Metrics][metrics-link]][rf-link]

## Vulnerabilities: Original vs. Hardened

[![CVE Reduction][cve-reduction-link]][rf-link]

## What is MariaDB?

> MariaDB Server is one of the most popular database servers in the world. It’s made by the original developers of MySQL and guaranteed to stay open source. Notable users include Wikipedia, DBS Bank, and ServiceNow.


[Overview of MariaDB](https://www.mariadb.com/)

Trademarks: This software listing is packaged by RapidFort. The respective trademarks mentioned in the offering are owned by the respective companies, and use of them does not imply any affiliation or endorsement.


## How do I use this hardened MariaDB image?

The runtime instructions for this container are no different from the official release. Follow the instructions in their readme, but use our hardened image.

```sh
$ helm repo add bitnami https://charts.bitnami.com/bitnami

# install mariadb, just replace repository with RapidFort registry
$ helm install my-mariadb bitnami/mariadb --set image.repository=rapidfort/mariadb

```

## What is a hardened image?

A hardened image is a copy of a container that has been optimized and reduced for significantly improved security. Because every container uses many open-source software components and their dependencies, there’s a lot of extra weight that can be trimmed.

This image is a hardened version of the official [bitnami/mariadb][source-image-dh-link] image on Docker Hub.

RapidFort is an industry-leading container optimization solution that minimizes software attack surfaces by removing unused code. Most containers can be reduced by at least 50%, which reduces the opportunity for malicious attacks and CVE exploits. Learn more at [RapidFort.com][rf-link].

Our hardened images are updated daily using the latest vulnerability information available.


## What’s the difference between the official [bitnami/mariadb][source-image-dh-link] image and this hardened image?
RapidFort’s hardened [rapidfort/mariadb][rf-dh-image-link] image has been optimized by our proprietary scanning and slimming technology. We are big fans of open-source software, containerized infrastructure, and security.

We are making secure copies of the images we use every day and the most popular ones on Docker Hub. We want to make the world a safer place to operate.

## Supported tags and respective `Dockerfile` links
* [`10.7`, `10.7-debian-10`, `10.7.4`, `10.7.4-debian-10-r2`, `latest` (10.7/debian-10/Dockerfile)](https://github.com/bitnami/bitnami-docker-mariadb/blob/10.7.4-debian-10-r2/10.7/debian-10/Dockerfile)
* [`10.6`, `10.6-debian-10`, `10.6.8`, `10.6.8-debian-10-r2` (10.6/debian-10/Dockerfile)](https://github.com/bitnami/bitnami-docker-mariadb/blob/10.6.8-debian-10-r2/10.6/debian-10/Dockerfile)
* [`10.5`, `10.5-debian-10`, `10.5.16`, `10.5.16-debian-10-r2` (10.5/debian-10/Dockerfile)](https://github.com/bitnami/bitnami-docker-mariadb/blob/10.5.16-debian-10-r2/10.5/debian-10/Dockerfile)
* [`10.4`, `10.4-debian-10`, `10.4.25`, `10.4.25-debian-10-r2` (10.4/debian-10/Dockerfile)](https://github.com/bitnami/bitnami-docker-mariadb/blob/10.4.25-debian-10-r2/10.4/debian-10/Dockerfile)
* [`10.3`, `10.3-debian-10`, `10.3.35`, `10.3.35-debian-10-r2` (10.3/debian-10/Dockerfile)](https://github.com/bitnami/bitnami-docker-mariadb/blob/10.3.35-debian-10-r2/10.3/debian-10/Dockerfile)
* [`10.2`, `10.2-debian-10`, `10.2.44`, `10.2.44-debian-10-r2` (10.2/debian-10/Dockerfile)](https://github.com/bitnami/bitnami-docker-mariadb/blob/10.2.44-debian-10-r2/10.2/debian-10/Dockerfile)

Subscribe to project updates by watching the [rapidfort/community-images GitHub repo](https://github.com/rapidfort/community-images).

## Have questions?
If you'd like to learn more about RapidFort or our container optimization process, visit [RapidFort.com][rf-link].

<br>
<br>


[dh-rf-badge]: https://img.shields.io/badge/dockerhub-images-important.svg?logo=Docker
[rf-link]: https://rapidfort.com 

[rf-h-badge]: https://img.shields.io/static/v1?label=RapidFort&labelColor=333F48&message=hardened&color=50B4C4&logo=[logo]
[logo]: data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACcAAAAkCAYAAAAKNyObAAAACXBIWXMAACE4AAAhOAFFljFgAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAHvSURBVHgB7ZjvTcMwEMUvEgNkhNuAjOAR2IAyQbsB2YAyQbsBYoKwQdjA3aAjHA514Xq1Hf9r6QeeFKVJ3tkv+cWOVYCAiKg124b82gZqe0+NNlsHJbLBxthg1o+RASetIEdTJxnBRvtUMCHgM6TIBtMZwY7SiQFfrhUsN+Ao/TJYR3WC5QY88/Nge6oXLBRwO+P/GcnNMZzZteBR0zQfogM0O4Q47Uz9TtSrUIHs71+paugw16Dn+qt5xJ/TD4viEcrE25tepaXPaHxP350GXtD10WwHQWjQxKhl7YUGRg/MuPaY9vxuzPFA+RpEW9rj0yCMbcCsmG9B+Xpk7YRo4RnjQEEttBiBtAefyI23BtoYpBrmRO6ZX0EZWo60c1yfaGBMOKRzdKVocYZO/NpuMss7E9cHitcc0gFS5Qig2LUUtCGkmmJwOsJJvLlokdWtfMFzAvLGctCOooYPtg2USoRQ7HwM2hXzIzuvKQenIxzHm4oWmZ9TKF1AnAR8sI2moB093nKcjoBvtnHFzoXQ8qeMDGcLtUW/i4NYtJ3jJhRcSnRYHMSg1Q5PD5cWHT4/ih0vIpDOf9QrhZtQLsWxlILT8AjXEol/iQRaiVTBX4pO57D6U0WJBFoFtyaLtuqLfwf19G62e7hFWbQKKuoLYovGDo9dW28AAAAASUVORK5CYII=

[metrics-link]: https://github.com/rapidfort/community-images/raw/main/community_images/mariadb/bitnami/assets/metrics.png
[cve-reduction-link]: https://github.com/rapidfort/community-images/raw/main/community_images/mariadb/bitnami/assets/cve_reduction.png

[source-image-dh-link]: https://hub.docker.com/r/bitnami/mariadb
[rf-dh-image-link]: https://hub.docker.com/r/rapidfort/mariadb

[ft-badge]: https://github.com/rapidfort/community-images/actions/workflows/mariadb_bitnami.yml/badge.svg
[ft-badge-link]: https://github.com/rapidfort/community-images/actions/workflows/mariadb_bitnami.yml
