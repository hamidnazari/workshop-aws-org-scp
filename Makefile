# Do change
ACC2_EMAIL=

MASTER_ACC_NUMBER=
ACC1_NUMBER=
ACC2_NUMBER=

# Don't change
ACC2_NAME=Workshop Account 2
REGION=ap-southeast-2
STACKSETADMIN_STACKNAME=workshop-stackset-admin
RESTRICTEDADMIN_STACKSETNAME=workshop-restricted-admin

account2:
	@echo "Creating an Account named '$(ACC2_NAME)' using '$(ACC2_EMAIL)'"
	# Add AWS CLI command for Workshop Account 2 here

stackset-admin-roles:
	@echo "Deploying StackSet Admin Role CloudFormation Stack"
	# Add AWS CLI command for StackSet Admin Roles CloudFormation Stack here

restricted-admin-role:
	@echo "Deploying Restricted Admin Role CloudFormation StackSet"
	# Add AWS CLI command for Restricted Admin Role CloudFormation StackSet here

restricted-admin-role-accounts:
	@echo "Adding Accounts to Restricted Admin Role CloudFormation StackSet"
	# Add AWS CLI command for Restricted Admin Role CloudFormation StackSet Accounts here

region-lock-scp:
	@echo "Creating RegionLock Service Control Policy"
	# Add AWS CLI command for RegionLock Service Control Policy Creation here

region-lock-attachment:
	@echo "Attaching RegionLock Service Control Policy"
	# Add AWS CLI command for RegionLock Service Control Policy Attachment here

.PHONY: account2 stackset-admin-roles restricted-admin-role restricted-admin-role-accounts region-lock-scp
