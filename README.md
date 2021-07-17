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
    >  an instance configuration template that an Auto Scaling group uses to launch EC2 instances. You can only specify one launch configuration for an Auto Scaling group at a time. To change the launch configuration for an Auto Scaling group, you must create a launch configuration and then update your Auto Scaling group with it
    
    2. launch template