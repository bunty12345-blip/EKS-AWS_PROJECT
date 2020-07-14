# EKS-AWS_PROJECT
Deploying NextCloud and Wordpress application using AWS EKS Cloud and Helm Chart AutomationTest using Terraset

PROJECT TOPIC:
Create a project Integrating all the technologys covered in EKS_AWS training include use of normal eks cluster , fargate cluster and use them to launch various applications with the help of helm if terraform known then also integrate terraform code to setup the fargate cluster. It can include Technology like: 
1. EKS 
2. EBS 
3. EFS
4. HELM 
5. FARGATE

Application can be anything like for example :
1. A simple  cloud storage space server
2. Wordpress server
3. Jenkins workflow pipeline
4. Prometheus
5. Graphana

INTRODUCTION :
              
              WHAT IS AMAZON EKS ??
              
  Amazon Elastic Kubernetes Service ( AMAZON EKS) is a managed service that makes it easy for us to run the Kubernetes on AWS without needing to stand up or maintain our own     Kubernetes Control Plane. Kubernetes is an open source system for automating the deployment , scaling and management of containerized applications. 
 
  Amazon EKS runs Kubernetes control plane instances across multiple Availability Zones to ensure high availability. Amazon EKS automatically detects and replaces unhealthy       control plane instances, and it provides automated version updates and patching for them.   
  
  Amazon EKS is also integrated with many AWS services to provide scalability and security for our applications including:
  1. AMAZON ECR  for container images 
  2. Elastic Load Balancing for load distribution
  3. IAM for authentication
  4. AMAZON VPC for isolation
  
        AMAZON  EKS CONTROL PLANE ARCHITECTURE
        
   Amazon EKS runs a single tenant Kubernetes Control plane for each cluster and control plane infrastructure is not shared across clusters or AWS accounts.
   This control plane consists of at least 2 API server nodes and three etcd nodes that run across three Availability Zones within a Region. Amazon EKS automatically detects  and replaces unhealthy control plane instances, restarting them across the Availability Zones within the Region as needed. Amazon EKS leverages the architecture of AWS Regions in order to maintain high availability. Amazon EKS offer an SLA for API server endpoint availability. 
   
Amazon EKS uses Amazon VPC network policies to restrict traffic between control plane components to within a single cluster. Control plane components for a cluster cannot view or receive communication from other clusters or other AWS accounts except as authorized with Kubernetes RBAC policies.

     How does Amazon EKS work ?
     
     Getting started with Amazon EKS is easy :
     1. First create an Amazon EKS cluster in the AWS Management Console or with the AWS CLI or one of the AWS SDKS.
     2. Then launch worker nodes that register with the Amaon EKS cluster. They provide with an AWS CLoud Formation Template that automatically configure our nodes.
     3. When our cluster is ready, we can configure our Kubernetes Tool kubectl to communicate with our cluster.
     4. Deploy and manage applications on our Amazon EKS cluster the same way that would done with any other Kubernetes environment.
     
 PREREQUISITIES:
 1. Create an Amazon Web service account to do this project.
 2. Install the AWS CLI:  The AWS CLI is a command line interface is a unified tool to manage our AWS services. With just one tool to download and configure, we can control multiple AWS services from the command line interface and automate them through scripts.
 3. Download the AWS CLI MSI Installer for Windows 10 (64 bit) Recommended using the following link :
  https://awscli.amazonaws.com/AWSCLIV2.msi.
 4. Kubernetes uses a command line utility called kubectl for communicating with cluster API server. The kubectl binary is available in many operating system package managers and this option is much easier than manually downloading and installing the process.
 5. eksctl is a simple CLI tool for creating clusters on EKS - Amazon's new managed kubernetes service for EC2. It is written in Go, uses Cloud Formation was created by 
 https://www.weave.works/ and it welcomes contribution from the community. Install it using the link https://github.com/weaveworks/eksctl .
 6. AWS CLI must be configured with IAM or ROOT user and also it has the power to use the Roles service in AWS.
 
 eksctl-The official CLI for Amazon EKS
 
 eksctl is a simple CLI tool for creating clusters on EKS - Amazon's new managed Kubernetes service for EC2. It is written in Go, and uses CloudFormation.
 Create a cluster with eksctl:
 eksctl create cluster
 
 Installation of eksctl: (Linux users)
 curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

