r302 '/bosh/bosh-errands.html', '/bosh/jobs.html'
r302 %r{/bosh/(.*)}, 'http://bosh.io/docs/$1'
r302 '/console/cf-api-endpoint.html', '/running/cf-api-endpoint.html'

r302 %r{/deploying/ec2/.*}, '/deploying/aws/index.html'

r302 '/deploying/openstack/deploying_bosh.html', '/deploying/openstack/index.html'
r302 '/deploying/openstack/deploying_microbosh.html', '/deploying/openstack/index.html'
r302 '/deploying/openstack/uploading_bosh_stemcell.html', '/deploying/openstack/index.html'

r302 '/deploying/vsphere/bosh-example-manifest.html', '/deploying/vsphere/index.html'
r302 '/deploying/vsphere/deploying_bosh_with_micro_bosh.html', '/deploying/vsphere/index.html'
r302 '/deploying/vsphere/deploying_micro_bosh.html', '/deploying/vsphere/index.html'
r302 '/deploying/vsphere/install-and-prepare-vsphere.html', '/deploying/vsphere/index.html'

r302 '/deploying/vcloud/bosh-example-manifest.html', '/deploying/vcloud/index.html'
r302 '/deploying/vcloud/deploying_bosh_with_micro_bosh.html', '/deploying/vcloud/index.html'
r302 '/deploying/vcloud/deploying_micro_bosh.html', '/deploying/vcloud/index.html'
r302 '/deploying/vcloud/micro-bosh-example-manifest.html', '/deploying/vcloud/index.html'

r302 '/deploying/boshlite/deploy_cf_boshlite.html', '/deploying/boshlite/index.html'

r302 '/deploying/cf-stub-aws.html', '/deploying/aws/cf-stub.html'
r302 '/deploying/cf-stub-openstack.html', '/deploying/openstack/cf-stub.html'
r302 '/deploying/cf-stub-vsphere.html', '/deploying/common/vsphere-vcloud-cf-stub.html'
r302 '/deploying/cf-stub-vcloud.html', '/deploying/common/vsphere-vcloud-cf-stub.html'

r302 '/deploying/adding-services.html', 'https://github.com/cloudfoundry-community/cf-services-contrib-release'

r302 '/deploying/common/cf-release.html', '/deploying/index.html'

r302 '/devguide/deploy-apps/domains-routes.html', '/devguide/deploy-apps/routes-domains.html'
r302 '/devguide/deploy-apps/sts.html', '/buildpacks/java/sts.html'
r302 '/devguide/deploy-apps/api-endpoint.html', '/running/cf-api-endpoint.html'
r302 '/devguide/installcf/whats-new-v6.html', '/cf-cli/getting-started.html'
r302 '/devguide/installcf/http-proxy.html', '/cf-cli/http-proxy.html'
r302 %r{/devguide/installcf/(.*)}, '/cf-cli/$1'
r302 %r{/devguide/cf-cli/(.*)}, '/cf-cli/$1'

r302 '/running/managing-cf/', '/running/index.html#managing'
r302 '/running/managing-cf/index.html', '/running/index.html#managing'
r302 '/running/troubleshooting/', '/running/index.html#troubleshooting'
r302 '/running/troubleshooting/index.html', '/running/index.html#troubleshooting'

r302 '/concepts/diego/diego-components.html', '/concepts/diego/diego-architecture.html#core'
r302 '/services/asynchronous-operations.html', '/services/api.html#asynchronous-operations'
