# Cloud Foundry Documentation

This project publishes the Cloud Foundry documentation as a web application.

This repository uses the [Bookbindery gem](https://github.com/cloudfoundry/bookbinder) to assemble the documentation from multiple content repositories into a single web application. The `master_middleman` folder contains the layouts, styles, and subnav used to create the web pages.

This repository does not contain the documentation content. Documentation content is contained in the content repositories listed below.

## Content Repositories

The following repositories make up the Cloud Foundry documentation set:

* [Cloud Foundry Concepts](https://github.com/cloudfoundry/docs-cloudfoundry-concepts): Underlying concepts and architecture
* [Cloud Foundry Command-Line Interface (cf CLI)](https://github.com/cloudfoundry/docs-cf-cli): A guide to the cf CLI for Cloud Foundry developers and users
* [Developer Guide](https://github.com/cloudfoundry/docs-dev-guide): Step-by-step instructions and reference material for developers pushing applications to Cloud Foundry
* [Deploying Cloud Foundry](https://github.com/cloudfoundry/docs-deploying-cf): Instructions for operators deploying Cloud Foundry on various IaaS using BOSH
* [Running Cloud Foundry](https://github.com/cloudfoundry/docs-running-cf): Information for operators running Cloud Foundry
* [Administrator Tools](https://github.com/cloudfoundry/docs-cf-admin): Documentation about operating Cloud Foundry deployments using the cf CLI and related tools
* [Services](https://github.com/cloudfoundry/docs-services): Information about extending Cloud Foundry with custom services and the service broker API
* [Buildpacks](https://github.com/cloudfoundry/docs-buildpacks): Guides to using and developing buildpacks
* [Loggregator](https://github.com/cloudfoundry/docs-loggregator): Information about the logging and metrics subsystem of Cloud Foundry
* [User Account and Authentication (UAA)](https://github.com/cloudfoundry/docs-uaa): Information about the Cloud Foundry UAA server
* [CredHub](https://github.com/cloudfoundry/docs-credhub): Information about CredHub credential management
* [BOSH Backup and Restore (BBR)](https://github.com/cloudfoundry/docs-bbr): Documentation for backing up and restoring BOSH deployments

## Branch

All repositories in this doc set use only the `master` branch.

## Template variables

Template variables that customize content across the doc set are defined in [`config/template_variables.yml`](config/template_variables.yml) in this repository. Update that file to change variables that appear in the content repos.

## Contributing Pull Requests

To submit a pull request to the documentation, follow this process:

1. Make sure you have a signed CLA. Even if you aren't contributing running code, we still need a Contributor License Agreement.

1. Fork the content repository you want to contribute to. For example:
   * For docs at `https://docs.cloudfoundry.org/buildpacks/`, the content repository is: https://github.com/cloudfoundry/docs-buildpacks
   * For docs at `https://docs.cloudfoundry.org/devguide/`, the content repository is: https://github.com/cloudfoundry/docs-dev-guide

1. Clone your fork to a directory that is a sibling of this book repository:

    ```
    |
    +-- docs-book-cloudfoundry
    |
    +-- docs-buildpacks
    |
    ```

1. Make your changes.

1. Run bookbinder locally to preview your changes:

    ```
    cd docs-book-cloudfoundry
    bundle install
    bundle exec bookbinder watch
    ```

    Bookbinder assembles the doc set from your local copies and skips any content repositories you do not have checked out. Point your browser at `localhost:4567` to preview your changes. On save, your browser reloads with any additional changes.

1. Commit your changes, rebase from upstream, and push to your fork.

1. Submit a pull request (PR) from your fork to the `master` branch of the content repository.

Only the CFF Docs WG lead can merge pull requests, build to staging, and publish the documentation.

* **Staging site:** https://docs-staging.cloudfoundry.org/
* **Published site:** https://docs.cloudfoundry.org/