(Windows users):
chocolatey install eksctl
or scoop:
scoop install eksctl

We will need to have AWS API credentials configured. We can use  ~/.aws/credentials file or environmental variables.
We will also need AWS IAM Authenticator for Kubernetes command either aws-iam-authenticator or aws eks get-token in our PATH.

To create a  basic cluster run :
eksctl create cluster
After creating the cluster we will find that the cluster credentials were added in ~/.kube/config.

Example of the Output :

$ eksctl create cluster
[ℹ]  eksctl version 0.6.0
[ℹ]  using region us-west-2
[ℹ]  setting availability zones to [us-west-2a us-west-2c us-west-2b]
[ℹ]  subnets for us-west-2a - public:192.168.0.0/19 private:192.168.96.0/19
[ℹ]  subnets for us-west-2c - public:192.168.32.0/19 private:192.168.128.0/19
[ℹ]  subnets for us-west-2b - public:192.168.64.0/19 private:192.168.160.0/19
[ℹ]  nodegroup "ng-98b3b83a" will use "ami-05ecac759c81e0b0c" [AmazonLinux2/1.11]
[ℹ]  creating EKS cluster "floral-unicorn-1540567338" in "us-west-2" region
[ℹ]  will create 2 separate CloudFormation stacks for cluster itself and the initial nodegroup
[ℹ]  if you encounter any issues, check CloudFormation console or try 'eksctl utils describe-stacks --region=us-west-2 --cluster=floral-unicorn-1540567338'
[ℹ]  2 sequential tasks: { create cluster control plane "floral-unicorn-1540567338", create nodegroup "ng-98b3b83a" }
[ℹ]  building cluster stack "eksctl-floral-unicorn-1540567338-cluster"
[ℹ]  deploying stack "eksctl-floral-unicorn-1540567338-cluster"
[ℹ]  building nodegroup stack "eksctl-floral-unicorn-1540567338-nodegroup-ng-98b3b83a"
[ℹ]  --nodes-min=2 was set automatically for nodegroup ng-98b3b83a
[ℹ]  --nodes-max=2 was set automatically for nodegroup ng-98b3b83a
[ℹ]  deploying stack "eksctl-floral-unicorn-1540567338-nodegroup-ng-98b3b83a"
[✔]  all EKS cluster resource for "floral-unicorn-1540567338" had been created
[✔]  saved kubeconfig as "~/.kube/config"
[ℹ]  adding role "arn:aws:iam::376248598259:role/eksctl-ridiculous-sculpture-15547-NodeInstanceRole-1F3IHNVD03Z74" to auth ConfigMap
[ℹ]  nodegroup "ng-98b3b83a" has 1 node(s)
[ℹ]  node "ip-192-168-64-220.us-west-2.compute.internal" is not ready
[ℹ]  waiting for at least 2 node(s) to become ready in "ng-98b3b83a"
[ℹ]  nodegroup "ng-98b3b83a" has 2 node(s)
[ℹ]  node "ip-192-168-64-220.us-west-2.compute.internal" is ready
[ℹ]  node "ip-192-168-8-135.us-west-2.compute.internal" is ready
[ℹ]  kubectl command should work with "~/.kube/config", try 'kubectl get nodes'
[✔]  EKS cluster "floral-unicorn-1540567338" in "us-west-2" region is ready
$

Listing clusters:
eksctl get cluster [--name=<name>][--region=<region>]
  
Config based cluster creation:
We can also create a cluster passing all configuration information in a file using --config-file:
eksctl create cluster --config-file=<path>
cluster creation without nodegroup
eksctl create cluster --config-file=<path> --without-nodegroup

Cluster credentials:
To write cluster credentials to a file other than default, run:
eksctl create cluster --name=cluster-2 --nodes=4 --kubeconfig=./kubeconfig.cluster-2.yaml

To prevent storing cluster credentials locally, run:
eksctl create cluster --name=cluster-3 --nodes=4 --write-kubeconfig=false

To let eksctl manage cluster credentials under ~/.kube/eksctl/clusters directory, run:
eksctl create cluster --name=cluster-3 --nodes=4 --auto-kubeconfig

To obtain cluster credentials at any point in time, run:
eksctl utils write-kubeconfig --cluster=<name> [--kubeconfig=<path>][--set-kubeconfig-context=<bool>]

AutoScaling:
To use a 3-5 node Auto Scaling Group, run:
eksctl create cluster --name=cluster-5 --nodes-min=3 --nodes-max=5

