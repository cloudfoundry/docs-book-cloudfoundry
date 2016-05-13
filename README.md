# Cloud Foundry Documentation

This project publishes the Cloud Foundry documentation as a web application.

**Breaking Change**: This book now uses a centralized layout repository, [docs-layout-repo](https://github.com/pivotal-cf/docs-layout-repo).  
You must clone this repository to run `bookbinder bind local`.

The centralized layout repository is specified as the value of the `layout_repo` key in the `config.yml` file. 
Bookbinder uses this centralized layout repository by default, but files in the book's `master_middleman/source` directory override files in the centralized layout repository if they have the same name.

## What's in this Repo

This repo uses the [Bookbinder gem](http://github.com/pivotal-cf/docs-bookbinder) to generate the documentation as a web application.

The config.yml file contains the list of topic repositories.

The master_middleman folder contains the template used for publishing

This repository does not contain the documentation content. That's contained in the topic repositories listed in the config.yml.

## Topic Repositories

The topic repositories that make up the Cloud Foundry documentation set are:

* [Cloud Foundry Concepts](http://github.com/cloudfoundry/docs-cloudfoundry-concepts): a guide to the underlying concepts and architecture.
* [Developer Guide](http://github.com/cloudfoundry/docs-dev-guide): step-by-step instructions and reference material for developers pushing applications to Cloud Foundry.
* [Services](http://github.com/cloudfoundry/docs-services): information about extending Cloud Foundry with custom services, and the service broker API.
* [Buildpacks](http://github.com/cloudfoundry/docs-buildpacks): a guide to developing your own buildpacks.
* [Loggregator](http://github.com/cloudfoundry/docs-loggregator): a guide to the user application logging subsystem of Cloud Foundry.
* [Deploying Cloud Foundry](http://github.com/cloudfoundry/docs-deploying-cf): instructions for operators deploying Cloud Foundry on various IaaS (AWS, OpenStack, etc.) using BOSH
* [Running Cloud Foundry](http://github.com/cloudfoundry/docs-running-cf): information for operators running Cloud Foundry.
* [BOSH](http://github.com/cloudfoundry/docs-bosh): in-depth documentation on BOSH.
* [Administrator Tools](https://github.com/cloudfoundry/docs-cf-admin): documentation about how to operate Cloud Foundry deployments using bosh and cf command line tools.

## Contributing Pull Requests

To submit a pull request to the documentation, please follow this process:

1. Make sure you have a signed CLA. Even if you aren't contributing running code, we still need a Contributor License Agreement.


1. Fork the content repository you want to make a contribution to. See the following examples:
  *For the Buildpacks Docs at http://docs.cloudfoundry.org/buildpacks/index.html, the content repo is: https://github.com/cloudfoundry/docs-buildpacks. 
  * For the Developer Guide Docs at http://docs.cloudfoundry.org/devguide/services/, the content repo is: https://github.com/cloudfoundry/docs-dev-guide


1. Clone your fork of the content repository. Make sure to clone your fork of the topic repository to a directory that is a sibling to this book repository. So, for example, if you are contributing content to the Buildpack documentation, your folder structure would look like this:

  <pre>

    |
    +-- docs-book-cloudfoundry
    |
    +-- docs-buildpacks
    |
  </pre>

1. Clone the [docs-layout-repo](https://github.com/pivotal-cf/docs-layout-repo) for bookbinder `bind` to run properly. This book now uses a centralized layout repository.

1. Make your changes. 
 
1. Run bookbinder on your local changes:

  <pre>
    $ cd docs-book-cloudfoundry
    $ bundle install
    $ bundle exec bookbinder watch
  </pre>

  Bookbinder attempts to assemble the doc set from your local copies.
  It will skip any topic repositories that you do not have checked out. For more information on Bookbinder, see the <a href="https://github.com/pivotal-cf/bookbinder#bookbinder">Bookbinder README</a>. 

1. Point your browser at <code>localhost:4567</code> to preview your changes. On save your browser will reload with any additional changes you make. 

1. Commit your changes, rebase from upstream, and push to your fork.

1. Submit a PR from your fork to the original repositories.

The Docs team will review and merge the PR. They may contact you with questions or edit the PR for formatting and style. 

**Note**: Once your pull request is merged, your changes appear on [docs.cloudfoundry.org](http://docs.cloudfoundry.org) the next time the cf-docs team
pushes updates to the production docs. Updates go live at least once a week.
