# tf2
TF2:  adding autoscaling to VPC network from TF1

# Autoscaling Group
## What is an Autoscaling group?
> An Auto Scaling group contains a collection of Amazon EC2 instances that are treated as a logical grouping for the purposes of automatic scaling and management.

- enables you to use Amazon EC2 Auto Scaling features such as health check replacements and scaling policies
- maintains the number of instances in an Auto Scaling group 
- automatic scaling
- The size of an Auto Scaling group depends on the number of instances you set as the **desired capacity**
- size adjustable to meet demand, either manually or by using automatic scaling
- provisioning autoscaling groups: two options
    1. launch configuration
    >  An instance configuration template that an Auto Scaling group uses to launch EC2 instances. You can only specify one launch configuration for an Auto Scaling group at a time. To change the launch configuration for an Auto Scaling group, you must create a launch configuration and then update your Auto Scaling group with it

    2. launch template
    > Specifies instance configuration information, much like Launch Template. launch templates allow you to have multiple versions of a template With versioning, you can create a subset of the full set of parameters and then reuse it to create other templates or template versions.  For example, you can create a default template that defines common configuration parameters such as tags or network configurations, and allow the other parameters to be specified as part of another version of the same template.

    > *AWS recommends that you use launch templates instead of launch configurations*

- Terraform and AWS Autoscaling:
> Terraform has an officially supported autoscaling group template. For resources like ASG, load balancer, RDS etc, I’m we can also use the inherent resources of Terraform.

### AMI 
> An Amazon Machine Image (AMI) provides the information required to launch an instance
- You must specify an AMI when you launch an instance
- You can launch multiple instances from a single AMI when you need multiple instances with the same configuration

### Security Groups:  This deployment will configure two new security groups
1. "wordpress_elb"  The load balancer will get the traffic from the internet 
2. "aws_security_group" instances will get the traffic only from the load balancer

> Because terraform creates a provision order related to dependencies, *wordpress-instance-sg will be provisioned first then wordpress-elb-sg*

> Note: If you are preparing your environment *not for end-user but for testing or development*, replace 0.0.0.0/0 with your IP Ranges. 

### IAM  Role
> IAM Role is not required for this deployment, but it is a good practice to learn to deploy IAM roles which can control security access in different environments