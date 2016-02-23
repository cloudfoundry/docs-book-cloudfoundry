# Application Cloud Documentation

This project publishes the App Cloud documentation as a web application.

This book uses a centralized layout repository, [docs-appcloud-layout](https://github.com/swisscom/docs-layout-repo).
You must clone this repository to run `bookbinder bind local`.

The centralized layout repository is specified as the value of the `layout_repo` key in the `config.yml` file.
Bookbinder uses this centralized layout repository by default, but files in the book's `master_middleman/source` directory override files in the centralized layout repository if they have the same name.

## What's in this Repo

This repo uses the [Bookbindery gem](http://rubygemsearch.org/rubygems/bookbindery) to generate the documentation as a web application.

The `config.yml` file contains the list of topic repositories.

The `master_middleman` folder contains the template used for publishing

This repository does not contain the documentation content. That's contained in the topic repositories listed in the `config.yml`.

## Topic Repositories

The topic repositories that make up the App Cloud documentation set are:

* [Cloud Foundry Concepts](http://github.com/cloudfoundry/docs-cloudfoundry-concepts): a guide to the underlying concepts and architecture.
* [Developer Guide](http://github.com/cloudfoundry/docs-dev-guide): step-by-step instructions and reference material for developers pushing applications to Cloud Foundry.
* [Services](http://github.com/cloudfoundry/docs-services): information about extending Cloud Foundry with custom services, and the service broker API.
* [Buildpacks](http://github.com/cloudfoundry/docs-buildpacks): a guide to developing your own buildpacks.
* [Loggregator](http://github.com/cloudfoundry/docs-loggregator): a guide to the user application logging subsystem of Cloud Foundry.
* [Deploying Cloud Foundry](http://github.com/cloudfoundry/docs-deploying-cf): instructions for operators deploying Cloud Foundry on various IaaS (AWS, OpenStack, etc.) using BOSH
* [Running Cloud Foundry](http://github.com/cloudfoundry/docs-running-cf): information for operators running Cloud Foundry.
* [BOSH](http://github.com/cloudfoundry/docs-bosh): in-depth documentation on BOSH.
* [Administrator Tools](https://github.com/cloudfoundry/docs-cf-admin): documentation about how to operate Cloud Foundry deployments using bosh and cf command line tools.

## Build

### Setup
1. Run `bundle install --binstubs`

### Build
1. Run `bin/bookbinder bind remote`

### Run locally
1. Build the docs
2. Run `cd final_app`
3. Run `rackup`
4. Open your web browser at the specified URL

### Deploy
1. Set environment variables required in respective deployment script (see `deployment` folder)
2. Run `deployment/cf-deploy.dev.sh` or `deployment/cf-deploy.prd.sh`
