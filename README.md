# Challenge statement

*Q:* Create a AWS EKS deployment of a static website through automation (Cloud-formation or Terraform). The source code should live in Git. You may use CICD on AWS or local.

Deliverables:
- Architecture Diagram including CICD
- Other READ ME
- Git URL
- App URL


# Solution

## Assumptions

- VPC/Subnets already exist
- AWS cli, KUBECTL and EKSCTL are already installed and configured

In scope:
- MVP approach, bare minimum for everything
- Single region / 2 AZs
- Basic HA (AZ-based)
- Rolling updates
- Single step deployment pipeline 
- Immutable content + code docker container

Out of scope:
- IaC for CICD pipeline
- Any security/SSL/WAF etc.
- Multi-region
- Auto-scaling
- DR
- Multi-env (DEV/QA/Prod) CICD pipeline
- External storage for content (i.e. to achieve independent content and code/infra updates)


## Files
**cf-provision.yaml** - CloudFormation version for cluster provisioning

Can be deployed by:
```
aws cloudformation deploy \
 --template-file cf-provision.yaml \
 --stack-name eks-www-static \
 --no-fail-on-empty-changeset \
 --capabilities CAPABILITY_NAMED_IAM
 ```



**eksctl-provision.yaml** - EksCtl version for cluster provisioning

To deploy:
```
eksctl create cluster -f eksctl-provision.yaml
```

**www** folder - static web-site content


## CICD

AWS Pipeline listens for changes in this repository. On commit it triggers AWS CodeBuild script that Pulls NGINX container, adds data from `www` folder of this repo to it and stores the resulting container in AWS ECR.

On the next step it applies `deployment.yaml` manifest to EKS Cluster and pulls and deploys the most recent version of container (from previous step).

The pods are updated using rolling mechanism to avoid user interruption.