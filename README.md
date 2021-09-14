# Cloud Foundry Documentation

This project publishes the Cloud Foundry documentation as a web application.

In this topic:

* [What's in this Repository](#whats-in-this-repo)
* [Topic Repositories](#topic-repositories)
* [Contributing Pull Requests](#contributing-pull-requests)
* [Determine Content Repositories and Branches of a Book](#determine-content-repos-and-branches-of-a-book)

## What's in this Repository

This repository uses the [Bookbindery gem](http://github.com/pivotal-cf/docs-bookbinder) to generate the documentation as a web application.

The config.yml file contains the list of topic repositories.

The master_middleman folder contains the layouts, styles, and subnav used to create the web pages.

This repository does not contain the documentation content. Documentation content is contained in the topic repositories listed in the config.yml.

## Topic Repositories

The following list describes the topic repositories that make up the Cloud Foundry documentation set

* [Cloud Foundry Concepts](http://github.com/cloudfoundry/docs-cloudfoundry-concepts): Underlying concepts and architecture
* [Cloud Foundry Command-Line Interface (cf CLI)](https://github.com/cloudfoundry/docs-cf-cli): A guide to the cf CLI for Cloud Foundry developers and users 
* [Developer Guide](http://github.com/cloudfoundry/docs-dev-guide): Step-by-step instructions and reference material for developers pushing applications to Cloud Foundry
* [Deploying Cloud Foundry](http://github.com/cloudfoundry/docs-deploying-cf): Instructions for operators using BOSH to deploying Cloud Foundry on AWS, vSphere, vCloud, OpenStack, etc.
* [Running Cloud Foundry](http://github.com/cloudfoundry/docs-running-cf): Information for operators running Cloud Foundry
* [Administrator Tools](https://github.com/cloudfoundry/docs-cf-admin): Documentation about operating Cloud Foundry deployments using BOSH and the cf command line tool
* [Services](http://github.com/cloudfoundry/docs-services): Information about extending Cloud Foundry with custom services, and the service broker API
* [Buildpacks](http://github.com/cloudfoundry/docs-buildpacks): Guides to developing your own buildpacks
* [Loggregator](http://github.com/cloudfoundry/docs-loggregator): Information about the user application logging subsystem of Cloud Foundry
* [User Account and Authentication](https://github.com/cloudfoundry/uaa): Information about the Cloud Foundry User Account and Authentication (UAA) Server

## Contributing Pull Requests

To submit a pull request to the documentation, follow this process:

1. Make sure you have a signed CLA. Even if you aren't contributing running code, we still need a Contributor License Agreement.

1. Fork the content repository you want to make a contribution to. See the following examples:
  * For the Buildpacks Docs at http://docs.cloudfoundry.org/buildpacks/index.html, the content repository is: https://github.com/cloudfoundry/docs-buildpacks. 
  * For the Developer Guide Docs at http://docs.cloudfoundry.org/devguide/services/, the content repository is: https://github.com/cloudfoundry/docs-dev-guide

1. Clone your fork of the content repository. Make sure to clone your fork of the topic repository to a directory that is a sibling to this book repository. So, for example, if you are contributing content to the Buildpack documentation, your folder structure would look like this:

  <pre>

    |
    +-- docs-book-cloudfoundry
    |
    +-- docs-buildpacks
    |
  </pre>

1. Make your changes. 
 
1. Run bookbinder on your local changes. Bookbinder has been tested with the following Ruby versions:
    * 2.5.3
    * 2.5.5
    * 2.6.3
    * 2.6.6
    * 2.6.8
  <pre>
    $ cd docs-book-cloudfoundry
    $ bundle install
    $ bundle exec bookbinder watch
  </pre>

  Bookbinder attempts to assemble the doc set from your local copies.
  It skips any topic repositories that you do not have checked out. For more information about Bookbinder, see the <a href="https://github.com/pivotal-cf/bookbinder#bookbinder">Bookbinder README</a>. 

1. Point your browser at <code>localhost:4567</code> to preview your changes. On save, your browser will reload with any additional changes you make. 

1. Commit your changes, rebase from upstream, and push to your fork.

1. Submit a pull request (PR) from your fork to the original repositories.

The CF Docs team will review and merge the PR. They may contact you with questions or edit the PR for formatting and style. 
**Note**: After your pull request is merged, your changes appear on [docs.cloudfoundry.org](http://docs.cloudfoundry.org) the next time the cf-docs team pushes updates to the production docs. Updates go live at least once a week.

## Determine Content Repositories and Branches of a Book

The `config.yml` defines the content repositories for each book.
The `config.yml` file of each book contains the list of content repositories and branches that appear in the doc set.
In the `config.yml` file, each content repository is specified in the `repository` subsection.
This subsection includes an optional `ref` key-value pair which defines the branch of the content repository that the book uses.

Make sure that you are adding your content to the correct branches of the content repositories.

To determine which branch of a content repository that a book version uses:

1. Confirm that you are on the correct book branch. For example, the currently published doc might be on the `main` branch
or on the branch corresponding to its version number.

2. Open the `config.yml` file.

3. Search for the name of the content repository, for example, `docs-cloudfoundry-concepts`.

4. Review the `repository` subsection for the content repository. If there is no `ref:` tag, then the repository uses the main branch. If there is a `ref` key-value pair, it specifies the branch name of the content repository. For example,

  ```
  - repository:
    name: cloudfoundry/docs-cloudfoundry-concepts
    ref: '225'
  ```

  `ref: '225'` refers to the 225 branch of the docs-cloudfoundry-concepts repository. Cloud Foundry `225` is associated with v255 of cf-release. 
  `1.5`, `2.2` and `4.5` map to cf-deployment releases.

