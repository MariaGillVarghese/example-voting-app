# example-voting-app Scenario 1 - development set-up:
# 1.	Discuss & justify potential deployment options in terms of infrastructure for development environment of above application
**Ans.**  There are 2 options for setting up the development environment in AWS.
## Option 1: Using an AWS EC2 Instances with Docker
Deploy the application on an AWS EC2 instance using Docker. Either run a docker daemon as a single node or setup docker swarm in an EC2 instance
### 1.1. Running docker daemon on a single EC2 instance
Docker operates directly on a single EC2 instance, where containers are deployed and managed individually. This setup is simple and easy to configure, making it ideal for small applications or development environments. With only one instance, the costs are lower compared to multi-instance deployments, and the configuration is straightforward. However, this simplicity comes with limitations: if the EC2 instance fails, all services running on it will be unavailable, resulting in potential downtime. Additionally, there is no built-in support for load balancing, high availability, or failover, which could be critical for production environments.

### 1.2. Running Docker Swarm on Multiple EC2 Instances
In this configuration, Docker Swarm is deployed across multiple EC2 instances, creating a cluster with designated manager and worker nodes. Docker Swarm offers built-in redundancy, automatically redistributing workloads to healthy nodes if one fails, thereby minimizing downtime. Scaling applications is straightforward—simply add more EC2 instances to the swarm, and Swarm handles the automatic distribution of containers across the nodes. With built-in load balancing, Swarm efficiently distributes incoming requests across service replicas running on different nodes. Additionally, Swarm streamlines inter-container communication, service discovery, and networking across the cluster, reducing the need for manual intervention.

## Option 2. AWS Elastic Kubernetes Service (EKS)
Utilize Amazon EKS to manage Kubernetes clusters for hosting the development environment. EKS offers a development environment that closely mirrors production, especially when the production environment also runs on EKS. Kubernetes's inherent scalability allows the development environment to handle larger test loads as needed. It optimizes resource utilization, making it ideal for environments shared by multiple developers. Additionally, EKS supports advanced features such as auto-scaling, rolling updates, secrets management, complex scheduling, multi-tenancy, and sophisticated networking configurations.Kubernetes has a vast ecosystem of tools, plugins, and integrations, allowing for advanced customization, monitoring, logging, and networking. The ecosystem includes Helm for package management, Istio for service mesh, Prometheus for monitoring, and more.


## My Choice:
Amazon EKS: The better choice for production-grade applications requiring high scalability, advanced orchestration features, and seamless integration with other AWS services. EKS is more complex but offers a robust, future-proof solution for managing containerized workloads at scale. Having a development environment similar to or atleast a miniature version of a production environment always has its advantages.

# 2. Demonstrate example infrastructure set-up and application deployment model (CD)**
**Ans.**  
**2.1:** The terraform configuration files to setup a single node EC2 instance can be found in the directory EC2 with Docker Daemon. The setup involves creating an EC2 instance, installing Docker on it, and managing the security groups to allow SSH access. Execute the following steps:
```
1. terraform init
2. terraform apply
```

**2.2:** The terraform configuration files to setup a 3-node EC2 instance cluster Docker Swarm installed can be found in the directory EC2 for Docker Swarm. The setup involves creating the EC2 instances, installing Docker on each instance, and then configuring Docker Swarm to manage them as a cluster. Execute the following steps:
```
1. terraform init
2. terraform apply
3. Initialize Docker Swarm on the First Node:
        3.1: ssh -i /path/to/your/private-key.pem ec2-user@<first_instance_public_ip>
        3.2: docker swarm init --advertise-addr <first_instance_private_ip>
4. Join the other 2 Nodes:
        docker swarm join --token <token> <first_instance_private_ip>:2377
```
**2.3:** The terraform configuration files to setup a 3-node EKS (Elastic Kubernetes Service) cluster can be found in the directory EKS Cluster. These files will define the infrastructure resources, such as VPC, subnets, IAM roles, security groups, EKS cluster, and the worker nodes. Execute the following steps:
```
	1. terraform init
	2. terraform apply
```


## Application Deployment Model (CD)
I would setup a Jenkins instance as my CI/CD tool to execute my pipeline. The pipeline would perform the builds, docker push, deployments to AWS EKS. You can find an example Jenkinsfile in the root of the repository.

