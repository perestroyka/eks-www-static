Q: Create a AWS EKS deployment of a static website through automation (Cloud-formation or Terraform). The source code should live in Git. You may use CICD on AWS or local.

Deliverables:
- Architecture Diagram including CICD
- Other READ ME
- Git URL
- App URL


#Assumptions:




VPC/Subnets already exist
AWS cli, KUBECTL and EKSCTL are already installed and configured

In scope:
- MVP rather than real-life deployment
- Single region
- Basic HA
- Single step deployment pipeline
- Immutable content + code
- No volume encryption

Out of scope:
- IaC for CICD pipeline
- Security/SSL/WAF etc.
- Multi-region
- Auto-scaling
- Complex multi-env CICD pipeline



In reality:
Artifactory
Rio/Jenkins
Private Git
CDN
WAF
Security Hardening
Logging/Monitoring

aws cloudformation deploy \
 --template-file provision.yaml \
 --stack-name eks-www-static \
 --no-fail-on-empty-changeset \
 --capabilities CAPABILITY_NAMED_IAM

aws cloudformation deploy --template-file provision.yaml --stack-name eks-www-static --no-fail-on-empty-changeset --capabilities CAPABILITY_NAMED_IAM

Files:

*cf-provision.yaml* - CF version for cluster provisioning

Can be deployed by:
```aws cloudformation deploy \
 --template-file provision.yaml \
 --stack-name eks-www-static \
 --no-fail-on-empty-changeset \
 --capabilities CAPABILITY_NAMED_IAM```

*eksctl-provision.yaml* - EksCtl provisioning (smaller, but less control)
To deploy:
```eksctl create cluster -f eksctl-provision.yaml```

