# EKS-AWS_PROJECT
Deploying NextCloud and Wordpress application using AWS EKS Cloud and Helm Chart AutomationTest using Terraset

PROJECT TOPIC:
Create a project Integrating all the technologys covered in EKS_AWS training include use of normal eks cluster , fargate cluster and use them to launch various applications 

with the help of helm if terraform known then also integrate terraform code to setup the fargate cluster. It can include Technology like: 

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
              
  Amazon Elastic Kubernetes Service ( AMAZON EKS) is a managed service that makes it easy for us to run the Kubernetes on AWS without needing to stand up or maintain our own 
  
  Kubernetes Control Plane. Kubernetes is an open source system for automating the deployment , scaling and management of containerized applications. 
 
  Amazon EKS runs Kubernetes control plane instances across multiple Availability Zones to ensure high availability. Amazon EKS automatically detects and replaces unhealthy      
  control plane instances, and it provides automated version updates and patching for them.   
  
  Amazon EKS is also integrated with many AWS services to provide scalability and security for our applications including:
  
  1. AMAZON ECR  for container images 
  
  2. Elastic Load Balancing for load distribution
  
  3. IAM for authentication
  
  4. AMAZON VPC for isolation
  
        AMAZON  EKS CONTROL PLANE ARCHITECTURE
        
   Amazon EKS runs a single tenant Kubernetes Control plane for each cluster and control plane infrastructure is not shared across clusters or AWS accounts.
  
  This control plane consists of at least 2 API server nodes and three etcd nodes that run across three Availability Zones within a Region. Amazon EKS automatically detects  
  
  and replaces unhealthy control plane instances, restarting them across the Availability Zones within the Region as needed. Amazon EKS leverages the architecture of AWS 
  
  Regions in order to maintain high availability. Amazon EKS offer an SLA for API server endpoint availability. 
   
Amazon EKS uses Amazon VPC network policies to restrict traffic between control plane components to within a single cluster. Control plane components for a cluster cannot 

view or receive communication from other clusters or other AWS accounts except as authorized with Kubernetes RBAC policies.

     How does Amazon EKS work ?
     
     Getting started with Amazon EKS is easy :

     1. First create an Amazon EKS cluster in the AWS Management Console or with the AWS CLI or one of the AWS SDKS.
     
     2. Then launch worker nodes that register with the Amaon EKS cluster. They provide with an AWS CLoud Formation Template that automatically configure our nodes.
     
     3. When our cluster is ready, we can configure our Kubernetes Tool kubectl to communicate with our cluster.
     
     4. Deploy and manage applications on our Amazon EKS cluster the same way that would done with any other Kubernetes environment.
     
 PREREQUISITIES:
 
 1. Create an Amazon Web service account to do this project.
 
 2. Install the AWS CLI:  The AWS CLI is a command line interface is a unified tool to manage our AWS services. With just one tool to download and configure, we can control 
 
  multiple AWS services from the command line interface and automate them through scripts.
 
 3. Download the AWS CLI MSI Installer for Windows 10 (64 bit) Recommended using the following link :
 
 https://awscli.amazonaws.com/AWSCLIV2.msi.
 
 4. Kubernetes uses a command line utility called kubectl for communicating with cluster API server. The kubectl binary is available in many operating system package managers 
 
 and this option is much easier than manually downloading and installing the process.
 
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

The Helm Operator is a Kubernetes operator, allowing one to declaratively manage Helm chart releases. Combined with Flux this can be utilized to automate releases in a GitOps 

manner, but the usage of Flux is not a strict requirement.

The desired state of a Helm release is described through a Kubernetes Custom Resource named HelmRelease. Based on the creation, mutation or removal of a HelmRelease resource 

in the cluster, Helm actions are performed by the operator.

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

 Helm charts :

# helm init

# helm repo add stable https://kubernetes-charts.storage.googleapis.com/

# helm repo list

# helm repo update

 Tiller is the server program connected to helm

# kubectl -n kube-system create serviceaccount tiller

# kubectl create clusterrolebinding tiller --clusterrole cluster-admin -- serviceaccount=kube-system

