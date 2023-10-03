# Infrastructure

## AWS Zones
Identify your zones here

us-east-2, us-west-1

## Servers and Clusters

### Table 1.1 Summary
| Asset      | Purpose           | Size                                                                   | Qty                                                             | DR                                                                                                           |
|------------|-------------------|------------------------------------------------------------------------|-----------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------|
| Asset name | Brief description | AWS size eg. t3.micro (if applicable, not all assets will have a size) | Number of nodes/replicas or just how many of a particular asset | Identify if this asset is deployed to DR, replicated, created in multiple locations or just stored elsewhere |
| EC2 instance | Host web application | t3.micro | 1 | No, just 1 instance in us-east-2 |
| EKS | EKS cluster hosting Prometheus Grafana | 1 EC2 instances in a node group | 1 | No, just hosting one on us-east-2 |
| RDS cluster | Running database cluster | 1 db.t2.small instance | 1 | No, just one cluster in us-east-2 |
| VPC | VPC networking hosting AWS resources | - | 2 | Yes. One in us-east-2 and one in us-west-1 |

### Descriptions
More detailed descriptions of each asset identified above.

* A single EC2 instance hosting web application in a region.
* An EKS cluster hosting Prometheous and Grafana in a region, using a node group containing an EC2 instances.
* A RDS database cluster containing a node in a region.
* 2 VPC in 2 regions hosting AWS resources.
* Each VPC contains 1 single AZ.

## DR Plan
### Pre-Steps:
List steps you would perform to setup the infrastructure in the other region. It doesn't have to be super detailed, but high-level should suffice.

* Create an additional region in us-west-1 to make sure system can tolerate region-outage.
* For each VPC of each region, make sure the number of Availability Zone is at least 2 to ensure zone availability.
* For each region, make sure the number of EC2 instances is 3 to make sure system can tolerate instance fail and election can take place successfully.
* Create 2 mode Kubernetes nodes for EKS cluster to help tolerate node failure and help election take place successfully.
* Make sure the database cluster has at least 3 nodes to help node availability and help election work.

## Steps:
You won't actually perform these steps, but write out what you would do to "fail-over" your application and database cluster to the other region. Think about all the pieces that were setup and how you would use those in the other region

* Group all 3 instances behind a load balancer and setup a DNS to point to load balancer. During a failover scenario, we could fail over the DNS entry to point to the load balancer of other working region.
* Setup replication and backup for database, config a DNS record to point to Database cluster. Whenever a disaster happens, we could fail over the DNS entry to point to other working Database cluster and that cluster becames the primary cluster. Whenever the database is tampered or be malicious, we could restore to the previous state of database from the backup.
