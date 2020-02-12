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
	aws organizations create-account \
		--account-name '$(ACC2_NAME)' \
		--email '$(ACC2_EMAIL)'

stackset-admin-roles:
	@echo "Deploying StackSet Admin Role CloudFormation Stack"
	# Add AWS CLI command for StackSet Admin Roles CloudFormation Stack here
	aws cloudformation $(ACTION)-stack \
		--region $(REGION) \
		--stack-name $(STACKSETADMIN_STACKNAME) \
		--capabilities CAPABILITY_NAMED_IAM \
		--template-body file://./templates/stackset-admin-roles.cf.yaml

restricted-admin-role:
	@echo "Deploying Restricted Admin Role CloudFormation StackSet"
	# Add AWS CLI command for Restricted Admin Role CloudFormation StackSet here
	aws cloudformation $(ACTION)-stack-set \
		--region $(REGION) \
		--stack-set-name $(RESTRICTEDADMIN_STACKSETNAME) \
		--capabilities CAPABILITY_NAMED_IAM \
		--administration-role-arn arn:aws:iam::$(MASTER_ACC_NUMBER):role/WorkshopCloudFormationStackSetAdministrationRole \
		--execution-role-name WorkshopCloudFormationStackSetExecutionRole \
		--template-body file://./templates/restricted-admin-role.cf.yaml \
		--parameters ParameterKey=AdministratorAccountId,ParameterValue=$(MASTER_ACC_NUMBER)

restricted-admin-role-accounts:
	@echo "Adding Accounts to Restricted Admin Role CloudFormation StackSet"
	# Add AWS CLI command for Restricted Admin Role CloudFormation StackSet Accounts here
	aws cloudformation $(ACTION)-stack-instances \
		--stack-set-name $(RESTRICTEDADMIN_STACKSETNAME) \
		--accounts $(ACC1_NUMBER) $(ACC2_NUMBER) \
		--regions $(REGION)

region-lock-scp:
	@echo "Creating RegionLock Service Control Policy"
	# Add AWS CLI command for RegionLock Service Control Policy Creation here
    aws organizations $(ACTION)-policy \
    	--content file://./templates/region-lock-scp.json \
    	--name RegionLock --description '' \
    	--type SERVICE_CONTROL_POLICY

region-lock-attachment:
	@echo "Attaching RegionLock Service Control Policy"
	# Add AWS CLI command for RegionLock Service Control Policy Attachment here
	aws organizations attach-policy --target-id $(ACC1_NUMBER) --policy-id $(POLICY_ID)
	aws organizations attach-policy --target-id $(ACC2_NUMBER) --policy-id $(POLICY_ID)

.PHONY: account2 stackset-admin-roles restricted-admin-role restricted-admin-role-accounts region-lock-scp