# helm init --service-account tiller

# helm init --service-account tiller --upgrade

# helm install stable/mysql

In our case we are going to see these new arrivals (flux and helm operator) running in the cluster:

$ kubectl get pods --all-namespaces

NAMESPACE              NAME                                                      READY   STATUS                       RESTARTS   AGE

flux                   flux-56b5664cdd-nfzx2                                     1/1     Running                      0          11m

flux                   flux-helm-operator-6bc7c85bb5-l2nzn                       1/1     Running                      0          11m

flux                   memcached-958f745c-dqllc                                  1/1     Running                      0          11m

kube-system            aws-node-l49ct                                            1/1     Running                      0          14m

kube-system            coredns-7d7755744b-4jkp6                                  1/1     Running                      0          21m

kube-system            coredns-7d7755744b-ls5d9                                  1/1     Running                      0          21m

kube-system            kube-proxy-wllff                                          1/1     Running                      0          14m

To check podinfo:

kubectl get service --namespace demo

NAME      TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE

podinfo   ClusterIP   10.100.255.220   <none>        9898/TCP   2m
  
Port forward the service:

kubectl port-forward -n demo svc/podinfo 9898:9898

Create a cluster with Gitops :

---

apiVersion: eksctl.io/v1alpha5

kind: ClusterConfig

metadata:

   name: cluster-21
  
   region: ap-south-1

# other cluster config ...

git:
  
   repo:
   
     url: "git@github.com:myorg/cluster-21.git"
    
      branch: master
    
     fluxPath: "flux/"
    
   user: "gitops"
   
    email: "gitops@myorg.com"
  
   operator:
    
     namespace: "flux"
    
     withHelm: true
  
  bootstrapProfile:
  
    source: app-dev
    
     revision: master

This configuration will install FLUX and HELM and set up the repo.

git@github.com:myorg/cluster-21.git so that any Kubernetes manifest added there will automatically be picked up and applied to your cluster by Flux. Once the cluster is 

created, the repo will also contain the manifests used to install Flux and Helm, so any further configuration can be done directly in a Gitops way.

eksctl generate profile \

        --cluster wonderful-wardrobe-1565767990 \
        
	--profile-source https://github.com/weaveworks/eks-quickstart-app-dev.git \
        
	--profile-path ~/dev/flux-get-started/cluster-config
        
eksctl generate profile requires:

1. -- cluster:

2. -- profile-source:

3. --profile-path:

Cluster creation  yaml file:

apiVersion: eksctl.io/v1alpha5

kind: ClusterConfig

metadata:

  name: eks-cluster
  
  region: ap-south-1

nodeGroups:
  
    - name: ng-1
    
       instanceType: t2.micro
     
      desiredCapacity: 4
     
      ssh:
        
	  publicKeyName: sapikey
           
Entire Kubernetes Cluster setup:

eksctl create cluster -f cluster.yaml

eksctl get cluster

 aws eks update-kubeconfig --name <cluster name>

kubectl get nodes

Create  a  Wordpress website and host it in cloud Database using MYSQL DATABASE:

Kubectl supports the management of Kubernetes objects using a kustomization file.

Create a Secret by generators in kustomization.yaml file:

apiVersion: kustomize.config.k8s.io/v1beta1

kind: Kustomization

secretGenerator:

        - name: mysql-pass
	
	  literals:
	  
	        - password=redhat

resources: 

        - mysqldeployment.yaml
	
	- wordpressdeployment.yaml
  
SQL-DEPLOYMENT:

The manifest file describes a single instance MYSQL Deployment. The MYSQL container mounts the persistent storage volume at /var/lib/mysql. MYSQL_ROOT_PASSWORD environment  

variable sets the database password from the Secret.

apiVersion: v1

kind: Service

metadata:

      name: wordpress-mysql
      
      labels:
      
          app: wordpress

spec:

   ports:
   
      - port: 3306
   
    selector:
    
        app: wordpress
        
	tier: mysql
   
   clusterIP: None

---

apiVersion: v1

kind: PersistentVolumeClaim

metadata:

   name: mysql-pv-claim
   
   labels: 
   
       app: wordpress

