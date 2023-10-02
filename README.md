# sandbox
a sandbox for testing & exploration

## latest release for GitHub Pages

I created a GitHub Actions workflow to fast-forward the `latest-release` branch whenever a release is published, and configured GitHub Pages to build the website from this branch. So now the website will always contain the content from the latest release (rather than the development version).
I tested this out here before using it for [mikropml](https://github.com/SchlossLab/mikropml).

## automatically build docker containers

whenever files in `docker/<image>/*`, get updated, metadata for the container is retrieved from `docker/<image>/meta.yml` and the container is built with `docker/<image>/Dockerfile`.
