# Application Cloud Documentation

This project publishes the App Cloud documentation as a web application.

These docs can be reached at <https://docs.developer.swisscom.com>

## What's in this Repo

This repo uses the [Bookbindery gem](http://rubygemsearch.org/rubygems/bookbindery) to generate the documentation as a web application.

The `config.yml` file contains the list of topic repositories.

The `master_middleman` folder contains the template used for publishing

This repository does not contain the documentation content. That's contained in the topic repositories listed in the `config.yml`.

## Topic Repositories

The topic repositories that make up the App Cloud documentation set are:

* [Cloud Foundry Concepts](https://github.com/cloudfoundry/docs-cloudfoundry-concepts): a guide to the underlying concepts and architecture.
* [Developer Guide](https://github.com/cloudfoundry/docs-dev-guide): step-by-step instructions and reference material for developers pushing applications to Cloud Foundry.
* [CF CLI](https://github.com/cloudfoundry/docs-cf-cli): a guide to using the Cloud Foundry CLI.
* [Administrator Tools](https://github.com/cloudfoundry/docs-cf-admin): documentation about how to operate Cloud Foundry deployments using bosh and cf command line tools.
* [Services](https://github.com/cloudfoundry/docs-services): information about extending Cloud Foundry with custom services, and the service broker API.
* [Running Cloud Foundry](https://github.com/cloudfoundry/docs-running-cf): information for operators running Cloud Foundry.
* [Buildpacks](https://github.com/cloudfoundry/docs-buildpacks): a guide to developing your own buildpacks.
* [Getting Started](https://github.com/swisscom/docs-appcloud-getting-started): a guide for new users on how to get started with the App Cloud
* [Web Console](https://github.com/swisscom/docs-appcloud-console): a guide about using the web console on [https://developer.swisscom.com](https://developer.swisscom.com)
* [Apps](https://github.com/swisscom/docs-appcloud-apps): a guide about apps
* [Service Offerings](https://github.com/swisscom/docs-appcloud-service-offerings): a list of the different service offerings of Swisscom
* [Billing](https://github.com/swisscom/docs-appcloud-billing): shows how billing in the app cloud works and makes it more transparent for users
* [API](https://github.com/swisscom/docs-api): a guide on how to use the Swisscom APIs

## Build

### Setup

1. Run `bundle install`

### Bind

1. Run `bundle exec bookbinder bind remote`

### Run locally

1. Build the docs
1. Run `cd final_app`
1. Run `rackup`
1. Open your web browser at the specified URL

### Deploy

1. Set environment variables required in respective deployment script (see `ci/scripts` folder)
1. Run `ci/scripts/cf-deploy.dev.sh` or `ci/scripts/cf-deploy.prd.sh`