spec: 

    accessModes:
    
          - ReadWriteOnce
    
    resources:
    
          requests:
          
	       storage: 5Gi

---

apiVersion: apps/v1

kind: Deployment

metadata: 

    name: wordpress-mysql
    
    labels:
    
        app: wordpress

spec:

   selector:
   
       matchLabels:
       
         app: wordpress
         
	 tier: mysql
   
   strategy:
   
      type: Recreate
    
    template:
    
       metadata: 
       
          labels: 
          
	      app: wordpress
              
	      tier: mysql
      
      spec:
      
         containers:
         
	   - image: mysql:5.6
           
	     name: mysql
            
	    env:
            
	    - name: MYSQL_ROOT_PASSWORD
            
	      valueFrom:
              
	         secretKeyRef:
                 
		      name: mysql-pass
                     
		      key: password
             
	     ports:
             
	     - containerPort: 3306
             
	       name: mysql
             
	      volumeMounts:
             
	     - name: mysql-persistent-storage
             
	       mountPath: /var/lib/mysql
          
	  volumes:
          
	   - name: mysql-persistent-storage
           
	     persistentVolumeClaim:
             
	          claimName: mysql-pv-claim


WORDPRESS-DEPLOYMENT:

The manifest file describes a single instance WORDPRESS-DEPLOYMENT. The WordPress container mounts the PersistentVolume at /var/www/html for website data files.

The WORDPRESS_DB_HOST environment variable sets the name of the MySQL Service defined above, and WordPress will access the database by Service. 

The WORDPRESS_DB_PASSWORD environment variable sets the database password from the Secret kustomize generated.

apiVersion: v1

kind: Service

metadata:

  name: wordpress
  
  labels:
  
  app: wordpress

spec:

  ports:
  
    - port: 80
  
  selector:
  
      app: wordpress
    
      tier: frontend
 
   type: LoadBalancer

---

apiVersion: v1

kind: PersistentVolumeClaim

metadata:

  name: wp-pv-claim
  
  labels:
  
     app: wordpress

spec:

   accessModes:
   
      - ReadWriteOnce
 
 resources:
 
    requests:
    
       storage: 5Gi

---

apiVersion: apps/v1

kind: Deployment

metadata:

   name: wordpress
  
   labels:
   
     app: wordpress

spec:

  selector:
  
     matchLabels:
     
      app: wordpress
      
      tier: frontend
  
  strategy:
  
      type: Recreate
  
  template:
  
    metadata:
    
       labels:
       
         app: wordpress
        
	 tier: frontend
    
    spec:
    
       containers:
      
       - image: wordpress:4.8-apache
       
         name: wordpress
        
	 env:
        
	- name: WORDPRESS_DB_HOST
        
	  value: wordpress-mysql
        
	- name: WORDPRESS_DB_PASSWORD
        
	  valueFrom:
          
	    secretKeyRef:
            
	       name: mysql-pass
              
	       key: password
        
	ports:
        
	 - containerPort: 80
         
	   name: wordpress
        
	volumeMounts:
        
	 - name: wordpress-persistent-storage
         
	   mountPath: /var/www/html
     
     volumes:
     
     - name: wordpress-persistent-storage
     
        persistentVolumeClaim:
        
	  -claimName:wp-pv-claim

All the environments can be set up by just using a single command.

kubectl create -k .

kubectl get deployments      //To verfy the deployments that are created

kubectl get pv    //shows persisten volumes that are created

kubectl get pvc   //shows persistent volume claims that are created

Here External Load Balancer IP is used in this environment.


Terraform code to launch fargate cluster:

locals {
 
  tags = merge(
  
    var.tags,
    
    	 {
    
      		"kubernetes.io/cluster/${var.cluster_name}" = "owned"
         }
  
    )

  }

module "label" {
  
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.16.0"
  
  namespace  = var.namespace
  
  stage      = var.stage
  
  name       = var.name
  
  delimiter  = var.delimiter
  
  attributes = compact(concat(var.attributes, ["fargate"]))
  
  tags       = local.tags
  