SSH access:
In order to allow SSH access to nodes, eksctl imports ~/.ssh/id_rsa.pub by default, to use a different SSH public key, e.g. my_eks_node_id.pub, run:
eksctl create cluster --ssh-access --ssh-public-key=my_eks_node_id.pub

To use a pre-existing EC2 key pair in us-east-1 region, you can specify key pair name (which must not resolve to a local file path), e.g. to use my_kubernetes_key run:
eksctl create cluster --ssh-access --ssh-public-key=my_kubernetes_key --region=ap-south-1

Tagging:
To add custom tags for all resources, use --tags.
eksctl create cluster --tags environment=staging --region=ap-south-1

Volume Size:
The default volume size is 80G.

To configure node root volume, use the --node-volume-size (and optionally --node-volume-type), e.g.:
eksctl create cluster --node-volume-size=50 --node-volume-type=io1

Deletion:
To delete a cluster, run:
eksctl delete cluster --name=<name> [--region=<region>]

Note: Cluster info will be cleaned up in kubernetes config file. Please run kubectl config get-contexts to select right context.

Shell Completion:

Bash:
To enable bash completion, run the following, or put it in ~/.bashrc or ~/.profile:
. <(eksctl completion bash)

Zsh
For zsh completion, please run:
mkdir -p ~/.zsh/completion/
eksctl completion zsh > ~/.zsh/completion/_eksctl

and put the following in ~/.zshrc:
fpath=($fpath ~/.zsh/completion)

Note if you're not running a distribution like oh-my-zsh you may first have to enable autocompletion:
autoload -U compinit
compinit
To make the above persistent, run the first two lines, and put the above in ~/.zshrc.

Fish:
The below commands can be used for fish auto completion:
mkdir -p ~/.config/fish/completions
eksctl completion fish > ~/.config/fish/completions/eksctl.fish

kubectl get nodes
NAME                                              STATUS   ROLES    AGE   VERSION
ip-192-168-15-6.eu-central-1.compute.internal     Ready    <none>   39s   v1.13.8-eks-cd3eb0
ip-192-168-64-189.eu-central-1.compute.internal   Ready    <none>   38s   v1.13.8-eks-cd3eb0

$ kubectl get pods --all-namespaces
NAMESPACE     NAME                       READY   STATUS    RESTARTS   AGE
kube-system   aws-node-l8mk7             1/1     Running   0          45s
kube-system   aws-node-s2p2c             1/1     Running   0          45s
kube-system   coredns-7d7755744b-f88w7   1/1     Running   0          45s
kube-system   coredns-7d7755744b-qgc6r   1/1     Running   0          45s
kube-system   kube-proxy-kg57w           1/1     Running   0          45s
kube-system   kube-proxy-qzcmk           1/1     Running   0          45s

Setting up cluster with Helm operator:

HELM OPERATOR:

The Helm Operator is a Kubernetes operator, allowing one to declaratively manage Helm chart releases. Combined with Flux this can be utilized to automate releases in a GitOps manner, but the usage of Flux is not a strict requirement.

The desired state of a Helm release is described through a Kubernetes Custom Resource named HelmRelease. Based on the creation, mutation or removal of a HelmRelease resource in the cluster, Helm actions are performed by the operator.

HELM OPERATOR FEATURES:

1. Declarative install, upgrade, and delete of Helm releases
2. Pulls chart from any chart source;
  i> Public or private Helm repositories over HTTP/S
  ii> Public or private Git repositories over HTTPS or SSH
  iii> Any other public or private chart source using one of the available Helm downloader plugins
3. Allows Helm values to be specified;
  i> In-line in the HelmRelease resource
  ii> In (external) sources, e.g. ConfigMap and Secret resources, or a (local) URL
4. Automated purging on release install failures
5. Automated (optional) rollback on upgrade failures
6. Automated (optional) helm test gating of installs and upgrades.
7. Automated image upgrades using Flux
8. Automated (configurable) chart dependency updates for Helm charts from Git sources on install or upgrade
9. Detection and recovery from Helm storage mutations (e.g. a manual Helm release that was made but conflicts with the declared configuration for the release)
10. Parallel and scalable processing of different HelmRelease resources using workers
11. Supports both Helm 2 and 3

GET STARTED WITH THE HELM OPERATOR:
