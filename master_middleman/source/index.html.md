---
title: Cloud Foundry Documentation
---
<h1>Overview</h1>
Welcome to the Cloud Foundry documentation.
<hr />
<div>
<div class="column-left">
  <div class="column-title">
      <h4>Using Cloud Foundry</h4>
  </div>
  <p><i>Push applications to Cloud Foundry.</i></p>

  <hr>
  <p>
    Deploying Applications<br>
    <a href="/devguide/deploy-apps/prepare-to-deploy.html">App Design for the Cloud</a><br>
    <a href="/devguide/deploy-apps/">services/log-management.htmlPush Your Application</a><br>
    <a href="/devguide/services/">Using Services</a><br>
    <a href="/devguide/services/migrate-db.html">Migrating Your Database</a><br>
    <a href="/devguide/deploy-apps/environment-variable.html">Using Environment Variables</a><br>
    <a href="/devguide/deploy-apps/domains-routes.html">Mapping a Custom Domain</a>
  </p>

  <hr>
  <p>
    Managing and Troubleshooting<br>
    <a href="/devguide/deploy-apps/manifest.html">Application Manifests (manifest.yml)</a><br>
    <a href="/devguide/deploy-apps/streaming-logs.html">Application Logging</a><br>
    <a href="/devguide/services/log-management.html">Using Third-Party Log Management Services</a><br>
    <a href="/devguide/services/log-management-thirdparty-svc.html">Configuring Selected Third-Party Log Management Services</a><br>
    <a href="/devguide/services/integrate-splunk.html">Integrating Cloud Foundry with Splunk</a><br>
    <a href="/devguide/deploy-apps/troubleshoot-app-health.html">Troubleshooting</a>
  </p>
  <hr>

  <p>Client Tools<br>
    <a href="/devguide/installcf/">The cf Command Line Tool</a><br>
    <a href="/devguide/deploy-apps/sts.html">Eclipse Plugin</a><br>
    <a href="/devguide/deploy-apps/build-tool-int.html">Build Tool Integration</a>
  </p>

</div>

<div class="column-middle">
  <div class="column-title">
    <h4>Extending Cloud Foundry</h4>
  </div>
  <p><i>Extension points in Cloud Foundry.</i></p>
  <hr>
  <p>
    Services<br>
    <a href="/services/">Custom Services Overview</a><br>
    <a href="/services/api.html">v2 Services API</a><br>
    <a href="/services/catalog-metadata.html">Services Catalogs</a>
  </p>

  <hr>
  <p>
    Buildpacks<br>
	<a href="/buildpacks/">Buildpacks</a><br>

	<a href="/buildpacks/custom.html">Custom Buildpacks</a><br>

	  <p>

	<a href="/buildpacks/java/">Java Buildpack</a><br>

	<a href="/buildpacks/java/java-tips.html">Tips for Java Developers</a><br>

	<a href="/buildpacks/java/grails-service-bindings.html">Grails Service Connections</a><br>

	<a href="/buildpacks/java/spring-service-bindings.html">Spring Service Connections</a><br>

	<a href="/buildpacks/java/play-service-bindings.html">Play Framework Service Connections</a><br>

	  <p>

	<a href="/buildpacks/node">Node.js Buildpack</a><br>

	<a href="/buildpacks/node/node-tips.html">Tips for Node.js Developers</a><br>

	<a href="/buildpacks/node/node-service-bindings.html">Node.js Service Connections</a><br>

	  <p>

	<a href="/buildpacks/ruby/">Ruby Buildpack</a><br>

	<a href="/buildpacks/ruby/ruby-tips.html">Tips for Ruby Developers</a><br>

	<a href="/buildpacks/ruby/ruby-service-bindings.html">Ruby Service Connections</a><br>

  </p>


</div>


<div class="column-right">
  <div class="column-title">
      <h4>Running Cloud Foundry</h4>
  </div>
  <p><i>Manage your Cloud Foundry deployment.</i></p>

  <hr>
  <p>
    Understanding the Architecture<br>
    <a href="/concepts/architecture/">A Tour of Each Component</a><br>
    <a href="/concepts/how-applications-are-staged.html">How Applications Are Staged</a><br>
    <a href="/concepts/high-availability.html">Scaling Cloud Foundry</a></p>
  </p>
  <hr>

  <p>BOSH<br>
  <a href="/bosh/">BOSH Documentation</a><br>
  <p>
    BOSH Foundations<br>
  <a href="/bosh/glossary.html">Glossary</a><br>
  <a href="/bosh/what-bosh-is.html">What BOSH is &amp; Why it's Different</a><br>
  <a href="/bosh/workflow.html">Basic BOSH Workflow</a><br>
  </p>
  <p>
    Working with BOSH<br>
  <a href="/bosh/iaas-setup.html">Setting Up your Iaas for BOSH</a><br>
  <a href="/bosh/deploy-microbosh.html">Deploying MicroBOSH</a><br>
  <a href="/bosh/deploy-with-bosh.html">Deploying Distributed Software with BOSH</a><br>
  </p>
  <p>
    BOSH in Depth<br>
  <a href="/bosh/create-micro-manifest.html">Creating a MicroBOSH Deployment Manifest</a><br>
  <a href="/bosh/create-manifest.html">Creating a BOSH Deployment Manifest</a><br>
  <a href="/bosh/bosh-components.html">BOSH Components</a><br>
  </p>

  <hr>

  <p>
    Deploy Cloud Foundry<br>
    <a href="/deploying/">Overview</a><br>
    <a href="/deploying/ec2/">Deploy to AWS</a><br>
	<a href="/deploying/ec2/bootstrap-aws-vpc.html">Deploying to AWS with BOSH AWS Bootstrap</a></br>
	<a href="/deploying/ec2/aws_steps.html">Deploying to AWS Tutorial</a></br>
    <a href="/deploying/openstack/">Deploy to OpenStack</a><br>
    <a href="/deploying/vsphere/">Deploy to vSphere</a><br>
    <a href="/deploying/vcloud/">Deploy to vCloud Hybrid Service or vCloud Director</a><br>
    <a href="/deploying/adding-services.html">Deploying Community Services</a><br>
    <a href="/deploying/run-local.html">Run a Local Cloud Foundry Instance</a>
  </p>

  <hr>
  <p>
    Run Cloud Foundry<br>
    <a href="/running/">Overview</a><br>
    <a href="/running/managing-cf/managing-users.html">Managing Users</a><br>
	<a href="/running/managing-cf/quota-plans.html">Creating and Modifying Quota Plans</a><br>
    <a href="/running/managing-cf/logging.html">Logging</a><br>
    <a href="/running/troubleshooting/">Troubleshooting</a>
  </p>

</div>
</div>
<div>
  <h2>Reference</h2>
  <p><a href="/concepts/glossary.html">Cloud Foundry Glossary</a></p>
  For a look at what is planned, look at the
  [community wiki](https://github.com/cloudfoundry-community/cf-docs-contrib/wiki)
</div>