  enabled    = var.enabled

}

data "aws_iam_policy_document" "assume_role" {
  
  count = var.enabled ? 1 : 0

  statement {
  
      effect  = "Allow"
    
      actions = ["sts:AssumeRole"]

    
    principals {
    
      type        = "Service"
      
      identifiers = ["eks-fargate-pods.amazonaws.com"]
    
    }
  
  }

}

resource "aws_iam_role" "default" {

  count              = var.enabled ? 1 : 0
  
  name               = module.label.id
  
  assume_role_policy = join("", data.aws_iam_policy_document.assume_role.*.json)
  
  tags               = module.label.tags

}

resource "aws_iam_role_policy_attachment" "amazon_eks_fargate_pod_execution_role_policy" {

  count      = var.enabled ? 1 : 0
  
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  
  role       = join("", aws_iam_role.default.*.name)

}

resource "aws_eks_fargate_profile" "default" {

  count                  = var.enabled ? 1 : 0
  
  cluster_name           = var.cluster_name
  
  fargate_profile_name   = module.label.id
  
  pod_execution_role_arn = join("", aws_iam_role.default.*.arn)
  
  subnet_ids             = var.subnet_ids
  
  tags                   = module.label.tags

  selector {
  
    namespace = var.kubernetes_namespace
    
    labels    = var.kubernetes_labels
  
  }

}

Tags used for instance creation and security groups yaml file:

module "eg_prod_bastion_abc_label" {
 
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=master"
  
  namespace  = "eg"
  
  stage      = "prod"
  
  name       = "bastion"
  
  attributes = ["abc"]
  
  delimiter  = "-"

  tags = {
  
    "BusinessUnit" = "XYZ",
    
    "Snapshot"     = "true"
  
  }

}

resource "aws_security_group" "eg_prod_bastion_abc" {

  name = module.eg_prod_bastion_abc_label.id
  
  tags = module.eg_prod_bastion_abc_label.tags
  
  ingress {
  
    from_port   = 22
    
    to_port     = 22
    
    protocol    = "tcp"
    
    cidr_blocks = ["0.0.0.0/0"]
 
 }
  
}

resource "aws_instance" "eg_prod_bastion_abc" {
 
   instance_type          = "t1.micro"
   
   tags                   = module.eg_prod_bastion_abc_label.tags
   
   vpc_security_group_ids = [aws_security_group.eg_prod_bastion_abc.id]

}

module "eg_prod_bastion_xyz_label" {

  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=master"
  
  namespace  = "eg"
  
  stage      = "prod"
  
  name       = "bastion"
  
  attributes = ["xyz"]
  
  delimiter  = "-"

  tags = {
  
    "BusinessUnit" = "XYZ",
    
    "Snapshot"     = "true"
  
  }

}

resource "aws_security_group" "eg_prod_bastion_xyz" {

  name = module.eg_prod_bastion_xyz_label.id
  
  tags = module.eg_prod_bastion_xyz_label.tags
  
  ingress {
  
    from_port   = 22
    
    to_port     = 22
    
    protocol    = "tcp"
    
    cidr_blocks = ["0.0.0.0/0"] 
  
  }

}

resource "aws_instance" "eg_prod_bastion_xyz" {

   instance_type          = "t1.micro"
   
   tags                   = module.eg_prod_bastion_xyz_label.tags
   
   vpc_security_group_ids = [aws_security_group.eg_prod_bastion_xyz.id]

}

Automated testing for KUBERNETES and HELM charts using Terratest:

The templates/pod.yaml file includes a template for a single pod that deploys container and exposes port 80:

apiVersion: v1

kind: Pod

metadata: 

     name: {{ include "minimal-pod.fullname". }}
     
		 labels:
     
		    app.kubernetes.io/name: {{ include "minimal-pod.name" . }}
        
				helm.sh/chart: {{ include "minimal-pod.chart" . }}
        
				app.kubernetes.io/instance: {{ .Release.Name }}
        
				app.kubernetes.io/managed-by: {{ .Release.Service }}

spec:

   containers:
   
	  - name: {{ .Chart.Name }}
    
		  image: "{{ .Values.image }}"
      
			ports:
      
			  - name: http
        
				  containerPort: 80
          
					protocol: TCP     

Function for Template Testing using Terratest: 

func TestPodTemplateRendersContainerImage(t *testing.T) {

    // Path to the helm chart we will test
    
	helmChartPath := "../charts/minimal-pod"
    
	// Setup the args.
    
	// For this test, we will set the following input values:
    
	// - image=nginx:1.15.8
    
	options := &helm.Options{
    
	    SetValues: map[string]string{"image": "nginx:1.15.8"},
    
	}
    
	// Run RenderTemplate to render the template
    
	// and capture the output.
    
	output := helm.RenderTemplate(
    
	     t, options, helmChartPath, "nginx",
        
		 []string{"templates/pod.yaml"})
    
	// Now we use kubernetes/client-go library to render the
    
	// template output into the Pod struct. This will
    
	// ensure the Pod resource is rendered correctly.
    
	var pod corev1.Pod
    
	helm.UnmarshalK8SYaml(t, output, &pod)
    
	// Finally, we verify the pod spec is set to the expected 
    
	// container image value
    
	expectedContainerImage := "nginx:1.15.8"
    
	podContainers := pod.Spec.Containers
    
	if podContainers[0].Image != expectedContainerImage {
    
	     t.Fatalf(
         
		     "Rendered container image (%s) is not expected (%s)",
            
			  podContainers[0].Image,
            
			  expectedContainerImage,
        
		)
    
	}

}

Putting this in a file named minimal_pod_template_test.go and run this file we will get the following output:

=== RUN   TestPodTemplateRendersContainerImage

Running command helm with args [template --set image=nginx:1.15.8 --show-only templates/pod.yaml nginx ../charts/minimal-pod]

---

# Source: minimal-pod/templates/pod.yaml

apiVersion: v1

kind: Pod

metadata:

  name: nginx-minimal-pod
  
	labels:
  
	  app.kubernetes.io/name: minimal-pod
    
		helm.sh/chart: minimal-pod-0.1.0
    
		app.kubernetes.io/instance: nginx
    
		app.kubernetes.io/managed-by: Helm

spec:

   containers:
   
	   - name: minimal-pod
     
		   image: "nginx:1.15.8"
      
			 ports:
       
			   - name: http
         
				   containerPort: 80
          
					 protocol: TCP

--- PASS: TestPodTemplateRendersContainerImage (0.05s)

PASS

ok      github.com/gruntwork-io/helm-chart-testing-example/test 0.086s


HOSTING NEXT CLOUD WEBSITE USING USER_SQL DATABASE :

NEXT CLOUD USER SQL AUTHENTICATION :

Here use external database as a source for Next Cloud users. Retreive the users info and allow the users to change their passwords. Sync the user's email addresses with the 

addresses stored by Next Cloud.

Getting Started:

1. SSH into your server.

2. Get into the apps folder of your Nextcloud installation, for example /var/www/nextcloud/apps.

3. Git clone this project: git clone https://github.com/nextcloud/user_sql.git.

4. Login to your Nextcloud instance as admin.

5. Navigate to Apps from the menu then find and enable the User and Group SQL Backends app.

6. Navigate to Admin from menu and switch to Additional Settings, scroll down the page and you will see SQL Backends settings.

 INTEGRATING INTO USER TABLES:
 
 CREATE TABLE sql_user

(

  uid            INT         PRIMARY KEY AUTO_INCREMENT,
  
	username       VARCHAR(16) NOT NULL UNIQUE,
  
	display_name   TEXT        NULL,
  
	email          TEXT        NULL,
  
	quota          TEXT        NULL,
  
	home           TEXT        NULL,
  
	password       TEXT        NOT NULL,
  
	active         TINYINT(1)  NOT NULL DEFAULT '1',
  
	disabled       TINYINT(1)  NOT NULL DEFAULT '0',
  
	provide_avatar BOOLEAN     NOT NULL DEFAULT FALSE,
  
	salt           TEXT        NULL

);

CREATE TABLE sql_group

