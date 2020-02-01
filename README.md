# AWS Organizations and Service Control Policies

> **NOTE:** This repo is still a work in progress.

In this workshop we will develop a multiaccount centrally-managed AWS setup that allows its sub-accounts' users to manage their own IAM Roles and Policies without introducing Privilege Escalation vulnerabilities.

This repository is a simplified approach to implementing this model. It covers the core ideas and services used for demonstration purposes. In a real world implementation, resources need to be developed with much more care and detail. 

## Steps
We will go through the steps one by one. Each step should take about 20 minutes to complete. The instructions will cover manual steps as well as Infra as Code approach for achieving the same results.

1. Ensure your AWS CLI is configured and working with your account.
1. Ensure your account does not belong to an AWS Organization.
1. Ensure you're using the Sydney region at all times.
1. Create accounts in AWS Organizations
1. Create CloudFormation StackSets
1. Deploy RestrictedAdmin IAM entities
1. Create a Service Control Policy