(

  gid   INT         PRIMARY KEY AUTO_INCREMENT,
  
	name  VARCHAR(16) NOT NULL UNIQUE,
  
	admin BOOLEAN     NOT NULL DEFAULT FALSE

);

CREATE TABLE sql_user_group

(

  uid INT NOT NULL,
  
	gid INT NOT NULL,
  
	PRIMARY KEY (uid, gid),
  
	FOREIGN KEY (uid) REFERENCES sql_user (uid),
  
	FOREIGN KEY (gid) REFERENCES sql_group (gid),
  
	INDEX user_group_username_idx (uid),
  
	INDEX user_group_group_name_idx (gid)

);

NEXT CLOUD LOGIN FLOW:

The client should open a webview to :

<server>/index.php/login/flow

Set the OCS-APIREQUEST header to true.

Get the login credentials:

nc://login/server:<server>&user:<loginname>&password:<password>

Also username can be fetched from OCS API endpoint:

<server>/ocs/v1.php/cloud/user

Convert to app password:

curl -u  username:password -H 'OCS-APIRequest: true' https://cloud.flare.com/ocs/v2.php/core/getapppassword

<?xml version="1.0"?>

<ocs>

   <meta>
	
	    <status>ok</status>
		
		<statuscode>200</statuscode>
		
		<message>OK</message>
	
	</meta>
	
	<data>
	
	     <apppassword>M1DqHwuZWwjEC3ku7gJsspR7bZXopwf01kj0XGppYVzEkGtbZBRaXlOUxFZdbgJ6Zk9OwG9x</apppassword>
	
	</data>

</ocs>

Deleting app password:

curl -u username:app-password -X DELETE -H 'OCS-APIREQUEST: true'  http://localhost/ocs/v2.php/core/apppassword

The response should be a plain OCS response with status code 200

<?xml version="1.0"?>
<ocs>

    <meta>
	
	     <data>
		
		      <status>ok</status>
			
			  <statuscode>200</statuscode>
			
			  <message>OK</message>
		
		 </data>
	
	</meta>

</ocs>

Login flow v2:

To initiate a login an annonymous POST request is done:

curl -X POST https://cloud.example.com/index.php/login/v2

json object code:

{

 "poll":{
  
        "token":"mQUYQdffOSAMJYtm8pVpkOsVqXt5hglnuSpO5EMbgJMNEPFGaiDe8OUjvrJ2WcYcBSLgqynu9jaPFvZHMl83ybMvp6aDIDARjTFIBpRWod6p32fL9LIpIStvc6k8Wrs1",

        "endpoint":"https:///cloud.flare.com\/login\/v2\/poll"
    
	},
    "login":"https:///cloud.flare.com\/login\/v2\/flow\/guyjGtcKPTKCi4epIRIupIexgJ8wNInMFSfHabACRPZUkmEaWZSM54bFkFuzWksbps7jmTFQjeskLpyJXyhpHlgK8sZBn9HXLXjohIx5iXgJKdOkkZTYCzUWHlsg3YFg"

}

URL login should be opened in default browser : where user will follow the login procedure:

curl -X POST https://cloud.example.com/login/v2/poll -d 
"token=mQUYQdffOSAMJYtm8pVpkOsVqXt5hglnuSpO5EMbgJMNEPFGaiDe8OUjvrJ2WcYcBSLgqynu9jaPFvZHMl83ybMvp6aDIDARjTFIBpRWod6p32fL9LIpIStvc6k8Wrs1"

This will return a 404 status code error until authentication is done.

Once a 200 is returned it is another json object.

{

    "server":"https:///cloud.example.com",
    
	"loginName":"username",
    
	"appPassword":"yKTVA4zgxjfivy52WqD8kW3M2pKGQr6srmUXMipRdunxjPFripJn0GMfmtNOqOolYSuJ6sCN"

}
 
Use the server and provided credentials to connect. Note that only 200 will only be returned once.

NEXT CLOUD INTEGRATION WITH WORDPRESS:

User table: wp_users

Username column: user_login

Password column: user_pass

Hash algorithm : Unix (Crypt) or Portable PHP password
